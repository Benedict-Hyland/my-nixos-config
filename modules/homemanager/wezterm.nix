# home-manager/users/hiddenb/wezterm.nix
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.homemanager.wezterm;
in {
  options.modules.homemanager.wezterm.enable = lib.mkEnableOption "Enable wezterm terminal";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ wezterm ];
  };
}
