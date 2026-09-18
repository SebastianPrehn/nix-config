{ pkgs, ... }: {
  programs.niri.enable = true;

  # xwayland-satellite provides X11 app support under niri.
  # It will be started per-user from home-manager's niri config.
  environment.systemPackages = [ pkgs.xwayland-satellite ];    
}
