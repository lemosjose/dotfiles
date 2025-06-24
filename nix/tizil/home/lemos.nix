{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let 
   home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;

in
{
  imports = [
      (import "${home-manager}/nixos")
  ];
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home-manager.users.lemos = {
    programs = { 
       zoxide = { 
          enable = true;
	  enableZshIntegration = true;
	  enableFishIntegration = true;
       };
       git = { 
           enable = true; 
	   userEmail = "devlemosjose@gmail.com"; 
	   userName = "lemosjose";
       };

       zsh = { 
          enable = true; 
	  enableCompletion = true; 
	  autosuggestion.enable = true; 
	  syntaxHighlighting.enable = true;
	  shellAliases = { 
	     enterDev = "nix-shell nix/shell.nix";
	     update = "sudo nixos-rebuild switch --upgrade";
	     clean = "sudo nix-collect-garbage -d";
	     cd = "z"; 
	  };
	  history = { 
	      path = "/home/lemos/.zsh/history";
	  };
	  oh-my-zsh = {
	      enable = true; 
	      plugins = ["git"];
	      theme = "afowler";
	  };
       };
    };

    home = { 
        stateVersion = "23.05";
	#i decided to insert gui/daily-use stuff here to keep it "clean" in my head
	packages = with pkgs; [ google-chrome telegram-desktop thunderbird kdePackages.ark mpv kdePackages.okular vlc zed-editor ptyxis postman firefox chromium pavucontrol spotify gimp emacs gnome-tweaks vscode ];
    };
  };

}
