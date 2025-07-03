{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.desktop.gnome;
in {
  options.modules.desktop.gnome = {
    enable = mkEnableOption "GNOME desktop environment";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };

  # services.xserver.xkb = {
  #   layout = "gb";
  #   variant = "";
  # };
}
