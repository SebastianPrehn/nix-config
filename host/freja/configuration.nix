{ pkgs, inputs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.emacs-overlay.overlays.default ];

  networking.hostName = "freja";

  users.users.sebastian.home = "/Users/sebastian";
  system.primaryUser = "sebastian";

  programs.zsh.enable = true;

  environment.systemPackages = [
    pkgs.wezterm
    pkgs.zotero
    pkgs.vlc-bin
    pkgs.ghostty-bin
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ]; 
    ssl-cert-file = "/etc/ssl/cert.pem";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    screencapture.location = "~/Pictures/screenshots";
  };

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
