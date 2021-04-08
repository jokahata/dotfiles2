(require 'package)
 
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'load-path "~/.joconf/")
 
(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Set up Theme
;; Remove default UI elements
(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 11)
(menu-bar-mode -1)
(show-paren-mode 1)
;; Set up visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code" :height 130)

;; Enable copying on macOs
(setq select-enable-clipboard t)

;; Paste
(setq interprogram-paste-function
      (lambda ()
	(shell-command-to-string "pbpaste")))


(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t) ;; Let Evil take over C u for  scrolling
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode t)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join) ;; Basically backspace

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Choose which visual line mode to run with,
;; This first one makes it wrap around like in sublime or notepad, but kill line will only reach the end
;; word-wrap will actually make it so kill line will kill the entire line 
;; (global-visual-line-mode t)
(setq-default word-wrap t)

(set-face-attribute 'default nil :font "Fira Code" :height 130)

;; Add line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers certain modes
(dolist (mode '(term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(setq byte-compile-warnings '(cl-functions))

  ;; Init is before it's loaded
  ;; config runs after the package loads
  ;; see use-package
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
    :config
    (setq which-key-idle-delay 0.3))

  
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-challenger-deep t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


(use-package general
  :config
  (general-create-definer jo/leader-keys
		  :keymaps '(normal insert visual emacs)
		  :global-prefix "C-SPC")
  (jo/leader-keys
   "t" '(:ignore t :which-key "toggles")))

;; For making fast transient key bindings
(use-package hydra)
(defhydra hydra-text-scale (:timeout 2)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t)

  (jo/leader-keys
   "ts" '(hydra-text-scale/body :which-key "scale text")))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Show tooltip of keys
(use-package which-key
  :init (which-key-mode)
  :diminish (which-key-mode)
  :config
  (setq which-key-idle-delay 1))

 (use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  :after counsel)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(defun jo/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))


(defun jo/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  )

(use-package org
  :hook (org-mode . jo/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

 (setq org-agenda-start-with-log-mode t)
 (setq org-log-done 'time)

 (setq org-agenda-files
       '("~/Dropbox/org/workclean.org"
	 "~/Dropbox/org/birthdays.org"
	 "~/Dropbox/org/habits.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60) 

  (setq org-todo-keywords
	'((sequence "TODO(t)" "FRONT(f)" "WAIT(w)" "|" "DONE(d!)")))

   ;; Do these
   (setq org-refile-targets
    '(("archive.org" :maxlevel . 1)
      ("workclean.org" :maxlevel . 1)))
 
    ;; Save Org buffers after refiling!
   ;; TODO Check if I can have variables for different files
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/Dropbox/org/workclean.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/Dropbox/org/journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)

      ))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (jo/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Browsing
(use-package osx-browse)
(osx-browse-mode 1)

(defun osx-browse-url-work (url &optional new-window browser focus)
  "Open in work which is probably Chrome, refer: osx-browse-url"
  (interactive (osx-browse-interactor-form))
  (callf or browser "com.google.Chrome")
  (osx-browse-url url new-window browser focus))

;; TODO Check if this works 
(defun osx-browse-url-personal (url &optional new-window browser focus)
  "Open in Brave)"
  (interactive (osx-browse-interactive-form))
  (callf or browser "com.brave.Brave")
  (osx-browse-url url new-window browser focus))

(setq
      ;; See: http://ergoemacs.org/emacs/emacs_set_default_browser.html
      browse-url-browser-function
      '(("docs\\.google\\.com"  . osx-browse-url-work)
	("youtube.com"        . osx-browse-url-personal)
	("."                    . eww-browse-url)))

(use-package ace-link)
(ace-link-setup-default)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/workspace/")
    (setq projectile-project-search-path '("~/workspace/")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands magit-status)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit ace-link counsel which-key rainbow-delimiters doom-themes evil))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
