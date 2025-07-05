{ config, pkgs, lib, ... }:

let
  cfg = config.modules.docker;
in {
  options.modules.docker = {
    enable = lib.mkEnableOption "Docker and Docker Compose";
    username = lib.mkOption {
      type = lib.types.str;
      description = "Username to add to the docker group";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;

    users.users.${cfg.username}.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];
  };
}
