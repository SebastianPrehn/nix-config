{ pkgs, lib, ... }: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    
    settings = {
      mainBar = {
	layer = "top";
	position = "top";
        height = 32;
        spacing = 4;

        modules-left   = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right  = [ "network" "cpu" "memory" "tray" ];

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
      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
        border-bottom: 2px solid #313244;
      }

      #workspaces button {
        padding: 0 8px;
        color: #6c7086;
      }

      #workspaces button.active {
        color: #cba6f7;
        border-bottom: 2px solid #cba6f7;
      }

      #clock, #cpu, #memory, #network, #tray {
        padding: 0 10px;
        margin: 4px 2px;
        border-radius: 6px;
        background: #313244;
      }
    '';
  };
}
