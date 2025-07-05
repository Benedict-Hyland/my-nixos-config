{ config, lib, pkgs, ... }:

let
  cfg = config.modules.homemanager.rofi;
in {
  options.modules.homemanager.rofi = {
    enable = lib.mkEnableOption "Rofi launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.rofi ];
  };
}
