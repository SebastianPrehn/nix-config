{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ../modules/niri
    ../modules/waybar
  ];

  home.stateVersion = "25.11";

  services.gpg-agent.pinentry.package = pkgs.pinentry-qt;

  programs.zsh.shellAliases = {
    kuvpn = "nmcli --ask con up KUVPN";
    kuvpn-down = "nmcli con down KUVPN";
    proton-dk = "nmcli con up dk-1-DK-55";
    proton-dk-down = "nmcli con down dk-1-DK-55";
    torrent-dk = "nmcli con up torrent-dk-51";
    torrent-dk-down = "nmcli con down torrent-dk-51";
  };

  home.packages = [ pkgs.discord ];
  fonts.fontconfig.enable = true;
}
