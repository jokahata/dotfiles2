(require 'package)
 
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
 
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
=======
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
>>>>>>> ba709f038be6615e4fcda7beeb3684c70619f3cd

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


<<<<<<< HEAD
(use-package general
  :config
  (general-create definer jo/leader-keys
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
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(which-key rainbow-delimiters doom-themes evil))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
