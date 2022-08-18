(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Set modes
(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(electric-indent-mode 1)
(delete-selection-mode 1)
(show-paren-mode 1)
(scroll-bar-mode 1)
(popwin-mode 1)
(projectile-mode 1)

(fa-config-default)

(setq exec-path (cons "usr/local/bin" exec-path))

;; Evil mode

(setq evil-want-Y-yank-to-eol t)
(evil-mode 1)

(setq evil-insert-state-cursor '(box "green")
      evil-normal-state-cursor '(box "lemon chiffon"))

 ; Moo
  (define-key evil-normal-state-map (kbd "C-j") 'moo-jump-local)
  (define-key evil-normal-state-map (kbd "C-.") 'moo-jump-directory)
  (define-key evil-normal-state-map (kbd "C->") 'moo-jump-directory-header)
  (define-key evil-normal-state-map (kbd "C-S-j") 'moo-jump-directory)
  (define-key evil-insert-state-map (kbd "M-j") 'moo-complete)

(evil-set-undo-system 'undo-redo)
(define-key evil-normal-state-map (kbd "C-s") 'ace-jump-mode)
(define-key evil-normal-state-map "s" 'ace-jump-char-mode)
(define-key evil-normal-state-map "R" 'string-rectangle)
(define-key evil-normal-state-map (kbd "C-t") 'transpose-chars)
(define-key evil-normal-state-map (kbd "C-w") 'kill-current-buffer)
(define-key evil-normal-state-map "m" 'save-buffer)
(define-key evil-normal-state-map [tab] 'indent-for-tab-command)
(define-key evil-normal-state-map "go" 'ff-find-other-file)
(define-key evil-normal-state-map (kbd "C-p") 'company-complete)
(define-key evil-normal-state-map (kbd "M-h") 'split-window-horizontally)
(define-key evil-normal-state-map (kbd "M-.") 'ggtags-find-other-symbol)
(define-key evil-normal-state-map (kbd "M-u") 'upcase-word)

;;(define-key evil-normal-state-map (kbd "<C-tab>") 'mode-line-other-buffer)
(define-key evil-insert-state-map (kbd "C-d") 'delete-char)
(define-key evil-insert-state-map (kbd "C-c") 'fa-abort)

(define-key evil-visual-state-map [tab] 'indent-for-tab-command)

(define-key evil-normal-state-map (kbd "C-k") 'kill-buffer)

(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)

(define-key minibuffer-local-map [esc] 'keyboard-quit)

(global-set-key [f7] 'c-print)

(define-key evil-motion-state-map " " 'switch-to-buffer)
(define-key evil-motion-state-map (kbd "C-o") 'find-file)
(define-key evil-motion-state-map (kbd "C-,") 'evil-jump-backward)

;; Scrolling
(setq redisplay-dont-pause t)
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)
(setq auto-window-vscroll nil)
(setq mouse-wheel-scroll-amount '(4 ((shift) . 4)))

;; Hooks
(add-hook 'text-mode-hook 'auto-fill-mode)

(set-face-attribute 'default nil
                    :family "DejaVu Sans Mono"
                    :height 100
                    :weight 'normal
                    :width 'normal)

(load-theme 'coffee t)
(push '(compilation-mode :height 15 :position bottom :noselect 1 :stick 1) popwin:special-display-config)

;; Miscelaneous Variables
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq compile-command "build.bat")
(setq program "d:/dev/sculpture/bin/sculpture.exe")
(setq default-directory "d:/dev/sculpture/")
(setq fill-column 80)
(setq undo-limit 20000)
(setq show-paren-delay 0)
(setq vc-handled-backends nil)
(setq frame-title-format (concat "%b - emacs"))
(setq make-backup-files nil)
(setq completion-styles '(substring basic))

;; Stop beeping.
(setq visible-bell nil
      ring-bell-function #'ignore)

(setq inhibit-startup-screen t)

(setq compilation-scroll-output t)
(setq compilation-ask-about-save nil)
(setq completion-ignore-case t)

(defun project-open-all-files(extension)
  (interactive (list (read-string "Extension: " (file-name-extension (buffer-file-name))))) ; Default value.
  (use-package dired-x)
  (dired ".")                             ; Open Dired
  (dired-mark-suffix extension)           ; Mark all appropriate source files.
  (setq dired-buffer-name (buffer-name))  ; Save the name of the dired buffer.
  (dired-do-find-marked-files 4)          ; Open all the marked files.
  ;; (switch-to-buffer (concat "main." extension)) ; Switch to the main file.
  (delete-other-windows)                  ; Delete the other windows generated.
  (split-window-horizontally)             ; Duplicate window.
  (kill-buffer dired-buffer-name)         ; Kill the dired buffer.
  (message (concat "All ." extension " files in " dired-buffer-name "/ are opened.")))
(defun insert-line-above()
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line)
  (indent-according-to-mode))
(defun insert-line-below()
  (interactive)
  (end-of-line)
  (newline)
  (indent-according-to-mode))
(defun reload-init-file()
  (interactive)
  (load-file user-init-file))
(defun goto-init-file()
  (interactive)
  (find-file user-init-file))
(defun backward-delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))
(defun forward-delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun open-folder()
  "Opens the current folder at current directory."
  (interactive)
  (shell-command "start."))
(defun open-cmd()
  "Opens the command prompt at current directory."
  (interactive)
  (call-process-shell-command "cmder" nil 0)) ; Using this instead of async-shell-command to avoid creating an output buffer.
(defun run-program()
  "Run program using compilation."
  (interactive)
  (setq temp compile-command)
  (compile program)
  (setq compile-command temp))
(defun set-program()
  "Prompt user to enter a file name, with completion and history support."
  (interactive)
  (setq program (read-file-name "Enter executable: ")))
;; Goodies
(defun load-current-goodie()
  "Loads a link on the current line in chrome's incognito mode"
  (interactive)
  (setq-local curr-line (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
  (setq-local goodie-command (concat "\"C:/Program Files/Google/Chrome/Application/chrome.exe\" -incognito " curr-line))
  (shell-command goodie-command))
(defun load-selected-goodies()
  "Loads all the link in the region in chrome's incognito mode"
  (interactive)
  (setq-local list (buffer-substring (mark) (point)))
  (setq-local list (split-string list "\n"))
  (setq-local list (butlast list)) ; Remove the last element of the list, which is empty.
  (setq-local links "")
  (while list
	(setq-local links (concat links (car list) " "))
    (setq-local list (cdr list)))
  (setq-local goodie-command (concat "\"C:/Program Files/Google/Chrome/Application/chrome.exe\" -incognito " links))
  (message goodie-command)
  (shell-command goodie-command))
(defun load-goodie()
  "Loads all the link in the region OR loads the link on the current line in chrome's incognito mode"
  (interactive)
  (if (use-region-p) (load-selected-goodies) (load-current-goodie)))
(defun load-goodie-file()
  (interactive)
  (find-file "D:/Notes/goodies.txt"))
(defun c-print()
  (interactive)
  (insert "printf(\"\\n\"); fflush(stdout);")
  (back-to-indentation)
  (c-indent-line-or-region)
  (forward-char 8))
(fset 'mark-most-buffers
      (kmacro-lambda-form [?\M-x ?i ?b ?u ?f ?f ?e ?r return ?% ?m ?* ?. ?* return] 0 "%d"))

(global-set-key (kbd "M-i") 'mark-most-buffers)

;; (define-key evil-normal-state-map (kbd "C-.") 'imenu-anywhere)

(global-set-key [f4] 'load-goodie)
(global-set-key [C-f4] 'load-goodie-file)

(global-set-key (kbd "C-;") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-;") 'dabbrev-expand)

(global-set-key (kbd "C-u") 'other-window)
(global-set-key (kbd "C-w") 'kill-current-buffer)
(global-set-key (kbd "C-c o") 'project-open-all-files)
(global-set-key (kbd "C-c u") 'helm-multi-swoop-current-mode)
(global-set-key (kbd "C-c h") 'helm-occur)
(global-set-key (kbd "M-o") 'center-line)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key [f8] 'goto-init-file)
(global-set-key [M-f8] 'reload-init-file)
(global-set-key [f1] 'start-kbd-macro)
(global-set-key [f2] 'end-kbd-macro)
(global-set-key [f3] 'call-last-kbd-macro)
(global-set-key [C-f5] 'compile);-new-frame
(global-set-key [f5] 'recompile);-new-frame
(global-set-key [f6] 'run-program)
(global-set-key [C-f6] 'set-program)
(global-set-key [f10] 'projectile-ripgrep)
(global-set-key [f11] 'open-cmd)
(global-set-key [f12] 'open-folder)
(global-set-key (kbd "M-p") 'move-text-line-up)
(global-set-key (kbd "M-n") 'move-text-line-down)
(global-set-key [M-up] 'move-text-line-up)
(global-set-key [M-down] 'move-text-line-down)
(global-set-key (kbd "C-c C-s") 'fill-region)
(global-set-key (kbd "C-=") 'quick-calc)
(global-set-key (kbd "M-:") 'first-error)
(global-set-key (kbd "M-}") 'next-error)
(global-set-key (kbd "M-{") 'previous-error)
;; (global-set-key (kbd "<C-tab>") 'mode-line-other-buffer)
(global-set-key (kbd "M-s") 'window-swap-states)
(global-set-key (kbd "C-S-y") 'indent-region)
(global-set-key (kbd "M-y") 'yank-pop)
(global-set-key (kbd "C-q") 'replace-string)
(global-set-key (kbd "M-q") 'query-replace)
(global-set-key (kbd "C-M-q") 'replace-regexp)
(global-set-key (kbd "C-M-S-q") 'query-replace-regexp)
(global-set-key (kbd "M-e") 'delete-window)
(global-set-key (kbd "M-a") 'delete-other-windows)
(global-set-key (kbd "M-h") 'split-window-horizontally)
(global-set-key (kbd "C-S-k") 'kill-current-buffer)
(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "C-S-n") 'forward-paragraph)

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-enter-times-out t)
 '(custom-safe-themes
   '("040c4d3a34e15b2a095247301ec7b5227417d7422c10a12145ad57b53dbc43c6" "003f1ec564814ba4c0bbf918a392cd32171a462cc13100ac3e383ddb31437d19" "e97291d5d27a6e03d884a2e460ba6eb743ed37e85d9b013d54895093d9aa3638" default))
 '(eldoc-idle-delay 0)
 '(evil-want-Y-yank-to-eol t)
 '(fa-delay 0.2)
 '(ggtags-executable-directory "D:/Programs/gnuglobal/bin/")
 '(moo-do-includes nil)
 '(moo-select-method 'ivy)
 '(package-selected-packages
   '(function-args eldoc ac-etags dumb-jump projectile gtags-mode helm-core helm undo-tree ace-jump-mode consult yasnippet-snippets which-key waher-theme vterm vertico use-package-hydra tramp-theme swiper spaceline selectrum rustic rust-mode rtags ripgrep project-explorer popwin naysayer-theme nano-theme multiple-cursors move-text mini-frame magit lush-theme lsp-ui lsp-dart lab-themes key-chord json-mode jazz-theme irony imenu-anywhere iedit hover helm-xref helm-swoop helm-lsp helm-gtags good-scroll god-mode go-rename go-eldoc go-dlv go-complete go-autocomplete glsl-mode ggtags frame-local flycheck-golangci-lint evil-visual-mark-mode esup csharp-mode crux company-c-headers clues-theme cloc chess ccls bury-successful-compilation bongo basic-theme anzu almost-mono-themes))
 '(projectile-globally-ignored-file-suffixes '(".exe" ".pdb"))
 '(projectile-globally-ignored-files '("TAGS" "GPATH" "GRTAGS" "GTAGS"))
 '(semantic-c-dependency-system-include-path '("d:/msys64/mingw64/include/" "d:/_MinGW/include/"))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-goto-char-timer-face ((t (:background "pink" :foreground "black" :weight bold))))
 '(ivy-current-match ((t nil))))
