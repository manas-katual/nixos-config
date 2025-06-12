import {Gtk} from "astal/gtk4"
import Pango from "gi://Pango?version=1.0";
import RevealerRow from "../../common/RevealerRow";
import {SystemMenuWindowName} from "../SystemMenuWindow";
import {interval, Variable} from "astal";
import {execAsync} from "astal/process";
import Divider from "../../common/Divider";
import {variableConfig} from "../../../config/config";
import {SpeedUnits, TemperatureUnits} from "../../../config/schema/definitions/systemMenuWidgets";

type HourlyWeather = {
    time: Date;
    temperature: number;
    uvIndex: number;
    isDay: number;
    weatherCode: number;
};

type DailyWeather = {
    time: Date;
    weatherCode: number;
    maxTemp: number;
    minTemp: number;
}

type Weather = {
    current: {
        temperature: number | null;
        weatherCode: number | null;
        humidity: number | null;
        windSpeed: number | null;
        isDay: number | null;
        uvIndex: number | null;
    };
    daily: DailyWeather[];
    hourly: HourlyWeather[];
};

const weather = new Variable<Weather>({
    current: {
        temperature: null,
        weatherCode: null,
        humidity: null,
        windSpeed: null,
        isDay: null,
        uvIndex: null,
    },
    daily: [],
    hourly: [],
});

let lastWeatherUpdate = 0; // in milliseconds
const WEATHER_UPDATE_INTERVAL = 15 * 60 * 1000; // 15 minutes

function updateWeather() {
    const now = Date.now();
    if (now - lastWeatherUpdate < WEATHER_UPDATE_INTERVAL) {
        console.log("Weather update skipped — too soon");
        return;
    }

    lastWeatherUpdate = now;

    const url = "https://api.open-meteo.com/v1/forecast" +
        `?latitude=${variableConfig.systemMenu.weather.latitude.get()}&longitude=${variableConfig.systemMenu.weather.longitude.get()}` +
        "&daily=weather_code,temperature_2m_max,temperature_2m_min" +
        "&hourly=temperature_2m,uv_index,is_day,weather_code" +
        "&current=temperature_2m,uv_index,weather_code,is_day,relative_humidity_2m,wind_speed_10m" +
        "&timezone=GMT" +
        `${variableConfig.systemMenu.weather.speedUnit.get() === SpeedUnits.MPH ? "&wind_speed_unit=mph" : ""}` +
        `${variableConfig.systemMenu.weather.temperatureUnit.get() === TemperatureUnits.F ? "&temperature_unit=fahrenheit" : ""}`;

    console.log("Getting weather...")
    execAsync(["curl", url])
        .then((response) => {
            const json = JSON.parse(response);

            const toDate = (str: string): Date => new Date(`${str}:00Z`);
            const dailyToDate = (str: string): Date => new Date(`${str}T00:00:00Z`);

            const c = json.current;
            const d = json.daily;
            const h = json.hourly;

            const hourly = h.time.map((_: any, i: number) => ({
                time: toDate(h.time[i]),
                temperature: h.temperature_2m[i],
                uvIndex: h.uv_index[i],
                isDay: h.is_day[i],
                weatherCode: h.weather_code[i],
            }));

            const daily = d.time.map((_: any, i: number) => ({
                time: dailyToDate(d.time[i]),
                weatherCode: d.weather_code[i],
                minTemp: d.temperature_2m_min[i],
                maxTemp: d.temperature_2m_max[i],
            }));

            weather.set({
                current: {
                    temperature: c.temperature_2m ?? null,
                    weatherCode: c.weather_code ?? null,
                    humidity: c.relative_humidity_2m ?? null,
                    windSpeed: c.wind_speed_10m ?? null,
                    isDay: c.is_day ?? null,
                    uvIndex: c.uv_index ?? null,
                },
                daily,
                hourly,
            });
        })
        .catch((error) => {
            console.log(error)
        })
        .finally(() => {
            console.log("Weather done")
        })
}

export function getWeatherIcon(code: number | null, isDay: boolean = true): string {
    const nf = {
        sun: "",         // nf-weather-day_sunny
        moon: "",        // nf-weather-night_clear
        cloudy: "",      // nf-weather-cloud
        partlyCloudyDay: "", // nf-weather-day_cloudy
        partlyCloudyNight: "", // nf-weather-night_alt_cloudy
        overcast: "",    // nf-weather-cloudy
        fog: "",         // nf-weather-fog
        drizzle: "",     // nf-weather-showers
        rain: "",        // nf-weather-rain
        thunderstorm: "", // nf-weather-storm_showers
        snow: "",        // nf-weather-snow
        sleet: "",       // nf-weather-sleet
        unknown: "",     // nf-weather-na
    };

    switch (code) {
        case 0:
            return isDay ? nf.sun : nf.moon;
        case 1:
        case 2:
            return isDay ? nf.partlyCloudyDay : nf.partlyCloudyNight;
        case 3:
            return nf.overcast;
        case 45:
        case 48:
            return nf.fog;
        case 51:
        case 53:
        case 55:
            return nf.drizzle;
        case 56:
        case 57:
            return nf.sleet;
        case 61:
        case 63:
        case 65:
            return nf.rain;
        case 66:
        case 67:
            return nf.sleet;
        case 71:
        case 73:
        case 75:
        case 77:
            return nf.snow;
        case 80:
        case 81:
        case 82:
            return nf.rain;
        case 85:
        case 86:
            return nf.snow;
        case 95:
        case 96:
        case 99:
            return nf.thunderstorm;
        default:
            return nf.unknown;
    }
}


