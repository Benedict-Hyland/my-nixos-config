{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ];

  programs.firefox.enable = true;
}
