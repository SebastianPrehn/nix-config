{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.nixfmt
    ];
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    client.enable = true;
  };
}
