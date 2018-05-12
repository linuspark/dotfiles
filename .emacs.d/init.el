(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Mac 에서 Keymap 변경
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)

;; Korean Setting
(set-language-environment "Korean")
(prefer-coding-system 'utf-8) ; utf-8 환경 설정
(setq default-input-method "korean-hangul")
(global-set-key (kbd "<S-SPC>") 'toggle-input-method)

;; System font
(when (and window-system (eq system-type 'darwin))
  ;(set-face-attribute 'default nil :family "menlo" :height 130))
  (set-face-attribute 'default nil :family "D2Coding" :height 130))
  ;(set-fontset-font t 'hangul (font-spec :name "D2Coding")))

;; Key 입력시 Echo 창에 표시되는 딜레이타임
(setq echo-keystrokes 0.001)

(setq tab-width 4)

;; Turn Off backups
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; No popup frame(새 버퍼 현재 프레임에서 열기)
(setq ns-pop-up-frames nil)
(setq pop-up-frame nil)

;; Full Screen Key Setup
(define-key global-map (kbd "C-M-f") 'toggle-frame-fullscreen)

;; Tabindent
(setq-default indent-tab-mode nil)

;; Default Mode
(define-key global-map (kbd "C-j") nil)
;; unset C- and M- digit keys
(dotimes (n 10)
  (global-unset-key (kbd (format "C-%d" n)))
  (global-unset-key (kbd (format "M-%d" n)))
  )

;; Display time
(display-time)

;; Package repository Setup
(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; use-package 를 설치하여 package를 관리한다.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package 내에서 :ensure-system-package 키워드를 사용할 수 있게 한다.
(use-package use-package-ensure-system-package
  :ensure t)

;; Key Chord mode 를 사용할 수 있다. (key 조합)
(use-package use-package-chords
  :ensure t
  :config (key-chord-mode 1))

(use-package diminish
  :ensure t)

;; osx 에서 PATH를 다시 읽어온다.
(use-package exec-path-from-shell
  :ensure t
  :init
  (when (memq window-system '(mac ns))
	(exec-path-from-shell-initialize)))

;; Buffer를 저장하기 전에 공백을 제거한다.
(use-package whitespace-cleanup-mode
  :ensure t
  :diminish whitespace-cleanup-mode
  :delight '(:eval "")
  :init
  (setq whitespace-cleanup-mode-only-if-initially-clean nil)
  (add-hook 'prog-mode-hook 'whitespace-cleanup-mode)
  (add-hook 'org-mode-hook 'whitespace-cleanup-mode))


;;;; Dispaly / Workspace
(use-package eyebrowse
  :diminish eyebrowse-mode
  :config
  (progn
	(define-key eyebrowse-mode-map (kbd "M-1") 'eyebrowse-switch-to-window-config-1)
	(define-key eyebrowse-mode-map (kbd "M-2") 'eyebrowse-switch-to-window-config-2)
	(define-key eyebrowse-mode-map (kbd "M-3") 'eyebrowse-switch-to-window-config-3)
	(define-key eyebrowse-mode-map (kbd "M-4") 'eyebrowse-switch-to-window-config-4)
	(define-key eyebrowse-mode-map (kbd "M-0") 'eyebrowse-close-window-config)
	(eyebrowse-mode t)
	(setq eyebrowse-new-workspace t)))

;;;; Orgmode
;; Orgmode 를 최신버전으로 업데이트 한다.
(use-package org
  :ensure org-plus-contrib
  :bind
  (("\C-cl" . org-store-link)
   ("\C-ca" . org-agenda)
   ("\C-cc" . org-capture)
   ("\C-cb" . org-switchb))
  )

;; org문서를 gfm(markdown)으로 export한다.
(use-package ox-gfm
  :ensure t)

;; org문서의 형식을 이쁘게 변경한다
(use-package org-bullets
  :ensure t
  :init
  (setq org-todo-keywords
	'((sequence "TODO(t)" "IN PROGRESS(p)" "|" "DONE(d)")
	  (sequence "⚑ WAITING(w)" "|")
	  (sequence "|" "✘ CANCELED(c)")))
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


; Themes
(use-package zenburn-theme
  :disabled
  :ensure t
  :init
  (load-theme 'zenburn t))

(use-package spacemacs-theme
  :disabled
  :ensure t
  :defer t
  :init
  (load-theme 'spacemacs-dark t)
  :config
  (setq spacemacs-theme-org-agenda-height nil)
  (setq spacemacs-theme-org-height nil))

(use-package spaceline-config
  :disabled
  :ensure spaceline
  :init
  (setq powerline-default-separator 'arrow-fade)
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-buffer-id-on)
  (spaceline-toggle-input-method-on)
  (spaceline-toggle-buffer-modified-on)
  (spaceline-toggle-buffer-encoding-on)
  (spaceline-toggle-buffer-encoding-abbrev-off)
  (spaceline-toggle-process-on)
  (spaceline-toggle-projectile-root-on)
  (spaceline-toggle-version-control-on)
  (spaceline-toggle-flycheck-error-on)
  (spaceline-toggle-flycheck-info-on)
  (spaceline-toggle-flycheck-warning-on)
  (spaceline-toggle-battery-on)
  (spaceline-toggle-major-mode-off)
  (spaceline-toggle-minor-modes-on)
  (spaceline-toggle-line-column-on)
  (spaceline-toggle-org-clock-on)
  (spaceline-toggle-window-number-on)
  (spaceline-info-mode))

(use-package snazzy-theme
  :ensure t
  :init
  (load-theme 'snazzy t))

;; Highlighting
;; smarparens 는 자동 괄호와 같은 기능들을 모아둔 패키지이다.
(use-package smartparens
	:ensure t
	:diminish smartparens-mode
	:config
	(progn  ;; progn은 그룹을 만들어 읽기 편하게 한다.
		(require 'smartparens-config)
		(smartparens-global-mode t)))

; 현재 라인를 하이라이팅
(use-package hl-line
  :init
  (global-hl-line-mode +1))

(use-package highlight-thing
  :ensure t
  :diminish highlight-thing-mode
  :init
  (setq highlight-thing-case-sensitive-p t)
  (setq highlight-thing-limit-to-defun t)
  (add-hook 'prog-mode-hook 'highlight-thing-mode))

;; indent guide 선을 동적으로 그려준다.
(use-package indent-guide
  :ensure t
  :diminish indent-guide-mode
  :init
  (setq indent-guide-char "|")
  (indent-guide-global-mode))

(use-package multi-term
  :ensure t
  :init
  (setq multi-term-program "/bin/zsh")
  :bind
  ("C-c i" . multi-term))

;;;; swiper and ivy
(use-package swiper
  :ensure t
  :diminish ivy-mode
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (setq ivy-height 12)
  (setq ivy-switch-buffer-faces-alist
	'((emacs-lisp-mode . outline-1)
	  (org-mode . outline-2))))

(use-package counsel
  :ensure t)

;; Editing
(use-package multiple-cursors
	:ensure t
	:init
	(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
	(global-set-key (kbd "C->") 'mc/mark-next-like-this)
	(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
	(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; Coding
(use-package markdown-mode
  :ensure t
  :commands(markdown-mode gfm-mode)
  :mode(("README\\.md\\'" . gfm-mode)
	("\\.md\\'" . gfm-mode)
	("\\.markdown\\'" . gfm-mode))
  :init
  ;;multimarkdown 을 설치하여아 한다.
  (setq markdownd-command "multimarkdown"))

;; 자동완성 기능인 company
(use-package company
  :ensure t
  :diminish company-mode
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.1)
  (setq company-show-numbers t)
  (setq company-dabbrev-downcase nil)
  (setq company-minimum-prefix-length 2)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; python
(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  (setq elpy-rpc-python-command "python3")
  (setq python-shell-interpreter "python3"))
  ;(elpy-use-cpython "/usr/local/bin/python3"))
  ;(setq elpy-rpc-background "jedi")
  ;(elpy-use-cpython (or "/usr/loacl/bin/python3"))
  ;(setq python-shell-interpreter-args "--simple-prompt -i")
  ;(add-hook 'python-mode-hook (lambda ()
;				(setq indent-tabs-mode nil))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(eyebrowse org-bullets whitespace-cleanup-mode org-plus-contrib ox-gfm markdown-preview-mode exec-path-from-shell snazzy-theme elpy counsel-projectile company counsel swiper diminish multiple-cursors smartparens use-package-chords use-package-ensure-system-package use-package)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
