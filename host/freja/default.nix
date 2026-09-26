{ inputs, ... }:
{
  flake.darwinConfigurations.freja = inputs.nix-darwin.lib.darwinSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ./configuration.nix
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-backup";
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.sebastian = import ../../home/freja.nix;
      }
    ];
  };
}
