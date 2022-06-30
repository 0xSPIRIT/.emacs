;; Set modes
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(electric-indent-mode 1)
(delete-selection-mode 1)
(show-paren-mode 1)
(popwin-mode 1)

;; Scrolling
(setq redisplay-dont-pause t)
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)
(setq fast-but-imprecise-scrolling t)
(setq auto-window-vscroll nil)
(setq mouse-wheel-scroll-amount '(4 ((shift) . 4)))

;; Hooks
(add-hook 'text-mode-hook 'auto-fill-mode)

(set-face-attribute 'default nil
                    :family "Consolas"
                    :height 110
                    :weight 'normal
                    :width 'normal)

(load-theme 'coffee t)
(push '(compilation-mode :height 15 :position bottom :noselect 1 :stick 1) popwin:special-display-config)

;; Miscelaneous Variables
(setq c-basic-offset 4)
(setq-default tab-width 4)
(setq indent-tabs-mode nil)
(setq compile-command "build.bat")
(setq program "d:/dev/sculpture/bin/sculpture.exe")
(setq fill-column 80)
(setq show-paren-delay 0)
(setq vc-handled-backends nil)
(setq frame-title-format (concat "%b - emacs"))
(setq make-backup-files nil)

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

(global-set-key (kbd "C-z") 'undo)

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c C-j") 'eval-last-sexp)
(global-set-key (kbd "C-c j") 'eval-region)
(global-set-key (kbd "C-c o") 'project-open-all-files)
(global-set-key [C-f11] 'toggle-frame-fullscreen)
(global-set-key (kbd "C-<backspace>") 'backward-delete-word)
(global-set-key (kbd "M-d") 'forward-delete-word)
(global-set-key (kbd "C-c u") 'helm-multi-swoop-current-mode)
(global-set-key (kbd "C-c h") 'helm-occur)
(global-set-key (kbd "M-o") 'center-line)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-y") 'yank)
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
(global-set-key (kbd "<M-mouse-2>") 'mouse-buffer-menu)
(global-set-key (kbd "C-c C-s") 'fill-region)
(global-set-key (kbd "C-=") 'quick-calc)
(global-set-key (kbd "M-:") 'first-error)
(global-set-key (kbd "M-}") 'next-error)
(global-set-key (kbd "M-{") 'previous-error)
(global-set-key (kbd "<C-tab>") 'mode-line-other-buffer)
(global-set-key (kbd "C-S-d") 'kill-whole-line)
(global-set-key (kbd "<C-return>") 'insert-line-above)
(global-set-key (kbd "<C-S-return>") 'insert-line-below)
(global-set-key (kbd "M-s") 'window-swap-states)
(global-set-key (kbd "C-S-k") 'kill-current-buffer)
(global-set-key (kbd "M-j") 'ff-find-other-file)
(global-set-key (kbd "M-k") 'mark-whole-buffer)
(global-set-key (kbd "C-S-y") 'indent-region)
(global-set-key (kbd "M-y") 'yank-pop)
(global-set-key (kbd "C-,") 'pop-to-mark-command)
(global-set-key (kbd "C-q") 'replace-string)
(global-set-key (kbd "M-q") 'query-replace)
(global-set-key (kbd "C-M-q") 'replace-regexp)
(global-set-key (kbd "C-M-S-q") 'query-replace-regexp)
(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "C-S-n") 'forward-paragraph)
(global-set-key (kbd "C-S-f") 'forward-sexp)
(global-set-key (kbd "C-S-b") 'backward-sexp)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-u") 'other-window)
(global-set-key (kbd "M-e") 'delete-window)
(global-set-key (kbd "M-a") 'delete-other-windows)
(global-set-key (kbd "M-h") 'split-window-horizontally)
(global-set-key (kbd "C-S-j") 'helm-imenu-anywhere)
(global-set-key (kbd "C-j") 'helm-imenu)
