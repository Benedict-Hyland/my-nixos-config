{ config, lib, pkgs, ... }:

let
  cfg = config.modules.dunst;
in {
  options.modules.dunst = {
    enable = lib.mkEnableOption "Dunst notification daemon";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.dunst ];

    # xdg.configFile."dunst/dunstrc".source = ../../dotfiles/dunst/dunstrc;
  };
}
