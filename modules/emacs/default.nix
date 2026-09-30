{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;

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
    ".emacs.d/elfeed.org".source = ./modules/tool/elfeed/elfeed.org;
  };

  home.packages = with pkgs; [
    nerd-fonts.symbols-only
    comic-mono
    nixfmt
    nixd
    futhark
    clang-tools
    pandoc
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
          grammars.tree-sitter-rust
          grammars.tree-sitter-toml
        ]))
      ];
    };
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    client.enable = true;
  };

  # On MacOS, start the daemon from inside Emacs.app so its frame count as a
  # regular app (Dock, Cmd+Tab) instead of an unbundled background process.
  launchd.agents.emacs.config.ProgramArguments = lib.mkIf isDarwin (
    lib.mkForce [
      "${config.services.emacs.package}/Applications/Emacs.app/Contents/MacOS/Emacs"
      "--fg-daemon"
    ]
  );
}
