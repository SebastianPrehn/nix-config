{ config, pkgs, ... }:
{

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # needed for steam/wine
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "1";
  };

  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
