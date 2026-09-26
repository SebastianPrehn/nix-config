{ pkgs, ... }:
{
  imports = [ ./common.nix ];

  # First generation of home-manager on this machine
  home.stateVersion = "26.05";

  services.gpg-agent.pinentry.package = pkgs.pinentry_mac;
}
