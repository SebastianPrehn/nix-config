{ inputs, ... }: {
  flake.nixosConfigurations.odin = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    # specialArgs passes flake inputs into every NixOS module in this list,
    # so I can use 'inputs' in configuration.nix etc. if I ever need it.
    specialArgs = { inherit inputs; };

    modules = [ 
      ./configuration.nix
      ./hardware.nix
      ./storage.nix
      ../../features/niri/niri.nix
      ../../features/gaming/gaming.nix

      # home-manager as a NixOS module (manages dotfiles)
      inputs.home-manager.nixosModules.home-manager
      {
	home-manager.useGlobalPkgs = true; # use system pkgs
	home-manager.useUserPackages = true; # install user pkgs via nixpkgs
	home-manager.extraSpecialArgs = { inherit inputs; };
	home-manager.users.sebastian = import ../../home/sebastian.nix;
      }
    ];
  };
}
