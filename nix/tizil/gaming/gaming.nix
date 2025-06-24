{ config, lib, pkgs, ... }:

{
   imports = [
      ../hardware-configuration.nix
   ];
   specialisation = { 
     playstation = { 
       inheritParentConfig = false;
       configuration = {

           imports = [ 
	       ../hardware-configuration.nix
	   ];

           #using the same from my host system 
	   system = { 
	       stateVersion = "23.11";
               nixos.tags = [ "Playstation" ];
	   };

	   boot = { 
	       kernelParams = [
	           "quiet"
		   "splash"
		   "pcie_aspm=off"
	       ];

	       plymouth.enable = true;

	       kernelPackages = pkgs.linuxPackages_latest;

	       supportedFilesystems = ["ntfs"];

	       initrd.kernelModules = [ "amdgpu" ];
	   };

	   hardware = { 
	       enableAllFirmware = true;

	       graphics = {
	           enable = true;
		   enable32Bit = true;
		   extraPackages = with pkgs; [vulkan-loader vulkan-tools mesa];
	       };
	   };
	   
	   networking = {
	       wireless.iwd.enable = true;
	       dhcpcd.enable = true;
	   };

	   time.timeZone = "America/Sao_Paulo";

	   services = {
	        pipewire = {
	            enable = true;
		    alsa.enable = true;
		    alsa.support32Bit = true;
		    pulse.enable = true;
	        };

		xserver = { 
		   enable = true; 
		   videoDrivers = [ "amdgpu" ];
		};

		gvfs.enable = true; 
		devmon.enable = true;
		tumbler.enable = true;

		flatpak.enable = true; 

		xserver.desktopManager.gnome.enable = true;
		xserver.displayManager.gdm.enable = true;

		geoclue2.enable = true;
	   };

	   security.polkit.enable = true; 

	   xdg.portal = {
	       wlr.enable = true; 
	       xdgOpenUsePortal = true;
	   };

	   location.provider = "geoclue2";


	   #packageos

	   nixpkgs.config.allowUnfree = true;

	   environment.systemPackages = with pkgs; [
	       ffmpeg-full
	       brightnessctl 
	       openvpn
	       libretro.nestopia
	       libretro.snes9x 
	       libretro.genesis-plus-gx
	       retroarchFull
	       neovim
	       mesa
	       vulkan-tools
	   ];

	   users.users.Travis = { 
	      isNormalUser = true; 
	      extraGroups = ["adbusers" "wheel" "libvirtd" "input" "audio"];

	      packages = with pkgs; [
	         tree
		 audacity
		 gimp
		 ptyxis
		 kdePackages.kdenlive 
		 keepassxc
		 steam
		 firefox
		 obs-studio
		 gnome-tweaks
		 telegram-desktop
		 steam-run
	      ];
              hashedPassword = "$y$j9T$ThUZGEDD65jKe8H2473wv1$DdGOjKZ0eVNr3kk/48i8RoM4O502JYpgPHf76EJZJ0C";
	   };


       };
     };
   };

}
