{ ... }: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 4;

        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "cpu"
          "memory"
          "tray"
          "custom/notification"
        ];
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
          };
          return-type = "json";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "niri/workspaces" = {
          # niri uses dynamic workspaces
        };

        clock = {
          format = "{:%H:%M  %a %d %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
        };

        cpu = {
          format = " {usage}%";
          interval = 5;
        };

        memory = {
          format = " {}%";
        };

        network = {
          format-ethernet = " {ipaddr}";
          format-disconnected = "⚠ Disconnected";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      @define-color bg      #282b33;
      @define-color bg-alt  #1f2024;
      @define-color surface #34373e;
      @define-color muted   #515462;
      @define-color fg      #c6c6c6;
      @define-color accent  #819cd6;
      @define-color urgent  #e1c1ee;

      * {
        font-family: "Comic Mono", "Symbols Nerd Font Mono", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: @fg;
        border-bottom: 2px solid @surface;
      }

      #workspaces button {
        padding: 0 8px;
        color: @muted;
      }

      #workspaces button.active {
        color: @accent;
        border-bottom: 2px solid @accent;
      }

      #clock, #cpu, #memory, #network, #tray, #custom-notification {
        padding: 0 10px;
        margin: 4px 2px;
        border-radius: 6px;
        background: @surface;
      }
    '';
  };
}
