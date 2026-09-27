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
  programs.tmux = {
    enable = true;
    extraConfig = ''
      	set -g status-style "bg=black,fg=brightblack"
      	set -g window-status-current-style "fg=blue,bold"
      	set -g pane-active-border-style "fg=blue"
      	set -g message-style "bg=black,fg=blue"
      	'';
  };

  programs.ghostty = {
    enable = true;
    package = if isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = lib.mkMerge [
      {
        theme = "Wilmersdorf";
        font-size = 14;
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
