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
    bitwarden-desktop
    prowlarr
    sabnzbd
    suwayomi-server
    thunar
    heroic
    pkgs-stable.bottles
    wineWow64Packages.waylandFull
    pkgs-cuda.koboldcpp
    (ollama.override { acceleration = "cuda"; })
    sillytavern
    fido2-manage
    mullvad-vpn
  ];

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

  system.stateVersion = "25.11";
}
