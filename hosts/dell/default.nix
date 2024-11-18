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

    zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100;
    priority = 999;
  };
	boot.kernel.sysctl."vm.page-cluster" = 0;

}
