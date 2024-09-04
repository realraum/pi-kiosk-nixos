# configuration.nix
{ lib, pkgs, ... }: {
  imports = [
    ./touch.nix
  ];

  systemd.network.enable = true;

  boot.kernelParams = [
    "console=ttyS1,115200n8"
  ];

  networking.useNetworkd = true;
  networking.nftables.enable = true;
  networking.hostName = "pi-kiosk-r3";
  nix.settings.experimental-features = "nix-command flakes";

  # sudo no password
  security.sudo.wheelNeedsPassword = false;

  # wifi
  hardware.enableRedistributableFirmware = true;
}