export default function () {
    interval(1000 * 60 * 15, () => {
        updateWeather()
    })

    return <RevealerRow
        icon={weather().as((weather) => {
            return getWeatherIcon(weather.current.weatherCode, weather.current.isDay === 1)
        })}
        iconOffset={0}
        windowName={SystemMenuWindowName}
        content={
            <label
                cssClasses={["labelMediumBold"]}
                halign={Gtk.Align.START}
                hexpand={true}
                ellipsize={Pango.EllipsizeMode.END}
                label="Weather"/>
        }
        revealedContent={
            <box
                marginTop={10}
                vertical={true}
                spacing={10}>
                <label
                    label="Now"
                    cssClasses={["labelLargeBold"]}/>
                <label
                    cssClasses={["labelXL"]}
                    label={weather().as((weather) =>
                        `${getWeatherIcon(weather.current.weatherCode, weather.current.isDay === 1)}  ${weather.current.temperature?.toString()}${variableConfig.systemMenu.weather.temperatureUnit.get() === TemperatureUnits.F ? "F" : "C"}`)}/>
                <box
                    hexpand={true}
                    homogeneous={true}
                    vertical={false}>
                    <box
                        vertical={true}>
                        <label
                            cssClasses={["labelMedium"]}
                            label={weather().as((weather) =>
                                `  ${weather.current.humidity?.toString()}%`)}/>
                        <label
                            cssClasses={["labelSmall"]}
                            label="Humidity"/>
                    </box>

                    <box
                        vertical={true}>
                        <label
                            cssClasses={["labelMedium"]}
                            label={weather().as((weather) =>
                                `󱩅 ${weather.current.uvIndex?.toString()}`)}/>
                        <label
                            cssClasses={["labelSmall"]}
                            label="UV index"/>
                    </box>
                    <box
                        vertical={true}>
                        <label
                            cssClasses={["labelMedium"]}
                            label={weather().as((weather) =>
                                `  ${weather.current.windSpeed?.toString()} ${variableConfig.systemMenu.weather.speedUnit.get() === SpeedUnits.MPH ? "m/h" : "k/h"}`)}/>
                        <label
                            cssClasses={["labelSmall"]}
                            label="Wind speed"/>
                    </box>
                </box>
                <Divider/>
                <label
                    marginTop={10}
                    label="Hourly"
                    cssClasses={["labelLargeBold"]}/>
                <box
                    vertical={false}
                    hexpand={true}
                    homogeneous={true}>
                    {weather().as((weather) => {
                        if (weather.hourly === undefined) {
                            return <box/>
                        }
                        const now = new Date()
                        return weather.hourly
                            .filter((h) => h.time >= now)
                            .slice(0, 4).map((hourly) => {
                            return <box
                                vertical={true}>
                                <label
                                    cssClasses={["labelSmall"]}
                                    label={hourly.time.toLocaleTimeString([], { hour: 'numeric' })}/>
                                <label
                                    cssClasses={["labelLarge"]}
                                    label={getWeatherIcon(hourly.weatherCode, hourly.isDay === 1)}/>
                                <label
                                    cssClasses={["labelSmall"]}
                                    label={`${hourly.temperature}${variableConfig.systemMenu.weather.temperatureUnit.get() === TemperatureUnits.F ? "F" : "C"}`}/>
                                <label
                                    cssClasses={["labelSmall"]}
                                    label={`󱩅 ${hourly.uvIndex}`}/>
                            </box>
                        })
                    })}
                </box>
                <Divider/>
                <label
                    marginTop={10}
                    label="Daily"
                    cssClasses={["labelLargeBold"]}/>
                <box
                    vertical={false}
                    hexpand={true}
                    homogeneous={true}>
                    {weather().as((weather) => {
                        if (weather.daily === undefined) {
                            return <box/>
                        }
                        return weather.daily.slice(0, 4).map((daily) => {
                            return <box
                                vertical={true}>
                                <label
                                    cssClasses={["labelSmall"]}
                                    label={daily.time.toLocaleDateString([], { weekday: 'short', timeZone: 'UTC' })}/>
                                <label
                                    cssClasses={["labelLarge"]}
                                    label={getWeatherIcon(daily.weatherCode, true)}/>
                                <label
                                    cssClasses={["labelSmall"]}
                                    label={`${daily.maxTemp}${variableConfig.systemMenu.weather.temperatureUnit.get() === TemperatureUnits.F ? "F" : "C"}`}/>
                                <label
                                    cssClasses={["labelSmall"]}
                                    label={`${daily.minTemp}${variableConfig.systemMenu.weather.temperatureUnit.get() === TemperatureUnits.F ? "F" : "C"}`}/>
                            </box>
                        })
                    })}
                </box>

            </box>
        }
    />
}