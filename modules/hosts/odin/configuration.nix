    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "odin"; 
      networking.networkmanager.enable = true;

      time.timeZone = "Europe/Copenhagen";

      i18n.defaultLocale = "en_DK.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "da_DK.UTF-8";
        LC_IDENTIFICATION = "da_DK.UTF-8";
        LC_MEASUREMENT = "da_DK.UTF-8";
        LC_MONETARY = "da_DK.UTF-8";
        LC_NAME = "da_DK.UTF-8";
        LC_NUMERIC = "da_DK.UTF-8";
        LC_PAPER = "da_DK.UTF-8";
        LC_TELEPHONE = "da_DK.UTF-8";
        LC_TIME = "da_DK.UTF-8";
      };

      services.xserver.xkb = {
        layout = "dk";
        variant = "";
      };
      console.keyMap = "dk-latin1";

      users.users.sebastian = {
        isNormalUser = true;
        description = "Sebastian Larsen Prehn";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      nixpkgs.config.allowUnfree = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      environment.systemPackages = with pkgs; [
        vim
        wget
        git
        curl
        firefox
        nixpkgs-fmt
        nixfmt
	ghostty
	fuzzel
	xwayland-satellite
	awww
	vlc
	vial
      ];

      services.udev.packages = with pkgs; [
	vial
      ];
      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.niri}/bin/niri-session";
            user = "sebastian";
          };
        };
      };
      # Enable the OpenSSH daemon.
      #services.openssh.enable = true;
      #services.fail2ban.enable = true; 

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      system.stateVersion = "25.11";
}
