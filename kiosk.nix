{ config, pkgs, lib, ... }: with lib; let
in {
  options.kiosk.url = mkOption {
    type = types.str;
    default = "https://example.com";
  };

  config = {
    # regreet?
    services.cage = {
      enable = true;
      program = "${pkgs.chromium}/bin/chromium ${config.kiosk.url} --touch-noise-filtering --start-fullscreen --window-size=1280,1024 --window-position=0,0 --kiosk --noerrdialogs --disable-infobars --disable-translate --no-first-run --fast --fast-start --disable-features=TranslateUI --disk-cache-dir=/dev/null  --password-store=basic";
    };

    # no waste space
    services.journald.storage = "volatile";

    # TODO: use overlayfs for / (but mount /nix/store + /boot normally)
  };
}
