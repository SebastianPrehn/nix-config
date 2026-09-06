{
  config,
  pkgs,
  lib,
  pkgs-stable,
  pkgs-cuda,
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
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      upnix = "sudo nixos-rebuild switch --flake .#odin";
      koboldcpp = "LD_PRELOAD=/run/opengl-driver/lib/libcuda.so.1 koboldcpp";
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };
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
    stash
    xivlauncher
    suwayomi-server
    thunar
    thunar-archive-plugin
    heroic
    pkgs-stable.bottles
    wineWow64Packages.waylandFull
    pkgs-cuda.koboldcpp
    (ollama.override { acceleration = "cuda"; })
    sillytavern
    fido2-manage
    unzip
    prismlauncher
    nautilus
    librewolf
    openconnect
    qbz
  ];

  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

  services.sabnzbd = {
    enable = true;
    openFirewall = true;
    allowConfigWrite = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.whisparr = {
    enable = true;
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
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

  services.resolved = {
    enable = true;
    settings.Resolve.DNSSEC = "true";
    settings.Resolve.Domains = [ "~." ];
    settings.Resolve.FallbackDNS = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    settings.Resolve.DNSOverTLS = "true";
  };

  services.udev.packages = with pkgs; [
    vial
    libu2f-host
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
    settings.cue = true;
    settings.authfile = "/etc/token2/u2f_keys"; 
  };   


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
  services.openssh.enable = true;
  services.fail2ban.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "26.05";
}
