(require 'package)
(when (not (assoc "melpa" package-archives))
  (setq package-archives (append '(("stable" . "https://stable.melpa.org/packages/")) package-archives))
  (setq package-archives (append '(("melpa" . "https://melpa.org/packages/")) package-archives))
  (setq package-archives (append '(("gnu" . "https://elpa.gnu.org/packages/")) package-archives)))
(package-initialize)


(setq backup-directory-alist '(("" . "D:/emacs_backup/")))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

;; Stop emacs from beeping whenever I press C-g
(setq visible-bell nil
      ring-bell-function #'ignore)

(setq inhibit-startup-screen t)

(setq default-directory "d:/dev/GunBlade/")

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

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'super)

;; (add-hook 'c-mode-hook 'lsp)
;; (add-hook 'c-mode-hook 'yas-minor-mode)
;; (add-hook 'c++-mode-hook 'lsp)
;; (add-hook 'c++-mode-hook 'yas-minor-mode)

(setq vc-handled-backends ()) ;; Disable git integration

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 1)
(selectrum-mode 1)

(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)

(delete-selection-mode 1)
(electric-indent-mode 1)
(electric-pair-mode 0)
(setq show-paren-delay 0)

;(define-key global-map [remap switch-to-buffer] #'helm-mini)

(add-hook 'text-mode-hook 'auto-fill-mode)
;;Load Go-specific language syntax
;;For gocode use https://github.com/mdempsky/gocode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load auto-complete
;(ac-config-default)
;(require 'auto-complete-config)
;(require 'go-autocomplete)

;; Go rename
(require 'go-rename)

;; Other Key bindings
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;; Compilation autoscroll
(setq compilation-scroll-output t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; I think these help lsp-mode with performance.
;; (setq company-idle-delay 0.2)
;; (setq lsp-idle-delay 'company-idle-delay)
;; (setq company-minimum-prefix-length 1)

(setq ns-function-modifier 'control)

(setq mouse-wheel-scroll-amount '(5 ((shift) . 5)))
(setq mouse-wheel-progressive-speed nil)

(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default compile-command "c.bat")
(setq-default fill-column 80)

(setq-default program "gungame.exe")

(add-to-list 'load-path "~/.emacs.d/lisp/")

(defun run-program()
  "Runs the program from the current directory."
  (interactive)
  (async-shell-command program))

(defun set-program()
  "Prompt user to enter a file name, with completion and history support."
  (interactive)
  (setq program (read-file-name "Enter executable: ")))

(defun open-folder()
  "Opens the current folder at current directory."
  (interactive)
  (shell-command "start."))

(defun open-cmd()
  "Opens the command prompt at current directory."
  (interactive)
  (async-shell-command "start"))

(defun mark-whole-word()
  (interactive)
  (backward-word)
  (call-interactively 'set-mark-command)
  (forward-word))

(defun mark-whole-sexp()
  (interactive)
  (backward-sexp)
  (call-interactively 'set-mark-command)
  (forward-sexp))

(defun goto-init-file()
  (interactive)
  (find-file user-init-file)
)

(defun reload-init-file()
  (interactive)
  (load-file user-init-file)
)

(defun on-top()
  (interactive)
  (menu-bar-mode 1)
  (tool-bar-mode 1)
  (scroll-bar-mode 1))

(defun off-top()
  (interactive)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))

(defun set-frame-alpha (arg &optional active)
  (interactive "nEnter alpha value (1 - 100): \np")
  (let* ((elt (assoc 'alpha default-frame-alist))
         (old (frame-parameter nil 'alpha))
         (new (cond ((atom old)     `(,arg ,arg))
                    ((eql 1 active) `(,arg ,(cadr old)))
                    (t              `(,(car old) ,arg)))))
    (if elt (setcdr elt new) (push `(alpha ,@new) default-frame-alist))
    (set-frame-parameter nil 'alpha new)))

(defun open-private-url(url)
  (interactive "sEnter URL: \n")
  (shell-command (concat "firefox -private-window " url))
)

(global-set-key (kbd "C-c f") 'gofmt)
(global-set-key (kbd "C-c o") 'open-private-url)

(global-set-key (kbd "C-c C-u") 'go-remove-unused-imports)

(global-set-key [C-f12] 'goto-init-file)
(global-set-key [M-f12] 'reload-init-file)

(global-set-key [f7] 'godoc-at-point)

(global-set-key [f1]  'start-kbd-macro)
(global-set-key [f2]  'end-kbd-macro)
(global-set-key [f3]  'call-last-kbd-macro)

(global-set-key [C-f5]  'compile)
(global-set-key [f5]    'recompile)
(global-set-key [f6]    'run-program)
(global-set-key [C-f6]  'set-program)

(global-set-key [f10]   'projectile-ripgrep)
(global-set-key [f11]   'open-cmd)
(global-set-key [f12]   'open-folder)

(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-j") 'ivy-switch-buffer)

(global-set-key (kbd "M-p") 'move-text-line-up)
(global-set-key (kbd "M-n") 'move-text-line-down)
(global-set-key [M-up]      'move-text-line-up)
(global-set-key [M-down]    'move-text-line-down)

;(global-set-key [C-f12] 'gdb)

(global-set-key (kbd "<M-mouse-2>") 'mouse-buffer-menu)

(global-set-key (kbd "C-c C-s") 'fill-region)

(global-set-key (kbd "C-=") 'quick-calc)

(global-set-key (kbd "M-:") 'first-error)
(global-set-key (kbd "M-}") 'next-error)
(global-set-key (kbd "M-{") 'previous-error)

(global-set-key (kbd "C-z") 'undo)

(global-set-key (kbd "<C-tab>") 'mode-line-other-buffer)
(global-set-key (kbd "C-S-d") 'kill-whole-line)

(global-set-key (kbd "<C-return>") 'insert-line-above)
(global-set-key (kbd "<C-S-return>") 'insert-line-below)

(global-set-key (kbd "M-s") 'window-swap-states)

(global-set-key (kbd "C-S-k") 'kill-current-buffer)
(global-set-key (kbd "C-x w") 'kill-current-buffer)

(global-set-key (kbd "M-j") 'ff-find-other-file)
(global-set-key (kbd "M-k") 'mark-whole-buffer)

;; (require 'lsp)
;; (define-key lsp-mode-map (kbd "C-S-SPC") 'set-mark-command)
;; (define-key lsp-mode-map (kbd "<C-return>") 'lsp-find-definition)
;; (define-key lsp-mode-map (kbd "<C-S-return>") 'lsp-find-references)
;; (define-key lsp-mode-map (kbd "M-r") 'lsp-rename)

(global-set-key (kbd "C-q") 'replace-string)
(global-set-key (kbd "M-q") 'query-replace)
(global-set-key (kbd "C-M-q") 'replace-regexp)
(global-set-key (kbd "C-M-S-q") 'query-replace-regexp)

(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "C-S-n") 'forward-paragraph)

(global-set-key (kbd "C-S-f") 'forward-sexp)
(global-set-key (kbd "C-S-b") 'backward-sexp)

(global-set-key (kbd "C-o") 'projectile-find-file)
;(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-u") 'other-window)

(global-set-key (kbd "M-e") 'delete-window)
(global-set-key (kbd "M-a") 'delete-other-windows)
(global-set-key (kbd "M-y") 'split-window-horizontally)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#32302f" "#fb4933" "#98971a" "#d79921" "#458588" "#d3869b" "#689d6a" "#282828"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#689d6a")
 '(cua-normal-cursor-color "#a89984")
 '(cua-overwrite-cursor-color "#d79921")
 '(cua-read-only-cursor-color "#98971a")
 '(custom-enabled-themes '(junio))
 '(custom-safe-themes
   '("0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "46b2d7d5ab1ee639f81bde99fcd69eb6b53c09f7e54051a591288650c29135b0" "b5e75f219d41e6e3516560ac493d808b621a99847d6128ce8e6c74b1495ce875" "d3c80a59b17a34fd62336e753743e14ffcd3de07cd78b8b61a6df4c0026bcb2b" "13bb60578fddd069b3fa75e6c53293a836bdf68ee970dc35084137df22c65831" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "432c44ce7e3b2418e413425d5a7053fa0ed2d77ab5cc1261481e86234eba76a5" "62c5f3d9045997edf73e2a9ef027ff4029effde71972d6c3efd683100a66b215" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "8f567db503a0d27202804f2ee51b4cd409eab5c4374f57640317b8fcbbd3e466" "5d59bd44c5a875566348fa44ee01c98c1d72369dc531c1c5458b0864841f887c" "8b58ef2d23b6d164988a607ee153fd2fa35ee33efc394281b1028c2797ddeebb" "669b0c23ee436f297bb286f46daeea9b8ec322cb50758e7ad704d68b36271da3" "f8aa0da2755c476ab683c124df22a7c8aced57caed23d887849e7cade149580e" "f7b2b47cce08a9a6034d04048e9b0cef443e4ea7d3254194b7159b04fae8add7" "98a9469270cbfe77f1cedfdfe46139dbe1401e5af6f87767362aeaf38c6b1211" "fe36e4da2ca97d9d706e569024caa996f8368044a8253dc645782e01cd68d884" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" "73fa7f35aa862e29b07de70966a29636a3fcd98215072ef3988c82fa02ee6845" default))
 '(display-time-mode t)
 '(fci-rule-color "#32302f")
 '(gdb-many-windows t)
 '(helm-completion-style 'emacs)
 '(highlight-changes-colors '("#d3869b" "#b16286"))
 '(highlight-symbol-colors
   '("#522a41fa2b3b" "#3821432637ec" "#5bbe348b2bf5" "#483d36c73def" "#43c0418329b9" "#538f36232679" "#317a3ddc3e5d"))
 '(highlight-symbol-foreground-color "#bdae93")
 '(highlight-tail-colors
   '(("#32302f" . 0)
	 ("#747400" . 20)
	 ("#2e7d33" . 30)
	 ("#14676b" . 50)
	 ("#a76e00" . 60)
	 ("#a53600" . 70)
	 ("#9f4d64" . 85)
	 ("#32302f" . 100)))
 '(hl-bg-colors
   '("#a76e00" "#a53600" "#b21b0a" "#9f4d64" "#8b2a58" "#14676b" "#2e7d33" "#747400"))
 '(hl-fg-colors
   '("#282828" "#282828" "#282828" "#282828" "#282828" "#282828" "#282828" "#282828"))
 '(hl-paren-colors '("#689d6a" "#d79921" "#458588" "#b16286" "#98971a"))
 '(linum-format " %5i ")
 '(lsp-ui-doc-border "#bdae93")
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   '("#fb4933" "#d65d0e" "#d79921" "#747400" "#b9b340" "#14676b" "#689d6a" "#d3869b" "#b16286"))
 '(package-selected-packages
   '(go-dlv bury-successful-compilation go-autocomplete auto-complete go-rename projectile crux selectrum dumb-jump go-complete move-text go-mode sublime-themes waher-theme good-scroll zenburn-theme yasnippet which-key use-package solarized-theme rustic rust-mode rtags ripgrep naysayer-theme monokai-theme monokai-alt-theme molokai-theme magit lsp-ui lsp-dart key-chord ivy irony iedit hover helm-xref helm-lsp helm-gtags god-mode glsl-mode ggtags evil-visual-mark-mode esup elcord csharp-mode company-c-headers chess ccls c-eldoc bongo arjen-grey-theme))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(pos-tip-background-color "#32302f")
 '(pos-tip-foreground-color "#bdae93")
 '(selectrum-mode t)
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#98971a" "#32302f" 0.2))
 '(term-default-bg-color "#282828")
 '(term-default-fg-color "#a89984")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#fb4933")
	 (40 . "#eb7b77d82bd3")
	 (60 . "#e21e8997270c")
	 (80 . "#d79921")
	 (100 . "#c321997a1eab")
	 (120 . "#b8ac99341d7b")
	 (140 . "#ae1e98cb1c53")
	 (160 . "#a37098411b32")
	 (180 . "#98971a")
	 (200 . "#8bd699a03aed")
	 (220 . "#84849aa247bf")
	 (240 . "#7c5b9ba153ba")
	 (260 . "#731d9c9f5f38")
	 (280 . "#689d6a")
	 (300 . "#5cb793cf76ed")
	 (320 . "#55e88efd7cec")
	 (340 . "#4e348a3982c8")
	 (360 . "#458588")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#282828" "#32302f" "#b21b0a" "#fb4933" "#747400" "#98971a" "#a76e00" "#d79921" "#14676b" "#458588" "#9f4d64" "#d3869b" "#2e7d33" "#689d6a" "#a89984" "#282828"))
 '(xterm-color-names
   ["#32302f" "#fb4933" "#98971a" "#d79921" "#458588" "#d3869b" "#689d6a" "#a89984"])
 '(xterm-color-names-bright
   ["#282828" "#d65d0e" "#7c6f64" "#282828" "#a89984" "#b16286" "#bdae93" "#fbf1c7"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil :family "Liberation Mono" :foundry "outline" :slant normal :weight normal :height 102 :width normal)))))
