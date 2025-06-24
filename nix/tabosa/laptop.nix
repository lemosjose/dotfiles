{ config, lib, pkgs, modulesPath, ... }:


{
          hardware.bluetooth = { 
	       enable = true; 
	       powerOnBoot = true;
	  };


	  services = { 
	     udev.extraRules = '' 
	         ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usb", ATTR{power/wakeup}="disabled"
	     '';

	     blueman.enable = true;

	  };

	specialisation = { 
	   nvidia.configuration = { 
	     # Nvidia Configuration 
		     services.xserver.videoDrivers = [ "nvidia" ]; 
		     hardware.graphics.enable = true; 
	  
	     # Optionally, you may need to select the appropriate driver version for your specific GPU. 
	     hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; 
	     hardware.nvidia.open = false; 
	     hardware.nvidia.prime = { 
		       sync.enable = true; 
		  
		       # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA 
		       nvidiaBusId = "PCI:1:0:0"; 
		  
		       # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA 
		       intelBusId = "PCI:0:2:0"; 
	     };
	  };



};

} 


