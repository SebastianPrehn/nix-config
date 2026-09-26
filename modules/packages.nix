{
  perSystem =
    { pkgs, lib, ... }:
    {
      # Linux only:
      packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        koboldcpp-bin = pkgs.callPackage ../pkgs/koboldcpp-bin/package.nix { };
      };
    };
}
