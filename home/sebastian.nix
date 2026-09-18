{ pkgs, lib, ... }: {
  home.username = "sebastian";
  home.homeDirectory = "/home/sebastian";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  imports = [
    ../modules/home-manager/niri
    ../modules/home-manager/waybar
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sebastian Larsen Prehn";
	email = "slp@sebastianprehn.dk";
        signingKey = "0xA14DA60EC4964E9E";
      };
      commit = {
        gpgsign = true;
      };
    };
  };

  programs.gpg = {
    enable = true;

    scdaemonSettings = {
      disable-ccid = true;
    };

    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-fingerprint = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
    };
  };


  programs.yazi = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.nixfmt
    ];
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    client.enable = true;
  };  

  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    pinentry.package = pkgs.pinentry-curses;
    extraConfig = ''
      ttyname $GPG_TTY
    '';
  };

  home.packages = with pkgs; [ 
    discord
    nerd-fonts.jetbrains-mono
   
  ];
  fonts.fontconfig.enable = true;

}
