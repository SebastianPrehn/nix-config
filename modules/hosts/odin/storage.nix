{ config, pkgs, ... }:

{
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/DATA";
    fsType = "ntfs3";

    options = [
      "rw"
      "uid=1000"
      "umask=022"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-label/Media-Drive";
    fsType = "ntfs3";

    options = [
      "rw"
      "uid=1000"
      "umask=022"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/mnt/sharkoon" = {
    device = "/dev/disk/by-label/Sharkoon";
    fsType = "exfat";

    options = [
      "rw"
      "uid=1000"
      "umask=022"
      "nofail"
      "x-systemd.automount"
    ];
  };
}
