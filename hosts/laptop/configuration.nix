{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/bootloader.nix
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/gnome.nix
    ../../modules/audio.nix
    ../../modules/user.nix
    ../../modules/packages.nix
    ../../modules/services.nix
    ../../modules/nix-settings.nix
  ];

  # Packages to enable
  modules.networking.enable = true;
  modules.desktop.hyprland.enable = true;
  modules.desktop.gnome.enable = true;

  system.stateVersion = "25.05";
}
