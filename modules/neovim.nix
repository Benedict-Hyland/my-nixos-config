{ config, lib, pkgs, ... }:

let
  cfg = config.modules.neovim;
in {
  options.modules.neovim = {
    enable = lib.mkEnableOption "Neovim Editor";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.neovim ];

    # xdg.configFile."neovim/neovim.conf".source = ./dotfiles/neovim/neovim.conf;
  };
}
