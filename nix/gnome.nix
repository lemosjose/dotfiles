{ config, lib, pkgs, ... }:

{
   services.xserver = { 
     enable = true; 
     displayManager.gdm.enable = true;
     desktopManager.gnome.enable = true;
   };


  services.geoclue2.enable = true; 
  location.provider = "geoclue2";

  #night light
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

}

