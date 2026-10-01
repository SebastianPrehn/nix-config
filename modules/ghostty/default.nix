{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  tmux = lib.getExe config.programs.tmux.package;

  # Attach to the "main" session, creating it with a layout if needed
  tmuxStart = pkgs.writeShellScript "tmux-start" ''
    if ! ${tmux} has-session -t main 2>/dev/null; then
       ${tmux} new-session -d -s main -n work -c "$HOME"
       ${tmux} split-window -h -t main:work -l 40% -c "$HOME"
       ${tmux} new-window -d -t main: -n shell -c "$HOME"
       ${tmux} select-pane -t main:work -L
    fi
    exec ${tmux} attach-session -t main
  '';
in
{
  home.packages = [ pkgs.comic-mono ];
  programs.tmux = {
    enable = true;
    keyMode = "vi"; # vi keys in copy mode and the command prompt
    customPaneNavigationAndResize = true; # prefix h/j/k/l to move, H/J/K/L to resize
    mouse = true; # drag to select and copy, scroll, click panes
    baseIndex = 1; # windows and panes start at 1, like the keyboard
    escapeTime = 10;
    focusEvents = true;
    historyLimit = 50000;
    terminal = "tmux-256color";
    extraConfig = ''
      	set -g status-style "bg=black,fg=brightblack"
      	set -g window-status-current-style "fg=blue,bold"
      	set -g pane-active-border-style "fg=blue"
      	set -g message-style "bg=black,fg=blue"

        # Copy the system clipboard through the terminal (OSC 52)
        set -g set-clipboard on
        set -as terminal-features ',xterm-ghostty:RGB'

        # Vim-like copy mode: v selects, C-v for a block, y copies.
        bind -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi C-v send -X rectangle-toggle
        bind -T copy-mode-vi y send -X copy-selection-and-cancel
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
        command = "${tmuxStart}";
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
