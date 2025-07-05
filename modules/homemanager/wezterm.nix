{ config, lib, pkgs, ... }:

let
  cfg = config.modules.homemanager.wezterm;
in
{
  options.modules.homemanager.wezterm = {
    enable = lib.mkEnableOption "wezterm terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wezterm ];

    # Optional: Set as default terminal in systemd (for apps that rely on $TERM_PROGRAM)
    environment.variables.TERM_PROGRAM = "wezterm";
  };
}
