{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        settings.global.excludes = [
          "*.lock"
          ".gitignore"
        ];
        programs.nixfmt.enable = true;
        programs.deadnix.enable = true;
      };
      packages.default = pkgs.mkShell {
        packages = [
          pkgs.just
          pkgs.nh
        ];
      };
    };
}
