{ pkgs, lib, ... }:
{
  config = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    services.protonmail-bridge.enable = true;
  };
}
