{ config, pkgs, ... }:

{
  users.users.hiddenb = {
    isNormalUser = true;
    description = "Benedict Hyland";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

}
