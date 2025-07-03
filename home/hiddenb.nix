{ config, pkgs, ... }:

{
  imports = [
    ../modules/waybar.nix
    ../modules/kitty.nix
    ../modules/rofi.nix
    ../modules/dunst.nix
    ../modules/firefox.nix
    ../modules/hyprpaper.nix
    ../modules/swww.nix
    ../modules/neovim.nix
    ../modules/git.nix
  ];

  home.username = "hiddenb";
  home.homeDirectory = "/home/hiddenb";

  home.packages = with pkgs; [
    tree
  ];

  modules.waybar.enable = true;
  modules.kitty.enable = true;
  modules.rofi.enable = true;
  modules.dunst.enable = true;
  modules.firefox.enable = true;
  modules.hyprpaper.enable = true;
  modules.swww.enable = true;
  modules.neovim.enable = true;

  modules.git = {
    enable = true;
    userName = "Benedict-Hyland";
    userEmail = "benedicthyland@gmail.com";
    signCommits = false;
    signingKey = "41DDD88AE28AF93E";
    enableGitHubCLI = true;
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  home.stateVersion = "25.05";
}
