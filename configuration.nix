{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      #notebook and powersave stuff 
      ./laptop.nix
    ];

  nixpkgs.config.allowUnfree = true;
  xdg.portal.config.common.default = "*";
  hardware.opengl.enable = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  nix.settings.experimental-features = ["nix-command" "flakes"];

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

  #mounting my external hdd :)
  services.udisks2.enable = true;

  #i hate zen browser sometimes
  services.flatpak.enable = true;

  #enable pipewire as suggested in the manual
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.pathsToLink = [ "/libexec" ];

  services.displayManager = {
    defaultSession = "none+i3";
  };

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager.sessionCommands = ''
       sh ~/screen.sh
    '';

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

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

  #run unpatched binaries

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
 
  programs.nix-ld.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lemos = {
      isNormalUser = true;
      extraGroups = ["adbusers" "wheel" "libvirtd" "input" "audio" "docker"]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
         tree
	 tmux
	 xss-lock
	 session-desktop-appimage
	 sbcl
	 clojure-lsp
	 dex
	 docker-compose
	 geeqie
	 transmission-qt
	 firefox
	 firejail
	 feh
	 picom
	 arandr
	 yt-dlp
         keepassxc
         cmus
	 xorg.xinit
	 arandr
	 mpv
	 bottom
	 konsole
	 python312Full
	 koodo-reader
	 mplayer
	 kitty
	 palemoon-bin
	 nitrogen
	 scrcpy
	 flameshot
	 zeal
	 tokyonight-gtk-theme
	 element-desktop
	 hexchat
	 asciidoctor-with-extensions
	 volumeicon
	 postman
	 streamlink
      ];
      initialPassword = "pw123";
  };


  #redshift stuff 

  services.geoclue2.enable = true; 
  location.provider = "geoclue2";

  services.redshift = {
    enable = true;
    brightness = {
      # Note the string values below.
      day = "1";
      night = "1";
    };
    temperature = {
      day = 4500;
      night = 2500;
    };
  };

  # List packages installed in system profile. To search, run:

  programs.zsh.enable = true;

  programs.thunar.enable = true;

  users.defaultUserShell = pkgs.zsh;


  programs.adb.enable = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     kdePackages.ark
     thunderbird
     emacs-unstable
     nodejs
     gcc
     kexec-tools
     texlive.combined.scheme-full
     qpdfview
     slurp
     openvpn
     libarchive
     leiningen
     mako
     jdk21
     xidlehook
     android-tools
     brightnessctl
     nodePackages.typescript
     nodePackages.vue-language-server
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

