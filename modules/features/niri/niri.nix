{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {

      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.keyboard.xkb.layout = "dk";

          layout.gaps = 5;

          binds = {
            "Mod+Shift+T".show-hotkey-overlay = _: { };
            "Mod+T".spawn-sh = lib.getExe pkgs.ghostty;
            "Mod+D".spawn-sh = lib.getExe pkgs.fuzzel;
            "Mod+Q".close-window = _: { };
          };
        };
      };
    };
}
