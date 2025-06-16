{ config, lib, pkgs, ... }:

let 
   home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./gnome.nix
      #My second Playstation 
      ./gaming/gaming.nix
      (import "${home-manager}/nixos")
    ];

  hardware = {
      enableAllFirmware = true; 

      graphics.enable = true;
  };

  #nixpkgs.config.allowUnfree = true;

  nixpkgs = { 
     config.allowUnfree = true;
  };

  boot = {
     loader.systemd-boot = { 
          enable = true; 
	  memtest86.enable = true;
     };

     loader.efi.canTouchEfiVariables = true;

     plymouth.enable = true; 

     kernelParams = [
         "pcie_aspm=off"
	 "quiet"
	 "splash"
	 "amdgpu.runpm=0"
	 "iwlwifi.11n_disable=1"
     ];

     kernelPackages = pkgs.linuxPackages_latest;

     initrd.kernelModules = [ "amdgpu" ];


     supportedFilesystems = ["ntfs"];  
  };

  ##backup for when emacs breaks with some kernel stuff, i don't know why it happens 
 # boot.kernelPackages = pkgs.linuxPackages.extend (lpFinal: lpPrev: {
 #     cpupower = lpPrev.cpupower.overrideAttrs (old: {
 #       nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.which ];
 #       makeFlags = (old.makeFlags or []) ++ [ "INSTALL_NO_TRANSLATIONS=1" ];
 #     });
 # });

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs = { 
      dconf.enable = true; 
      #spooky!
      nix-ld.enable = true;
      virt-manager.enable = true;
      adb.enable = true;

      gamemode.enable = true;

      #just to remove the warning 
      zsh.enable = true; 

      kdeconnect = { 
         enable = true; 
	 package = pkgs.gnomeExtensions.gsconnect;
      };
  };

  #fonts fixing 

  fonts.packages = with pkgs; [
     font-awesome
     powerline-fonts
     powerline-symbols
  ];

  services = {
      udev = {
          enable = true; 
	  packages = [ pkgs.android-udev-rules ];
      };

      gvfs.enable = true; 

      udisks2.enable = true; 

      tumbler.enable = true;

      devmon.enable = true;

      touchegg.enable = true;

      flatpak.enable = true;

      pipewire = {
          enable = true;
          wireplumber.enable = true; 

	  alsa.enable = true; 
	  alsa.support32Bit = true; 
	  pulse.enable = true;
      };

      xserver = { 
         enable = true; 
	 videoDrivers = [ "amdgpu" ];
      };
  };

  xdg.portal = { 
      wlr.enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "*";
  };

  security = {
      polkit.enable = true;
      rtkit.enable = true;
  };

  powerManagement.cpuFreqGovernor = "performance";


  environment = { 
      pathsToLink = [ "/libexec" ];
      localBinInPath = true;
  };

  virtualisation = {
       podman = {
          enable = true;
          dockerCompat = true;
       }; 

       libvirtd.enable = true;

       spiceUSBRedirection.enable = true;
  };



  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";
  
  users.defaultUserShell = pkgs.zsh;


  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #Garras da patrulha hostname and networking
  networking = {
      hostName = "tizil";
      networkmanager.enable = true;
      firewall = { 
         enable = true;
	 allowedTCPPorts = [ 8080
	                     9090
                             1234
                           ];
     };
  };
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "23.11"; # Did you read the comment?

}

