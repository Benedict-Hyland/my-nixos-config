{ config, lib, pkgs, ... }:

let
  cfg = config.modules.homemanager.firefox;
in {
  options.modules.homemanager.firefox = {
    enable = lib.mkEnableOption "Firefox browser";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
