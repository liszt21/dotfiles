(use-modules (gnu) (gnu system nss))
(use-service-modules syncthing xorg ssh desktop docker)
(use-package-modules bootloaders certs emacs emacs-xyz suckless wm xorg)

(define %user-liszt
  (user-account 
    (name "liszt") 
    (group "users") 
    (comment "Li Shuzhi") 
    (supplementary-groups '("wheel" "netdev" "audio" "video"))))

(operating-system
  (host-name "nuc")
  (timezone "Asia/Shanghai")
  (locale "en_US.utf8")

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))))

  ;; Assume the target root file system is labelled "my-root",
  ;; and the EFI System Partition has UUID 1234-ABCD.
  (file-systems (append
                 (list (file-system
                         (device (file-system-label "ROOT"))
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device (uuid "D637-CAE4" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  (users (cons %user-liszt
               %base-user-accounts))

  (packages 
    (append 
      (map (compose list specification->package+output)
        (list 
          "mu" 
          "msmtp"
          "isync" 
          "libtool"
          "librime"
          "libvterm"
          "offlineimap3"
          "tree-sitter-c"
          "tree-sitter-go"
          "tree-sitter-cpp"
          "tree-sitter-elm"
          "tree-sitter-css"
          "tree-sitter-org"
          ; "tree-sitter-php"
          ; "tree-sitter-ruby"
          "tree-sitter-bash"
          "tree-sitter-rust"
          "tree-sitter-json"
          "tree-sitter-java"
          "tree-sitter-html"
          "tree-sitter-julia"
          ; "tree-sitter-ocaml"
          ; "tree-sitter-racket"
          "tree-sitter-python"
          "tree-sitter-scheme"
          "tree-sitter-clojure"
          "tree-sitter-haskell"
          "tree-sitter-markdown"
          "tree-sitter-typescript"
          "tree-sitter-javascript"

          "glibc-locales"
          "bat"
          "git"
          "zile"
          "make"
          "unzip"
          "neovim"
          "docker" 
          "docker-cli"
          "docker-compose"
          "zoxide" 
          "direnv"
          ;; "nushell"
          "recutils"
          "findutils"
          "syncthing"
          "bash-completion"

          "vlc"
          "mpv"
          "lsof"
          "nyxt"
          "gimp"
          "qemu"
          "xclip"
          "yt-dlp"
          "ffmpeg"
          "blender"
          "virt-manager"
          "virt-viewer"
          "tesseract-ocr"
          "tesseract-ocr-tessdata-fast"

          "feh"
          "fzf"
          "ghc"
          "sddm"
          "rofi"
          "sbcl"
          "picom"
          "conky"
          "xmonad"
          "stumpwm"
          "xorg-server"
          "python-pywal"
          "cabal-install"
          "ghc-xmonad-contrib"
          "sbcl-stumpwm-swm-gaps"
          "sbcl-stumpwm-ttf-fonts"

          "emacs-next" 
          "emacs-exwm" 
          "emacs-desktop-environment" 

          "xterm" 
          "nss-certs" 
          "xmonad" 
          "ghc-xmonad-contrib" 
          "i3-wm" 
          "i3status"))
      %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with NetworkManager, and more.
  (services (modify-services
             (append
              (list
                (service docker-service-type)
                (service syncthing-service-type
                     (syncthing-configuration
                      (user "liszt")))
                (service openssh-service-type
                  (openssh-configuration
                    (x11-forwarding? #t))))
              %desktop-services)
             (gdm-service-type
              config => (gdm-configuration
                         (inherit config)
                         (auto-suspend? #f)))
             (guix-service-type
              config => (guix-configuration
                           (inherit config)
                           (substitute-urls '("https://mirror.sjtu.edu.cn/guix" "https://ci.guix.gnu.org"))))))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
