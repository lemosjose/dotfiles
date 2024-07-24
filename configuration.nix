{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];
  boot.kernelPackages = pkgs.linuxPackages_latest;


  nix.settings.experimental-features = ["nix-command" "flakes"];

  #fonts fixing 

  fonts.packages = with pkgs; [
     font-awesome
     powerline-fonts
     powerline-symbols
  ];

  #enable my wm stuff
 
  xdg.portal.wlr.enable = true;

  security.polkit.enable = true;

  programs.sway.enable = true; 

  #mounting my external hdd :)
  services.udisks2.enable = true;
  

  #enable pipewire as suggested in the manual
  sound.enable = false; 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.pipewire.wireplumber.enable = true; 
 
  #Prettying my hostname with Garras da Patrulha' Characters
  networking.hostName = "tizil";
  
  # Pick only ONE of the available wireless options
  networking.wireless.iwd.enable = true;  # Enables wireless support via wpa_supplicant.



  ## runnning container stuff
  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;

  ##vm stuff
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;


  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
 
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
    "vscode"
    "spotify"
    "libretro-genesis-plus-gx"
    "libretro-snes9x"
  ];
  programs.steam.enable = true;
  programs.nix-ld.enable = true;

  #newer emacs for my work!
  services.emacs.package = pkgs.emacs-unstable;
  
  #bluetooth stuff
  services.blueman.enable = true;

  
  services.gvfs.enable = true;
  services.devmon.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lemos = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" "input" "audio"]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
         firefox
         tree
         keepassxc
         cmus
	 pcmanfm
	 mpv
	 streamlink
         neochat
      ];
      initialPassword = "pw123";
  };
  # List packages installed in system profile. To search, run:

  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     thunderbird
     emacs-unstable
     nodejs
     gcc
     waybar
     gammastep
     swaybg
     swayidle
     bemenu
     grim 
     texlive.combined.scheme-full
     qpdfview
     slurp
     leiningen
     wl-clipboard
     mako 
     jdk21
     alacritty
     nodePackages.typescript
     nodePackages.vue-language-server
     nodePackages.vscode-langservers-extracted
     (retroarch.override {
       cores = with libretro; [
          genesis-plus-gx
	  snes9x
	  flycast
	  beetle-saturn
	  citra
	  dosbox
	  nestopia
       ];
     })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
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

