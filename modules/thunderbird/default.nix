{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  programs.thunderbird = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableAppUpdate = true;
    };

    settings = {
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "mail.shell.checkDefaultClient" = false;
      "mailnews.start_page.enabled" = false;
      "mailnews.message_display.disable_remote_image" = true;
      "privacy.donottrackheader.enabled" = true;
      # newest first, threaded
      "mailnews.default_sort_type" = 18;
      "mailnews.default_sort_order" = 2;
      "mailnews.default_view_flags" = 1;
    };

    profiles.default = {
      isDefault = true;
      # Use secret keys from existing gpgp-agent instead of Thunderbird's.
      withExternalGnupg = true;
      accountsOrder = [
        "ucph"
        "gmail"
        "icloud"
      ];
    };
  };

  xdg.mimeApps = lib.mkIf isLinux {
    enable = true;
    defaultApplications."x-schema-handler/mailto" = "thunderbird.desktop";
  };
}
