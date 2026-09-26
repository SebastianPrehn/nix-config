{
  perSystem =
    { pkgs, ... }:
    {
      packages.koboldcpp-bin = pkgs.callPackage ../pkgs/koboldcpp-bin/package.nix { };
    };
}
