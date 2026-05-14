{ pkgs, lib, ... }: {
  home.username = "sebastian";
  home.homeDirectory = "/home/sebastian";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  imports = [
    ../features/niri/home.nix
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sebastian Larsen Prehn";
	email = "slp@sebastianprehn.dk";
      };
    };
  };

  programs.yazi = {
    enable = true;
  };
  home.packages = with pkgs; [ 
    discord
  ];

}
