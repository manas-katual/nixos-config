{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/broadcom.nix
  ];

  sway.enable = true;

  environment = {
    systemPackages = with pkgs; [
      nchat # whatsapp & telegram tui-client
      ripcord # dicord client
      youtube-tui # youtube client
    ];
  };

}
