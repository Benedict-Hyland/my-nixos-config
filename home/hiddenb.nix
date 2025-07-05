{ config, pkgs, ... }:

{
  imports = [
    ../modules/homemanager/waybar.nix
    ../modules/homemanager/kitty.nix
    ../modules/homemanager/rofi.nix
    ../modules/homemanager/dunst.nix
    ../modules/homemanager/firefox.nix
    ../modules/homemanager/hyprpaper.nix
    ../modules/homemanager/swww.nix
    ../modules/homemanager/neovim.nix
    ../modules/homemanager/git.nix
    ../modules/homemanager/wezterm.nix
  ];

  home.username = "hiddenb";
  home.homeDirectory = "/home/hiddenb";
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    tree
    networkmanager
    python313
    uv
    curl
    wget
    alejandra
    nerd-fonts.caskaydia-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];

  modules.homemanager.waybar.enable = true;
  modules.homemanager.kitty.enable = true;
  modules.homemanager.rofi.enable = true;
  modules.homemanager.dunst.enable = true;
  modules.homemanager.firefox.enable = true;
  modules.homemanager.hyprpaper.enable = true;
  modules.homemanager.swww.enable = true;
  modules.homemanager.neovim.enable = true;
  modules.homemanager.wezterm.enable = true;

  modules.homemanager.git = {
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

  gtk = {
    enable = true;
    font.name = "CaskaydiaMono Nerd Font";
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home.stateVersion = "25.05";
}
