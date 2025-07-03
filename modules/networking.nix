{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.networking;
in {
  options.modules.networking = {
    enable = mkEnableOption "custom networking configuration";
  };

  config = mkIf cfg.enable {
    networking.hostName = "hiddennode";
    networking.networkmanager.enable = true;
  };
}
