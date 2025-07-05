{ config, lib, pkgs, ... }:

let
  cfg = config.modules.homemanager.kitty;
in {
  options.modules.homemanager.kitty = {
    enable = lib.mkEnableOption "Kitty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.kitty ];

    # xdg.configFile."kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
  };
}
