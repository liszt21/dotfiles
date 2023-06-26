;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

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

(define @home (load "guix/home.scm"))
(define @lisux-home "${HOME}/Lisux")
(define @dotfiles "${HOME}/Dotfiles")

(define machine-name (vector-ref (uname) 1))

(define updatedb-job
  #~(job '(next-hour '(3))
         (lambda ()
           (execl (string-append #$findutils "/bin/updatedb")
                  "updatedb"
                  "--prunepaths=/tmp /var/tmp /gnu/store"))
         "updatedb"))

(define pywal-job #~(job "0 0,30 * * *" "wal -i ~/Sync/Wallpapers"))

(define syncthing-service
  (shepherd-service
   (provision '(syncthing))
   (documentation "Run syncthing")
   (respawn? #t)
   (start #~(make-forkexec-constructor
             (list #$(file-append syncthing "/bin/syncthing")
                   "--no-browser" "--logflags=3" "--logfile=~/.local/var/log/syncthing.log")))
   (stop #~(make-kill-destructor))))

(define nix-service
  (shepherd-service
   (provision '(nix-daemon))
   (documentation "Run nix daemon")
   (respawn? #t)
   (start #~(make-forkexec-constructor
             (list #$(file-append nix "/bin/nix-daemon")
                   "--substituters=\"https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/\"")))
   (stop #~(make-kill-destructor))))

(home-environment
  (packages
    (map (compose list specification->package+output)
         (list ;; -- personal
               ;; "roswell"
               "glibc-locales"

               ;; -- basic
               "git"
               "unzip"
               "zile"
               "recutils"
               "findutils"
               "syncthing"
               "fish"
               "bat"
               ;; "nix"
               ;; "bash-completion"

               "neovim"
               "nyxt"
               ;; -- fonts
               "font-sarasa-gothic"
               "font-adobe-source-code-pro"
               "font-fira-code"
               "font-lxgw-wenkai"
               "font-gnu-unifont"
               ;;"emacs-next-tree-sitter"
               "emacs-all-the-icons"
               ;;"emacs-next"

               "emacs-vterm"
               "emacs-rime"

               "tree-sitter-python"
               "tree-sitter-julia"
               "tree-sitter-typescript"
               "tree-sitter-javascript"
               "tree-sitter-c"
               "tree-sitter-cpp"
	       
               "librime"
               "mpv"
               "yt-dlp"
               "ffmpeg"
               "tesseract-ocr"
               "tesseract-ocr-tessdata-fast"
               "xclip"

               "mu"
               "offlineimap3"
               "isync"
               "msmtp"

               ;; -- applications
               ;; "tigervnc-server"
               ;; "nyxt"
               ;; "qemu"

               ;; -- develop
               ;; "make" "gcc" "gnupg"
               ;; "cmake"
               ;; "conda" "python"
               ;; "node"
               ;; "julia"
               ;; "clojure"
               ;; "nim"
               ;; "go"
               ;; "php"
               ;; "perl"
               ;; "ghc"

               ;; -- virtual machine
               ;; "virt-manager"
               ;; "virt-viewer"

               ;; -- emacs
               ;; "parinfer-rust"

               ;; -- tools
               ;; "vlc"
               ;; "mpv"
               ;; "gimp"
               ;; "blender"
               "python-pywal"

               "docker"
	       )))
  (services
    (list
     (service
       home-bash-service-type
       (home-bash-configuration
         (environment-variables `(("GTK_IM_MODULE" . "fcitx")
                                  ("TESSDATA_PREFIX" . "${HOME}/.guix-home/profile/share/tessdata")))
         (aliases '(("spacemacs" . "emacs --with-profile spacemacs")
                    ("doomemacs" . "emacs --with-profile doomemacs")
                    ("emacy" . "emacs --init-directory ~/Projects/Emacy/profiles/emacy")))
         (bashrc (list (local-file ".bashrc")))
         (bash-profile (list (local-file ".bash_profile"))))))))

