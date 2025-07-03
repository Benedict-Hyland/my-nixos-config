{ config, lib, pkgs, ... }:

let
  cfg = config.modules.hyprpaper;
in {
  options.modules.hyprpaper = {
    enable = lib.mkEnableOption "Hyprpaper for wallpaper management";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.hyprpaper ];

    # xdg.configFile."hypr/hyprpaper.conf".source = ../../dotfiles/hypr/hyprpaper.conf;
  };
}
