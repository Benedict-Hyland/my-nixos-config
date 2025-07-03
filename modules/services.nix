{ config, pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.printing.enable = true;
}
