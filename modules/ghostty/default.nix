{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in
{
  home.packages = [ pkgs.comic-mono ];
  programs.tmux.enable = true;

  programs.ghostty = {
    enable = true;
    package = if isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = lib.mkMerge [
      {
        theme = "Nord";
        font-size = 13;
        font-family = "Comic Mono";
        command = lib.getExe config.programs.tmux.package;
        adjust-cell-height = "50%";
        desktop-notifications = true;
      }
      (lib.mkIf isDarwin {
        font-thicken = true;
        font-thicken-strength = 120;
        keybind = [ "global:cmd+shift+space=toggle_quick_terminal" ];
      })
    ];
  };
}
