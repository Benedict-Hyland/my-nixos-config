{ config, lib, pkgs, ... }:

let
  cfg = config.modules.homemanager.dunst;
in {
  options.modules.homemanager.dunst = {
    enable = lib.mkEnableOption "Dunst notification daemon";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.dunst ];

    # xdg.configFile."dunst/dunstrc".source = ../../dotfiles/dunst/dunstrc;
  };
}
