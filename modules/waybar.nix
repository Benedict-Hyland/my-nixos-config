{ config, lib, pkgs, ... }:

let
  cfg = config.modules.waybar;
in {
  options.modules.waybar = {
    enable = lib.mkEnableOption "Waybar status bar for Hyprland and Wayland";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.waybar ];

    # xdg.configFile."waybar/config".source = ./dotfiles/waybar/config;
    # xdg.configFile."waybar/style.css".source = ./dotfiles/waybar/style.css;
  };
}
