;; System-type definition
(defun system-is-linux()
    (string-equal system-type "gnu/linux"))
(defun system-is-windows()
    (string-equal system-type "windows-nt"))

;; Start Emacs as a server
(when (system-is-linux)
    (require 'server)
    (unless (server-running-p)
        (server-start))) ;; ��������� Emacs ��� ������, ���� �� - GNU/Linux

;; MS Windows path-variable
(when (system-is-windows)
    (unless (getenv "Home")
        (shell-command (format "setx \"%s\" \"%s\"" 'Home (getenv "APPDATA"))))
    (setq win-sbcl-exe          "C:/sbcl/sbcl.exe")
    (setq win-init-path         (concat (getenv "APPDATA") "/.emacs.d"))
    (setq win-init-ct-path      (concat (getenv "APPDATA") "/.emacs.d/plugins/color-theme"))
    (setq win-init-slime-path   (concat (getenv "APPDATA") "/.emacs.d/plugins/slime")))

;; Unix path-variable
(when (system-is-linux)
    (setq unix-sbcl-bin          "/usr/bin/sbcl")
    (setq unix-init-path         "~/.emacs.d")
    (setq unix-init-ct-path      "~/.emacs.d/plugins/color-theme")
    (setq unix-init-slime-path   "/usr/share/common-lisp/source/slime/"))

;; My name and e-mail address
(setq user-full-name   "dorfe")
(setq user-mail-adress "Fedor.Gavrilov@gmail.com")

;; Dired
(require 'dired)
(setq dired-recursive-deletes 'top) ;; ����� ����� ���� �������� ���������� �������...

;; Imenu
(require 'imenu)
(setq imenu-auto-rescan      t) ;; ������������� ��������� ������ ������� � ������
(setq imenu-use-popup-menu nil) ;; ������� Imenu ������ � ����������
(global-set-key (kbd "<f6>") 'imenu) ;; ����� Imenu �� F6

;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")

;; Start window size
(when (window-system)
    (set-frame-position (selected-frame) 100 15)
    (set-frame-size (selected-frame) 120 55))


;; Load path for plugins
;;(if (system-is-windows)
;;    (add-to-list 'load-path win-init-path)
;;    (add-to-list 'load-path unix-init-path))

;; Org-mode settings
(require 'org) ;; ������� org-mode
(global-set-key "\C-ca" 'org-agenda) ;; ����������� ������������ ���������� ��� ����������
(global-set-key "\C-cb" 'org-iswitchb) ;; ���������� org-mode
(global-set-key "\C-cl" 'org-store-link)
(add-to-list 'auto-mode-alist '("\\.org$" . Org-mode)) ;; ����������� *.org ����� � org-mode

;; Inhibit startup/splash screen
(setq inhibit-splash-screen   t)
(setq ingibit-startup-message t) ;; ����� ����������� ����� ������� ����������� C-h C-a


;; Show-paren-mode settings
(show-paren-mode t) ;; �������� ��������� ��������� ����� {},[],()
(setq show-paren-style 'expression) ;; �������� ������ ��������� ����� {},[],()

;; Electric-modes settings
(electric-pair-mode    1) ;; ������������ {},[],() � ��������� ������� ������ ������
(electric-indent-mode -1) ;; ��������� ����������  electric-indent-mod'�� (default in Emacs-24.4)

;; Delete selection
(delete-selection-mode t)

;; Disable GUI components
(tooltip-mode      -1)
;; (menu-bar-mode     -1) ;; ��������� ����������� ����
;; (tool-bar-mode     -1) ;; ��������� tool-bar
;; (scroll-bar-mode   -1) ;; ��������� ������ ���������
(blink-cursor-mode -1) ;; ������ �� ������
(setq use-dialog-box     nil) ;; ������� ����������� �������� � ���� - ��� ����� ���������
(setq redisplay-dont-pause t)  ;; ������ ��������� ������
(setq ring-bell-function 'ignore) ;; ��������� �������� ������

;; Disable backup/autosave files
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)

(desktop-save-mode 1)
(savehist-mode 1)
(add-to-list 'savehist-additional-variables 'kill-ring) ;; for example

;; Coding-system settings
(set-language-environment 'UTF-8)
(if (system-is-linux) ;; ��� GNU/Linux ��������� utf-8, ��� MS Windows - windows-1251
    (progn
        (setq default-buffer-file-coding-system 'utf-8)
        (setq-default coding-system-for-read    'utf-8)
        (setq file-name-coding-system           'utf-8)
        (set-selection-coding-system            'utf-8)
        (set-keyboard-coding-system        'utf-8-unix)
        (set-terminal-coding-system             'utf-8)
        (prefer-coding-system                   'utf-8))
    (progn
        (prefer-coding-system                   'windows-1251)
        (set-terminal-coding-system             'windows-1251)
        (set-keyboard-coding-system        'windows-1251-unix)
        (set-selection-coding-system            'windows-1251)
        (setq file-name-coding-system           'windows-1251)
        (setq-default coding-system-for-read    'windows-1251)
        (setq default-buffer-file-coding-system 'windows-1251)))

;; Linum plugin
(require 'linum) ;; ������� Linum
(line-number-mode   t) ;; �������� ����� ������ � mode-line
(global-linum-mode  t) ;; ���������� ������ ����� �� ���� �������
(column-number-mode t) ;; �������� ����� ������� � mode-line
(setq linum-format " %d") ;; ������ ������ ��������� �����

;; Fringe settings
(fringe-mode '(8 . 0)) ;; ������������ ������ ������ �����
(setq-default indicate-empty-lines t) ;; ���������� ������ �������� ������� ����� � ������� � ������� ������
(setq-default indicate-buffer-boundaries 'left) ;; ��������� ������ �����

;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;; 24-������� ��������� ������ � mode-line
(display-time-mode             t) ;; ���������� ���� � mode-line
(size-indication-mode          t) ;; ������ ����� � %-��

;; Line wrapping
(setq word-wrap          t) ;; ���������� �� ������
(global-visual-line-mode t)

;; IDO plugin
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)

;; Buffer Selection and ibuffer settings
(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer) ;; ��������� ������ ������� ��� ������� C-x C-b
(global-set-key (kbd "<f2>") 'bs-show) ;; ������ buffer selection ������� F2

;; Color-theme definition <http://www.emacswiki.org/emacs/ColorTheme>
(defun color-theme-init()
    (require 'color-theme)
    (color-theme-initialize)
    (setq color-theme-is-global t)
    (color-theme-charcoal-black))
(if (system-is-windows)
    (when (file-directory-p win-init-ct-path)
        (add-to-list 'load-path win-init-ct-path)
        (color-theme-init))
    (when (file-directory-p unix-init-ct-path)
        (add-to-list 'load-path unix-init-ct-path)
        (color-theme-init)))

;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode             t) ;; �������� � ������ Emacs-22. �� ������...
(setq font-lock-maximum-decoration t)

;; Indent settings
(setq-default indent-tabs-mode nil) ;; ��������� ����������� ������� ������� TAB'��
(setq-default tab-width          4) ;; ������ ��������� - 4 ���������� �������
(setq-default c-basic-offset     4)
(setq-default standart-indent    4) ;; ����������� ������ ������� - 4 ���������� �������
(setq-default lisp-body-indent   4) ;; �������� Lisp-��������� �� 4 ���������� �������
(global-set-key (kbd "RET") 'newline-and-indent) ;; ��� ������� Enter ��������� ������� � ������� ������
(setq lisp-indent-function  'common-lisp-indent-function)

;; Scrolling settings
(setq scroll-step               1) ;; �����-���� �� 1 ������
(setq scroll-margin            10) ;; �������� ����� ����/���� ����� ������ � 10 ����� �� �������/������ �������
(setq scroll-conservatively 10000)

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Clipboard settings
(setq x-select-enable-clipboard t)

;; End of file newlines
(setq require-final-newline    t) ;; �������� ����� ������ ������ � ����� ����� ��� ����������
(setq next-line-add-newlines nil) ;; �� ��������� ����� ������ � ����� ��� �������� �������  ���������

;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)

;; Easy transition between buffers: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))

;; Delete trailing whitespaces, format buffer and untabify when save buffer
(defun format-current-buffer()
    (indent-region (point-min) (point-max)))
(defun untabify-current-buffer()
    (if (not indent-tabs-mode)
        (untabify (point-min) (point-max)))
    nil)
(add-to-list 'write-file-functions 'format-current-buffer)
(add-to-list 'write-file-functions 'untabify-current-buffer)
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

;; CEDET settings
(require 'cedet) ;; ��������� "������" ������ CEDET. ��� �������...
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)
(semantic-mode   t)
(global-ede-mode t)
(require 'ede/generic)
(require 'semantic/ia)
(ede-enable-generic-projects)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(defvar required-packages '(auto-complete
                            zenburn-theme
                            restart-emacs))

(defun packages-installed-p ()
    (loop for package in required-packages
          unless (package-installed-p package)
            do (return nil)
          finally (return t)))

(unless (packages-installed-p)
    (package-refresh-contents)
    (dolist (package required-packages)
        (unless (package-installed-p package)
            (package-install package))))

(when (packages-installed-p)

    (when (display-graphic-p)
        (load-theme 'zenburn t))

    (require 'auto-complete-config)
    (ac-config-default)
    (global-auto-complete-mode      t)
    (setq-default ac-auto-start     t)
    (setq-default ac-auto-show-menu t)
    (defvar *sources* (list
                       'lisp-mode
                       'ac-source-semantic
                       'ac-source-functions
                       'ac-source-variables
                       'ac-source-dictionary
                       'ac-source-words-in-all-buffer
                       'ac-source-files-in-current-dir))
    (let (source)
        (dolist (source *sources*)
            (add-to-list 'ac-sources source)))
    (add-to-list 'ac-modes 'lisp-mode))

;; SLIME settings
(defun run-slime()
    (require 'slime)
    (require 'slime-autoloads)
    (setq slime-net-coding-system 'utf-8-unix)
    (slime-setup '(slime-fancy slime-asdf slime-indentation)))
;;;; for MS Windows
(when (system-is-windows)
    (when (and (file-exists-p win-sbcl-exe) (file-directory-p win-init-slime-path))
        (setq inferior-lisp-program win-sbcl-exe)
        (add-to-list 'load-path win-init-slime-path)
        (run-slime)))
;;;; for GNU/Linux
(when (system-is-linux)
    (when (and (file-exists-p unix-sbcl-bin) (file-directory-p unix-init-slime-path))
        (setq inferior-lisp-program unix-sbcl-bin)
        (add-to-list 'load-path unix-init-slime-path)
        (run-slime)))

;; Bookmark settings
(require 'bookmark)
(setq bookmark-save-flag t) ;; ������������� ��������� �������� � ����
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t)) ;; ���������� ����� � ������� ���� � ����������
(global-set-key (kbd "<f3>") 'bookmark-set) ;; ������� �������� �� F3
(global-set-key (kbd "<f4>") 'bookmark-jump) ;; �������� �� �������� �� F4
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list) ;; ������� ������ ��������
(setq bookmark-default-file (concat user-emacs-directory "bookmarks")) ;; ������� �������� � ���� bookmarks � .emacs.d

(global-set-key (kbd "<f11>") 'restart-emacs)
