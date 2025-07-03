{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "Hyprland desktop environment";
  };

  config = mkIf cfg.enable {
    # Enable the Wayland display server and Hyprland
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Optional: Enable PipeWire if not already enabled elsewhere
    # services.pipewire.enable = true;

    # Set keymap for X11 apps (some still use it under Wayland)
    services.xserver.xkb = {
      layout = "gb";
      variant = "";
    };
  };
}
