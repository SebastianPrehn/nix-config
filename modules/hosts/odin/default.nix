{ self, inputs, ... }: {
    
  flake.nixosConfigurations.odin = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.odinConfiguration
    ];
  };
}
