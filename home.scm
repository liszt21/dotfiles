(use-modules
  (guix gexp)
  (gnu home)
  (gnu packages)
  (gnu packages base)
  (gnu packages admin)
  (gnu packages syncthing)
  (gnu packages package-management)
  (gnu services)
  (gnu services nix)
  (gnu services mcron)
  (gnu home services)
  (gnu home services mcron)
  (gnu home services shells)
  (gnu home services shepherd))

(defmacro try-use (sym) `(if (defined? (if (list? ,sym) (eval ,sym) ,sym)) ,sym #f))

; (define linux? (eq? (vector-ref (uname) 0) "Linux"))
; (define macos? (eq? (vector-ref (uname) 0) "Darwin"))
; (define distribution-name
;   (cond (macos? "macos")
;         (linux? 
;           (cond 
;             ((file-exists? "/etc/arch-release") "archlinux")
;             ((file-exists? "/etc/fedora-release") "fedora")
;             (else "unknown")
;           ))
;         (else "unknown")))
; (define archlinux? (eq? distribution-name "archlinux"))
; (define fedora? (eq? distribution-name "fedora"))

(define machine-name (vector-ref (uname) 1))
(define minisforum? (if (eq? machine-name "minisforum") #t #f))

(define font-packages 
  (list 
    ;;"font-sarasa-gothic" 
    "font-adobe-source-code-pro" 
    "font-fira-code" 
    "font-lxgw-wenkai" 
    "font-gnu-unifont" 
    "emacs-all-the-icons"))

(define emacs-packages 
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
    ; "emacs-next-tree-sitter"
    ))

(define common-packages 
  (list 
    "glibc-locales"
    "bat"
    "git"
    "zile"
    "unzip"
    "neovim"
    "docker" 
    "zoxide" 
    "direnv"
    "nushell"
    "recutils"
    "findutils"
    "syncthing"
    "bash-completion")) 

(define minisforum-packages
  (list 
    "vlc"
    "mpv"
    "xclip"
    "nyxt"
    "gimp"
    "qemu"
    "yt-dlp"
    "ffmpeg"
    "blender"
    "virt-manager"
    "virt-viewer"
    "tesseract-ocr"
    "tesseract-ocr-tessdata-fast"))

(define graph-packages
  (list
    "feh"
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
    "sbcl-stumpwm-ttf-fonts"))

(define common-services 
  (list
    (service
       home-bash-service-type
       (home-bash-configuration
         (guix-defaults? #t)
         (environment-variables `(("GTK_IM_MODULE" . "fcitx")
                                  ("TESSDATA_PREFIX" . "${HOME}/.guix-home/profile/share/tessdata")))
         (aliases '(("emacy" . "emacs --init-directory ~/Dotfiles/module/emacy/profiles/emacy")))
         (bashrc (list (local-file "config/bash/config")))))))

(home-environment
  (packages
    (map (compose list specification->package+output)
         (append common-packages
                 font-packages
                 emacs-packages
                 graph-packages
                 (if minisforum? minisforum-packages (list)))))
  (services (append common-services)))
