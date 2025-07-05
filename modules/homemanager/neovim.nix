{ config, lib, pkgs, ... }:

let
  cfg = config.modules.homemanager.neovim;
in {
  options.modules.homemanager.neovim = {
    enable = lib.mkEnableOption "Neovim Editor";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.neovim ];

    # xdg.configFile."neovim/neovim.conf".source = ./dotfiles/neovim/neovim.conf;
  };
}
