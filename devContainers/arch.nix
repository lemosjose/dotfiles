{ pkgs ? import <nixpkgs> {} }:

pkgs.dockerTools.buildImage {
  name = "arch-dev-container";
  tag = "latest";

  # Base Arch Linux image
  fromImage = pkgs.dockerTools.pullImage 
  {
     imageName = "archlinux";
     imageDigest = "sha256:ae7491066c2f96861d7b442aef512974138c2004b8bf5b2aacda6b8fd9e112fe";
     sha256 = "1w3pi6jf5xywavbn28xbry4mx4wzjzzvb6yham2p65gc7806qqsa";
     finalImageName = "archlinux";
     finalImageTag = "latest";
  };


  # Configuration for the container
  config = {
    WorkingDir = "/workspace";
    Volumes = {
      "~/Workspace" = {/workspace};
    };

    # Packages to install
    Env = [
      "PACKAGES=base-devel git neovim zsh tmux python nodejs npm rust go emacs libcairo2 libpq-dev gcc fonts-liberation libpango libjpeg-dev python3-dev g++ build-essential pkg-config bash libffi-dev netcat-openbsd python-poetry"
    ];

    # Entrypoint script to install packages and set up environment
    Entrypoint = [
      "${pkgs.writeShellScript "entrypoint" ''
        #!/usr/bin/env bash
        
        # Update package database
        pacman -Sy --noconfirm

        # Install specified packages
        for package in $PACKAGES; do
          pacman -S --noconfirm $package
        done

        # Set up zsh as default shell
        chsh -s $(which zsh)

        # Start an interactive shell
        exec zsh
      ''}"
    ];
  };

  # Additional configuration for development
  extraCommands = ''
    mkdir -p workspace
  '';
}
