{ pkgs, inputs, ... }:
{
  imports = [
    "${inputs.private}/accounts.nix"
    ../modules/emacs
    ../modules/ghostty
    ../modules/thunderbird
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sebastian Larsen Prehn";
        email = "slp@sebastianprehn.dk";
        signingKey = "0xA14DA60EC4964E9E";
      };
      commit.gpgsign = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases.ll = "ls -l";
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

      palette = "wilmersdorf";
      palettes.wilmersdorf = {
        accent = "#819cd6";
        teal = "#7ebebd";
        violet = "#b0a2e7";
        yellow = "#cfcf9c";
        lilac = "#e1c1ee";
      };

      directory.style = "bold accent";
      git_branch.style = "teal";
      git_status.style = "lilac";
      nix_shell.style = "violet";
      cmd_duration.style = "yellow";
      character = {
        success_symbol = "[❯](accent)";
        error_symbol = "[❯](lilac)";
      };
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = true;
    withPython3 = true;
  };

  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
