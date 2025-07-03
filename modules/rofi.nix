{ config, lib, pkgs, ... }:

let
  cfg = config.modules.rofi;
in {
  options.modules.rofi = {
    enable = lib.mkEnableOption "Rofi launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.rofi ];
  };
}
