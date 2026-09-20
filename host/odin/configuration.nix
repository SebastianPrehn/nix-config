{
  pkgs,
  pkgs-stable,
  pkgs-cuda,
  inputs,
  ...
}:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "odin";
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openconnect
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
    allowPing = true;
    logRefusedConnections = true;
    checkReversePath = "loose";
  };

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
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };

  nixpkgs.overlays = [ inputs.emacs-overlay.overlays.default ];

  programs.zsh.enable = true;

  programs.niri.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true; # needed for Steam/wine
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "1";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    firefox
    ghostty
    fuzzel
    xwayland-satellite
    awww
    vlc
    vial
    stash
    xivlauncher
    thunar
    thunar-archive-plugin
    heroic
    pkgs-stable.bottles
    wineWow64Packages.waylandFull
    pkgs-cuda.koboldcpp
    (ollama.override { acceleration = "cuda"; })
    sillytavern
    #fido2-manage
    unzip
    prismlauncher
    nautilus
    librewolf
    networkmanagerapplet
    dig
  ];

  services.sabnzbd = {
    enable = true;
    openFirewall = false;
    allowConfigWrite = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = false;
  };

  services.whisparr = {
    enable = true;
    openFirewall = false;
  };

  services.sonarr = {
    enable = true;
    openFirewall = false;
  };

  services.suwayomi-server = {
    enable = true;
    settings.server.port = 4567;
  };

  users.groups.media.gid = 990;
  users.users.whisparr.extraGroups = [ "media" ];
  users.users.sabnzbd.extraGroups = [ "media" ];
  users.users.sonarr.extraGroups = [ "media" ];
  systemd.services.whisparr.unitConfig.RequiresMountsFor = [ "/mnt/media" ];
  systemd.services.whisparr.serviceConfig.ReadWritePaths = [ "/mnt/media" ];
  systemd.services.sonarr = {
    unitConfig.RequiresMountsFor = [ "/mnt/sharkoon" ];
    serviceConfig.ReadWritePaths = [ "/mnt/sharkoon" ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/sabnzbd/Downloads            0755 sabnzbd sabnzbd - -"
    "d /var/lib/sabnzbd/Downloads/incomplete 0700 sabnzbd sabnzbd - -"
    "d /var/lib/sabnzbd/Downloads/complete   2775 sabnzbd media   - -"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  security.pam.u2f = {
    enable = true;
    control = "sufficient";
    settings = {
      interactive = true;
      cue = true;
      origin = "pam://yubi";
      authfile = pkgs.writeText "u2f-mappings" ''
        sebastian:GwKVJcW+ATlUlc2EzK6SagW1qlZaq6Pz1TAOGqbpjC9k7K+3OdUloWrXjQv8Bqa/NB1V28iNsIlDYUE4652xpw==,M17pAc9lp2gMIk763dBNIg99v8Zv5OeO3RHdNlwLCKuiWaCaKjJnxULUa214gZWlsmkrolVfdUza1pam3LhOcw==,es256,+presence
      '';
    };
  };

  # List services that you want to enable:
  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = "sebastian";
      };
    };

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false; # keys only
        PermitRootLogin = "no";
      };
    };

    resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = "false";
        Domains = [ ];
        DNSOverTLS = "opportunistic";
      };
    };

    fail2ban.enable = true;

    pcscd.enable = true;
    udev.packages = with pkgs; [
      vial
      libu2f-host
      yubikey-personalization
    ];
  };

  system.stateVersion = "26.05";
}
