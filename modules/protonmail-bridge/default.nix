{ pkgs, lib, ... }:
{
  config = lib.mkif pkgs.stdenv.hostPlatform.isLinux {
    services.protonmail-bridge.enable = true;
  };
}
