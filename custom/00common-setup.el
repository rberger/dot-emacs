;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
(semantic-mode 1)

;; Set the starting position and width and height of Emacs Window
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 99))
(when window-system (set-frame-size (selected-frame) 170 60))

;; To get rid of Weird color escape sequences in Emacs.
;; Instruct Emacs to use emacs term-info not system term info
;; http://stackoverflow.com/questions/8918910/weird-character-zsh-in-emacs-terminal
(setq system-uses-terminfo nil)
 
;; Prefer utf-8 encoding
(prefer-coding-system 'utf-8)
 
;; Use windmove bindings
;; Navigate between windows using Alt-1, Alt-2, Shift-left, shift-up, shift-right
(windmove-default-keybindings) 
 
;; (set-frame-font "-apple-Fira_Mono-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")
 
;; Display continuous lines
(setq-default truncate-lines nil)
;; Do not use tabs for indentation
(setq-default indent-tabs-mode nil)
(menu-bar-mode t)
;;(enable-theme 'solarized-dark)
 
;; trucate even even when screen is split into multiple windows
(setq-default truncate-partial-width-windows nil)
 
;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)              
 
(set-cursor-color "red")
 
(setq default-frame-alist
      '((cursor-color . "red")))
 
;; Highlight incremental search
(setq search-highlight t)
(transient-mark-mode t)
 
(global-visual-line-mode 1)
 
(display-time)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
 
;;(scroll-bar-mode nil)
 
;; Enable copy and pasting from clipboard
(setq x-select-enable-clipboard t)
 
;; Disable backups
(setq backup-inhibited t)
;;disable auto save
(setq auto-save-default nil)
 
;;some custom functions, stolen for internet
(defun geosoft-forward-word ()
   ;; Move one word forward. Leave the pointer at start of word
   ;; instead of emacs default end of word. Treat _ as part of word
   (interactive)
   (forward-char 1)
   (backward-word 1)
   (forward-word 2)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
         (t (forward-char 1)))) 
(defun geosoft-backward-word ()
 ;; Move one word backward. Leave the pointer at start of word
 ;; Treat _ as part of word
  (interactive)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (geosoft-backward-word))
        (t (forward-char 1)))) 
 
(global-set-key [C-right] 'geosoft-forward-word)
(global-set-key [C-left] 'geosoft-backward-word)
 
 
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
 
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
 
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
 
(setq path-to-ctags "/usr/local/bin/ctags") ;; <- you're ctags path here
 
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name dir-name))
  )
 
(global-set-key "\C-ct" 'visit-tags-table)
(global-set-key "\C-cd" 'create-tags)
 
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
 
 
(defun recompile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  ;; TODO: remove elpa-to-submit once everything's submitted.
  (byte-recompile-directory dotfiles-dir 0))
 
 
(define-key isearch-mode-map (kbd "C-o") ; occur easily inside isearch
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))
 
(require 'yaml-mode)
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
 
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun colorize-compilation-buffer ()
  (interactive)
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
 
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Highlight Indentation mode
;; https://github.com/antonj/Highlight-Indentation-for-Emacs
(require 'highlight-indentation)
 (add-hook 'enh-ruby-mode-hook
           (lambda () (highlight-indentation-current-column-mode)))

 (add-hook 'coffee-mode-hook
           (lambda () (highlight-indentation-current-column-mode)))

;; Ag silver-searcher
;; https://github.com/Wilfred/ag.el
;; https://github.com/ggreer/the_silver_searcher
(setq ag-highlight-search t)

;; Apache-mode
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

;; auto-save-bufferes-enhanced
(require 'auto-save-buffers-enhanced)
(auto-save-buffers-enhanced nil)

;; browse-kill-ring
;; https://github.com/browse-kill-ring/browse-kill-ring
(require 'browse-kill-ring)

(require 'flyspell)
(require 'flyspell-lazy)
(flyspell-lazy-mode 1)
(setq flyspell-issue-message-flg nil)
(add-hook 'web-mode-hook
          (lambda () (flyspell-prog-mode)))

