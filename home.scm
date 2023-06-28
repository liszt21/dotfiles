(use-modules
  (gnu home)
  (gnu packages)
  (gnu packages base)
  (gnu packages admin)
  (gnu packages syncthing)
  (gnu packages package-management)
  (gnu services)
  (gnu services nix)
  (gnu services mcron)
  (guix gexp)
  (gnu home services)
  (gnu home services mcron)
  (gnu home services shells)
  (gnu home services shepherd))

(defmacro try-use (sym) `(if (defined? (if (list? ,sym) (eval ,sym) ,sym)) ,sym #f))

(define linux? (eq? (vector-ref (uname) 0) "Linux"))
(define macos? (eq? (vector-ref (uname) 0) "Darwin"))

(define machine-name (vector-ref (uname) 1))
(define distribution-name
  (cond (macos? "macos")
        (linux? 
          (cond 
            ((file-exists? "/etc/arch-release") "archlinux")
            ((file-exists? "/etc/fedora-release") "fedora")
            (else "unknown")
          ))
        (else "unknown")))

(define archlinux? (eq? distribution-name "archlinux"))
(define fedora? (eq? distribution-name "fedora"))

(define minisforum? (if (eq? machine-name "minisforum") #t #f))

(define font-packages (list "font-sarasa-gothic" "font-adobe-source-code-pro" "font-fira-code" "font-lxgw-wenkai" "font-gnu-unifont" "emacs-all-the-icons"))
(define emacs-packages (list "emacs-vterm" "emacs-rime" "tree-sitter-python" "tree-sitter-julia" "tree-sitter-typescript" "tree-sitter-javascript" "tree-sitter-c" "tree-sitter-cpp" "mu" "offlineimap3" "isync" "msmtp"))
(define common-packages (list "glibc-locales" "git" "unzip" "zile" "recutils" "findutils" "syncthing" "fish" "bat" "neovim" "docker" "librime")) 
(define linux-packages (list ""))
(define minisforum-package (list "nyxt" "qemu" "virt-manager" "virt-viewer" "vlc" "mpv" "gimp" "blender" "python-pywal" "mpv" "yt-dlp" "ffmpeg" "tesseract-ocr" "tesseract-ocr-tessdata-fast" "xclip"))

(define common-services 
  (list
    (service
       home-bash-service-type
       (home-bash-configuration
         (environment-variables `(("GTK_IM_MODULE" . "fcitx")
                                  ("TESSDATA_PREFIX" . "${HOME}/.guix-home/profile/share/tessdata")))
         (aliases '(("spacemacs" . "emacs --with-profile spacemacs")
                    ("doomemacs" . "emacs --with-profile doomemacs")
                    ("emacy" . "emacs --init-directory ~/Projects/Emacy/profiles/emacy")))
         (bashrc (list (local-file "bashrc")))))))

(home-environment
  (packages
    (map (compose list specification->package+output)
         (append common-packages font-packages emacs-packages
                 (if linux? linux-packages (list))
                 (if minisforum? minisforum-package (list)))))
  (services (append common-services)))
