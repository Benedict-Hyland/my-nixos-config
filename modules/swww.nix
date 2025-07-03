{ config, lib, pkgs, ... }:

let
  cfg = config.modules.swww;
in {
  options.modules.swww = {
    enable = lib.mkEnableOption "Swww wallpaper daemon for Wayland";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.swww ];
    # You can configure swww startup from Hyprland or a systemd user service later
  };
}
