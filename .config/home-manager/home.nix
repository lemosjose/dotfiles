{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  programs.waybar.enable = true; 
  programs.firefox.enable = true;
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "lemos";
    homeDirectory = "/home/lemos";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  #home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.zsh = {
     enable = true;
     enableCompletion = true;
     autosuggestion.enable = true;
     syntaxHighlighting.enable = true;
     shellAliases = {
        ll = "ls -l";
	update = "sudo nixos-rebuild switch";
     };
     history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
     };

     oh-my-zsh = {
        enable = true;
	plugins = ["git"];
	theme = "essembeh";
     };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  ## fix virt-manager stuff

  home.pointerCursor = {
    gtk.enable = true; 
    package = pkgs.vanilla-dmz; 
    name = "Vanilla-DMZ";
  };
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}


##FETCHED FROM NIX-STARTER-CONFIGS (Misterio77)
