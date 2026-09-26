{ pkgs, lib, ... }:
let
  moduleConfigs = builtins.filter (f: lib.hasSuffix "config.el" (toString f)) (
    lib.filesystem.listFilesRecursive ./modules
  );

  packageManifest = pkgs.writeText "package-manifest.el" (
    builtins.readFile ./init.el
    + "\n"
    + lib.concatMapStrings (f: builtins.readFile f + "\n") moduleConfigs
  );
in
{
  home.file = {
    ".emacs.d/early-init.el".source = ./early-init.el;
    ".emacs.d/init.el".source = ./init.el;
    ".emacs.d/lisp".source = ./lisp;
    ".emacs.d/modules".source = ./modules;
    ".emacs.d/elfeed.org".source = ./modules/misc/elfeed/elfeed.org;
  };

  home.packages = [
    pkgs.nerd-fonts.symbols-only
    pkgs.nixfmt
    pkgs.nixd
    pkgs.futhark
    pkgs.clang-tools
    pkgs.pandoc
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = packageManifest;
      alwaysEnsure = true;
      package = pkgs.emacs;
      extraEmacsPackages = epkgs: [
        (epkgs.treesit-grammars.with-grammars (grammars: [
          grammars.tree-sitter-cpp
          grammars.tree-sitter-cuda
        ]))
      ];
    };
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    client.enable = true;
  };
}
