/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 3; /* border pixel of windows */
static const unsigned int gappx = 4;    /* gaps between windows */
static const unsigned int snap = 32;    /* snap pixel */
static const unsigned int systraypinning =
    0; /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor
          X */
static const unsigned int systrayonleft =
    0; /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst =
    1; /* 1: if pinning fails, display systray on the first monitor, False:
          display systray on the last monitor*/
static const int showsystray = 1; /* 0 means no systray */
static const int showbar = 1;     /* 0 means no bar */
static const int topbar = 1;      /* 0 means bottom bar */
static const int user_bh = 0; /* 0 means that dwm will calculate bar height, >=
                                 1 means dwm will user_bh as bar height */
static const int vertpad = 2; /* vertical padding of bar */
static const int sidepad = 0; /* horizontal padding of bar */
static const char *fonts[] = {"Intel One Mono:size=12"};
// static const char dmenufont[]            = "Ubuntu Mono Bold:size=10";

// Gruvbox colors
static const char col_gray1[] = "#282828"; // Dark grayish background
static const char col_gray2[] = "#504945"; // Darker gray for borders
static const char col_gray3[] = "#ebdbb2"; // Light foreground color
static const char col_gray4[] =
    "#fbf1c7";                          // Very light gray for highlighted text
static const char col_bg[] = "#1d2021"; // Gruvbox background color
static const char col_fg[] = "#ebdbb2"; // Light text color
static const char col_comment[] = "#928374"; // Comment color (faded gray)
static const char col_cyan[] = "#8ec07c";    // Cyan accent
static const char col_green[] = "#a9b665";   // Gruvbox green
static const char col_orange[] = "#d65d0e";  // Orange
static const char col_pink[] = "#d3869b";    // Pink
static const char col_purple[] = "#b16286";  // Purple
static const char col_red[] = "#fb4934";     // Red
static const char col_yellow[] = "#fabd2f";  // Yellow

static const char *colors[][3] = {
    /*                 fg         bg         border   */
    [SchemeNorm] = {col_fg, col_bg, col_cyan},
    [SchemeSel] = {col_fg, col_purple, col_yellow},
};

static const char *const autostart[] = {
    //"blueman-manager", NULL,
    //"syncthing", NULL,
    "emacs", "--daemon", "&", NULL,
    //"lxsession", NULL,
    //"volctl", NULL,
    "flameshot", NULL,
    //"qbittorrent", NULL,
    //"picom", NULL,
    "pavucontrol", NULL, "dwmblocks", NULL, NULL /* terminate */
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class                 instance     title       tags mask     isfloating
       monitor */
    //{ "Gimp",                  NULL,       NULL,       1<<4,            0, -1
    //}, { "Saucedacity",           NULL,       NULL,       1<<4,            0,
    //-1 }, { "kdenlive",              NULL,       NULL,       1<<4, 0, -1 },
    {"Virt-manager", NULL, NULL, 1 << 3, 0, -1},
    //{ "Brave-browser",         NULL,       NULL,       2,               0, -1
    //}, { "qutebrowser",           NULL,       NULL,       2,               0,
    //-1 }, { "LibreWolf",             NULL,       NULL,       2, 0, -1 },
    {"qBittorrent", NULL, NULL, 1 << 8, 0, -1},
    //{ "Pcmanfm",               NULL,       NULL,       1<<2,            0, -1
    //}, { "firefox",               NULL,       NULL,       2,               0,
    //-1 }, { "KotatogramDesktop",     NULL,       NULL,       1<<5, 0, -1 },
    {"pavucontrol", NULL, NULL, 1 << 6, 0, 0},
    {"Blueberry.py", NULL, NULL, 1 << 6, 0, 0},
    //{ "Lxappearance",          NULL,       NULL,       1<<7,            0, -1
    //}, { "Bitwarden",             NULL,       NULL,       1<<7,            0,
    //-1 },
};

/* layout(s) */
static const float mfact = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;   /* number of clients in master area */
static const int resizehints =
    1; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[tile]", tile},  /* first entry is default */
    {"[float]", NULL}, /* no layout function means floating behavior */
    {"[Monocle]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},    \
      {Mod1Mask, KEY, focusnthmon, {.i = TAG}},                                \
      {Mod1Mask | ShiftMask, KEY, tagnthmon, {.i = TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static const char *rofidrun[] = {"rofi", "-show", "drun", NULL};
// static const char *dmenucmd[]             = { "dmenu_run", "-c", "-l", "20",
// NULL };
static const char *termcmd[] = {"kitty", NULL};
static const char *browser[] = {"google-chrome-stable", NULL};
static const char *files[] = {"thunar", NULL};
static const char *emacsclient[] = {"emacsclient", "-c", "-a", "'emacs'", NULL};
static const char *shutdown[] = {"shutdown", "now", NULL};
// static const char *reboot[]               = { "reboot", NULL };
static const char *screenshot[] = {"flameshot", "gui", NULL};

static const Key keys[] = {
    /* modifier                     key        function        argument */
    //{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd
    //} },
    {MODKEY, XK_r, spawn, {.v = rofidrun}},
    {MODKEY, XK_Return, spawn, {.v = termcmd}},
    {MODKEY | ShiftMask, XK_b, spawn, {.v = browser}},
    {MODKEY | ShiftMask, XK_p, spawn, {.v = files}},
    {MODKEY | ShiftMask, XK_s, spawn, {.v = shutdown}},
    //{ MODKEY|ShiftMask,             XK_r,      spawn,          {.v = reboot }
    //},
    {MODKEY, XK_e, spawn, {.v = emacsclient}},
    {MODKEY, XK_Print, spawn, {.v = screenshot}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY | ShiftMask, XK_Return, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY, XK_q, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_space, setlayout, {0}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY | ShiftMask, XK_f, togglefullscr, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_Left, focusmon, {.i = -1}},
    {MODKEY, XK_Right, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_Left, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_Right, tagmon, {.i = +1}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8){MODKEY | ShiftMask, XK_q, quit, {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
