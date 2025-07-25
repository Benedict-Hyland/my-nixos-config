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
    ../modules/gnome-keyring.nix
  ];

  home.username = "hiddenb";
  home.homeDirectory = "/home/hiddenb";
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    home-manager
    tree
    networkmanager
    python313
    uv
    curl
    wget
    alejandra
    bat
    go
    ripgrep
    vscode
    windsurf
    code-cursor
    libsecret
    seahorse
    cronie
    gcc
    volta
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
  modules.gnome-keyring.enable = true;

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
    pinentry.package = pkgs.pinentry-tty;
  };

  gtk = {
    enable = true;
    font.name = "CaskaydiaMono Nerd Font";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  programs.bash.shellAliases = {
    nixos-build = "~/System/scripts/nixos-build.sh";
  };
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.file.".local/bin/nixos-build".source = ../scripts/nixos-build.sh;


  home.stateVersion = "25.05";
}
