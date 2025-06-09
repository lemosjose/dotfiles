{ config, lib, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      kdePackages.ark
      thunderbird
      emacs-unstable
      nodejs
      gcc
      ffmpeg-full
      kexec-tools
      distrobox
      podman-compose
      texlive.combined.scheme-full
      kdePackages.okular
      input-remapper
      slurp
      openvpn
      libarchive
      leiningen
      mako
      jdk21
      which
      rPackages.pkgconfig 
      xidlehook
      cairo 
      android-tools
      brightnessctl
      nodePackages.typescript
   ];

   users.users.lemos = {
      isNormalUser = true;
      extraGroups = ["adbusers" "wheel" "libvirtd" "input" "audio" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
         tree
	 gopls
	 go
	 tmux
	 xss-lock
	 telegram-desktop
	 pipx
	 kdePackages.okular
	 sbcl
	 zip
	 multipath-tools 
	 openssl
	 clojure-lsp
	 dex
	 gimp
	 gnome-tweaks
	 geeqie
	 transmission_4-qt
	 firefox
	 feh
	 unzip
	 ptyxis
	 picom
	 arandr
	 devbox
	 yt-dlp
         keepassxc
	 mpv
	 bottom
	 zed-editor
	 python312Full
	 koodo-reader
	 mplayer
	 vlc
	 kitty
	 palemoon-bin
	 scrcpy
	 alsa-utils
	 zeal
	 gtk3
	 tokyonight-gtk-theme
	 element-desktop
	 hexchat
	 nix-index
	 pipenv
	 python312Packages.pkgconfig
	 asciidoctor-with-extensions
	 postman
	 streamlink
      ];
      hashedPassword = "$y$j9T$ILvyeB3rSFT7yiMgx6xBh/$O3qkgsba6AcXEwtzfu2v9aWgVF.aw7F9SBoa/Lciji6";
   };

}
