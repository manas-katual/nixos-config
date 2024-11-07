{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ 
  (import ../../modules/hardware/dell);

  sway.enable = true;

  environment = {
    systemPackages = with pkgs; [
      nchat # whatsapp & telegram tui-client
      ripcord # dicord client
      youtube-tui # youtube client
    ];
  };

}
