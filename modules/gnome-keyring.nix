{ config, lib, pkgs, ... }:

let
  cfg = config.modules.gnome-keyring;
in {
  options.modules.gnome-keyring.enable =
    lib.mkEnableOption "Enable GNOME Keyring for secrets management";

  config = lib.mkIf cfg.enable {
    services.gnome-keyring = {
      enable = true;
      components = [ "secrets" ]; # Add "ssh" or "pkcs11" if needed
    };

    systemd.user.services.gnome-keyring-daemon = {
      Service.Environment = [ "XDG_CURRENT_DESKTOP=GNOME" ];
    };

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "GNOME";
    };
  };
}
