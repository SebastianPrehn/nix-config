{ inputs, ... }: {
  flake.nixosConfigurations.odin = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    # specialArgs passes flake inputs into every NixOS module in this list,
    # so I can use 'inputs' in configuration.nix etc. if I ever need it.
    specialArgs = {
      inherit inputs; 
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.x86_64-linux;
      pkgs-cuda = import inputs.nixpkgs {
	system = "x86_64-linux";
	overlays = [ # overlay to update koboldcpp until pkgs has caught up
	  (final: prev: {
	    koboldcpp = prev.koboldcpp.overrideAttrs (old: {
	      version = "1.113.2";
	      src = prev.fetchFromGitHub {
		owner = "LostRuins";
		repo = "koboldcpp";
		rev = "v1.113.2";
		hash = "sha256-NWB2Nwg74AVz8gc8aa/xy56Tms9dH5osvBZuoJemJqI=";
	      };
	    });
	  })
	];
	config = {
	  allowUnfree = true;
	  cudaSupport = true;
	  cudaCapabilities = [ "8.6" ];
	};
      };
    };

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
