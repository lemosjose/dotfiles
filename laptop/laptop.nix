{ config, lib, pkgs, modulesPath, ... }:


{
	  services.auto-cpufreq.enable = true; 
	  services.auto-cpufreq.settings = {
		    battery = { 
			       governor = "powersave"; 
			       turbo = "never";
		    }; 

		    charger = {
			      governor = "powersave"; 
			      turbo = "never";
		    }; 
	  };

	specialisation = { 
	   nvidia.configuration = { 
	     # Nvidia Configuration 
		     services.xserver.videoDrivers = [ "nvidia" ]; 
		     hardware.opengl.enable = true; 
	  
	     # Optionally, you may need to select the appropriate driver version for your specific GPU. 
	     hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; 
	  
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


