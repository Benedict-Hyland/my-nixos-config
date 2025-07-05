{
  description = "My PC Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # dotfiles.url = "github:basecamp/omarchy";
  };

  outputs = {self, nixpkgs, home-manager, ...}@inputs: {
    nixosConfigurations.hiddennode = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/laptop/configuration.nix
        home-manager.nixosModules.home-manager
        ./modules/docker.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.hiddenb = import ./home/hiddenb.nix;
        }
      ];
    };
  };
}
