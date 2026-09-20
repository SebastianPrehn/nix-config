{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;
      defaultInitFile = true;
      alwaysEnsure = true;
      package = pkgs.emacs;
      extraEmacsPackages = epkgs: [
        epkgs.nix-mode
        epkgs.nixfmt
      ];
    };
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    client.enable = true;
  };
}
