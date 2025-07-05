{ config, lib, pkgs, ... }:

let
  cfg = config.modules.homemanager.swww;
in {
  options.modules.homemanager.swww = {
    enable = lib.mkEnableOption "Swww wallpaper daemon for Wayland";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.swww ];
    # You can configure swww startup from Hyprland or a systemd user service later
  };
}
