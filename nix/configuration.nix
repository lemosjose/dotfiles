{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./gnome.nix
    ];

  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;
  xdg.portal.config.common.default = "*";
  hardware.graphics.enable = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];
#  boot.kernelPackages = pkgs.linuxPackages.extend (lpFinal: lpPrev: {
 #     cpupower = lpPrev.cpupower.overrideAttrs (old: {
 #       nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.which ];
 #       makeFlags = (old.makeFlags or []) ++ [ "INSTALL_NO_TRANSLATIONS=1" ];
 #     });
 # });

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.dconf.enable = true;
  programs.nix-ld.enable = true;

  #fonts fixing 

  fonts.packages = with pkgs; [
     font-awesome
     powerline-fonts
     powerline-symbols
  ];

  services.udev.enable = true; 

  services.udev.packages = [
     pkgs.android-udev-rules
  ];

  xdg.portal.wlr.enable = true;

  security.polkit.enable = true;

  services.touchegg.enable = true; 


  #mounting my external hdd :)
  services.udisks2.enable = true;

  xdg.portal.xdgOpenUsePortal = true;

  #i hate zen browser sometimes
  services.flatpak.enable = true;


  powerManagement.cpuFreqGovernor = "performance";

  #enable pipewire as suggested in the manual
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.pathsToLink = [ "/libexec" ];
  environment.localBinInPath = true;

  services.pipewire.wireplumber.enable = true; 
 
  #Prettying my hostname with 'Garras da Patrulha' Characters
  networking.hostName = "tizil";
  
  # Pick only ONE of the available wireless options
  networking.wireless.iwd.enable = true;  # Enables wireless support via wpa_supplicant.



  ## runnning container stuff
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  virtualisation.docker.rootless = {
    enable = true; 
    setSocketVariable = true;
  }; 

  ##vm stuff
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";


  #newer emacs for my work!
  services.emacs.package = pkgs.emacs-unstable;
  

  
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.devmon.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];


  programs.zsh.enable = true;

  programs.thunar.enable = true;

  users.defaultUserShell = pkgs.zsh;


  programs.adb.enable = true;

  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  networking.firewall = { 
     enable = true;
     allowedTCPPorts = [ 8080
                         9090
                         1234
     ];
  };
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

