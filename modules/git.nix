{ config, lib, pkgs, ... }:

let
  cfg = config.modules.git;
in {
  options.modules.git = {
    enable = lib.mkEnableOption "Git version control and GitHub integration";

    userName = lib.mkOption {
      type = lib.types.str;
      default = "Your Name";
      description = "Git user name.";
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      default = "your@email.com";
      description = "Git user email.";
    };

    signCommits = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to sign commits.";
    };

    signingKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "GPG key ID used to sign Git commits.";
    };

    enableGitHubCLI = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to install and configure GitHub CLI (`gh`).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      git
    ] ++ lib.optional cfg.enableGitHubCLI pkgs.gh;

    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      signing = {
        key = cfg.signingKey;
        signByDefault = cfg.signCommits;
      };
    };

    programs.gh = lib.mkIf cfg.enableGitHubCLI {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    home.file.".ssh/config".text = lib.mkIf cfg.enableGitHubCLI ''
      Host github.com
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_ed25519
    '';
  };
}
