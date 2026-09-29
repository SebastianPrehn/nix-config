{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [

  ];

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };

  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
    colorschemes.nord = {
      enable = true;
      settings = {
        borders = true;
        contrast = true;
      };
    };
    diagnostic.settings = {
      update_in_insert = true;
      severity_sort = true;
      signs = true;
      float = {
        source = "always";
        border = "rounded";
      };
      jump = {
        severity.__raw = "vim.diagnostic.severity.WARN";
      };
    };
    lsp = {
      luaConfig.post = ''
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
      '';
      inlayHints.enable = true;
      servers = {
        docker_language_server.enable = true;
        just.enable = true;
        jsonls.enable = true;
        markdown_oxide.enable = true;
        nixd.enable = true;
        futhark_lsp.enable = true;
        ghcide.enable = true;
        rust_analyzer.enable = true;
      };
    };
  };
}
