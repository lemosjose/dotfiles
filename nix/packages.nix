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
	 obs-studio
	 kdePackages.kdenlive
	 tmux
	 xss-lock
	 pipx
	 session-desktop-appimage
	 sbcl
	 zip
	 multipath-tools 
	 openssl
	 clojure-lsp
	 dex
	 gimp
	 gnome-tweaks
	 geeqie
	 audacity
	 transmission_4-qt
	 firefox
	 librewolf
	 firejail
	 feh
	 unzip
	 ptyxis
	 picom
	 arandr
	 devbox
	 yt-dlp
         keepassxc
         cmus
	 arandr
	 mpv
	 bottom
	 zed-editor
	 python312Full
	 koodo-reader
	 mplayer
	 vlc
	 kitty
	 palemoon-bin
	 nitrogen
	 scrcpy
	 alsa-utils
	 flameshot
	 zeal
	 gtk3
	 tokyonight-gtk-theme
	 element-desktop
	 hexchat
	 nix-index
	 pipenv
	 python312Packages.pkgconfig
	 asciidoctor-with-extensions
	 volumeicon
	 postman
	 streamlink
      ];
      initialPassword = "pw123";
   };

}
