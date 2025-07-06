{ config, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    environment = {
      QT_SCALE_FACTOR = "2";
      QT_FONT_DPI = "192";
      XCURSOR_SIZE = "48";
    };
    settings = {
      General = {
        Numlock = "on";
      };
      X11 = {
        ServerArguments = "-dpi 192";
      };
    };
  };
  services.printing.enable = true;
}
