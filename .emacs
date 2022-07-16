(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Set modes
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(electric-indent-mode 1)
(delete-selection-mode 1)
(show-paren-mode 1)
(vertico-mode 1)
(popwin-mode 1)
(evil-mode 1)

;; Undo Tree
(with-eval-after-load 'undo-tree
  (setq undo-tree-auto-save-history nil))

;; Evil mode

(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)
(define-key evil-normal-state-map (kbd "M-s") 'ace-jump-char-mode)
(define-key evil-normal-state-map "s" 'ace-jump-mode)
(define-key evil-normal-state-map (kbd "C-s") 'evil-substitute)
(define-key evil-normal-state-map "R" 'string-rectangle)
(define-key evil-normal-state-map (kbd "C-t") 'transpose-chars)

(define-key evil-normal-state-map "e" 'save-buffer)
(define-key evil-visual-state-map [tab] 'c-indent-line-or-region)
(define-key evil-normal-state-map [tab] 'c-indent-line-or-region)
(define-key evil-normal-state-map "m" 'back-to-indentation)
(define-key evil-normal-state-map "go" 'ff-find-other-file)
(define-key evil-normal-state-map "q" 'other-window)
(define-key evil-normal-state-map "\M-f" 'find-file-other-window)
(define-key evil-normal-state-map "K" 'kill-buffer)

(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-e") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-e") 'kevil-normal-state)

(define-key evil-motion-state-map " " 'switch-to-buffer)
(define-key evil-motion-state-map (kbd "C-SPC") 'find-file)
 
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
                    :height 110
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
(setq fill-column 80)
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
  (call-process-shell-command "start" nil 0)) ; Using this instead of async-shell-command to avoid creating an output buffer.
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
  (forward-char 8)
)

(define-key evil-normal-state-map (kbd "C-.") 'imenu-anywhere)

(global-set-key (kbd "C-c p") 'c-print)

(global-set-key [f4] 'load-goodie)
(global-set-key [C-f4] 'load-goodie-file)

(global-set-key (kbd "C-;") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-;") 'dabbrev-expand)

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
(global-set-key (kbd "<C-tab>") 'mode-line-other-buffer)
(global-set-key (kbd "C-M-s") 'window-swap-states)
(global-set-key (kbd "C-S-k") 'kill-current-buffer)
(global-set-key (kbd "M-k") 'mark-whole-buffer)
(global-set-key (kbd "C-S-y") 'indent-region)
(global-set-key (kbd "M-y") 'yank-pop)
(global-set-key (kbd "C-,") 'pop-to-mark-command)
(global-set-key (kbd "C-q") 'replace-string)
(global-set-key (kbd "M-q") 'query-replace)
(global-set-key (kbd "C-M-q") 'replace-regexp)
(global-set-key (kbd "C-M-S-q") 'query-replace-regexp)
(global-set-key (kbd "M-e") 'delete-window)
(global-set-key (kbd "M-a") 'delete-other-windows)
(global-set-key (kbd "M-h") 'split-window-horizontally)
(global-set-key (kbd "C-j") 'imenu)
(global-set-key (kbd "C-S-j") 'imenu-anywhere)

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-enter-times-out t)
 '(custom-safe-themes
   '("040c4d3a34e15b2a095247301ec7b5227417d7422c10a12145ad57b53dbc43c6" "003f1ec564814ba4c0bbf918a392cd32171a462cc13100ac3e383ddb31437d19" "e97291d5d27a6e03d884a2e460ba6eb743ed37e85d9b013d54895093d9aa3638" default))
 '(evil-undo-system 'undo-tree)
 '(package-selected-packages
   '(gtags-mode helm-core helm undo-tree ac-etags ace-jump-mode consult yasnippet-snippets which-key waher-theme vterm vertico use-package-hydra tramp-theme swiper spaceline selectrum rustic rust-mode rtags ripgrep project-explorer popwin naysayer-theme nano-theme multiple-cursors move-text mini-frame magit lush-theme lsp-ui lsp-dart lab-themes key-chord json-mode jazz-theme irony imenu-anywhere iedit hover helm-xref helm-swoop helm-lsp helm-gtags good-scroll god-mode go-rename go-eldoc go-dlv go-complete go-autocomplete glsl-mode ggtags frame-local flycheck-golangci-lint evil-visual-mark-mode esup dumb-jump csharp-mode crux company-c-headers clues-theme cloc chess ccls c-eldoc bury-successful-compilation bongo basic-theme anzu almost-mono-themes))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-goto-char-timer-face ((t (:background "pink" :foreground "black" :weight bold)))))
