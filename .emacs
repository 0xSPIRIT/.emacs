(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq-default frame-title-format '("%b"))

(setq backup-directory-alist '(("" . "D:/emacs_backup/")))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

;; Stop emacs from beeping whenever I press C-g
(setq visible-bell nil
      ring-bell-function #'ignore)

(setq inhibit-startup-screen t)

(set-face-attribute 'default nil :height 100)

(setq default-directory "d:/dev/alaska/")

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

(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  )

(add-hook 'text-mode-hook 'disable-tabs)
(add-hook 'go-mode-hook 'enable-tabs)

(setq gofmt-command "goimports")
;; (add-hook 'before-save-hook 'gofmt-before-save)

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'super)

;; (add-hook 'c-mode-hook 'lsp)
;; (add-hook 'c-mode-hook 'yas-minor-mode)
;; (add-hook 'c++-mode-hook 'lsp)
;; (add-hook 'c++-mode-hook 'yas-minor-mode)

(add-hook 'c-mode-hook 'helm-ggtags-mode)

(setq company-idle-delay 0)
(setq lsp-idle-delay 0)
(setq company-minimum-prefix-length 2)

(setq vc-handled-backends ()) ;; Disable git integration

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 1)
(selectrum-mode t)
(ido-mode t)

(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)

(delete-selection-mode 1)
(electric-indent-mode 1)
(electric-pair-mode 0)
(setq show-paren-delay 0)

;; Setting up dumb-jump
(setq dumb-jump-force-searcher 'rg)

(add-hook 'fundamental-mode-hook 'auto-fill-mode)
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

(setq ns-function-modifier 'control)

(setq mouse-wheel-scroll-amount '(5 ((shift) . 5)))
(setq mouse-wheel-progressive-speed nil)

(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default compile-command "c.bat")
(setq-default program "alaska.exe")
(setq-default fill-column 80)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq completion-ignore-case t)
(setq imenu-max-items 3)
(setq imenu-anywhere-buffer-filter-functions '(imenu-anywhere-same-mode-p))

(global-set-key (kbd "C-c i") #'ido-imenu-anywhere)
(global-set-key (kbd "C-.") #'ido-imenu-anywhere)

(use-package dired-x)

(defun go-project-isearch()
  (interactive)
  (dired ".")
  (dired-mark-suffix "go")
  (dired-do-isearch)
)

(defun go-project-open-all-files()
  (interactive)
  (dired ".")
  (dired-mark-suffix "go")
  (dired-do-find-marked-files 4)
  (switch-to-buffer "main.go")
  (delete-other-windows)
  (split-window-horizontally)
  (kill-buffer "alaska")
  (message "All .go files in alaska are opened.")
  )

(global-set-key (kbd "C-c s") 'go-project-isearch)
(global-set-key (kbd "C-c o") 'go-project-open-all-files)

(defun set-program()
  "Prompt user to enter a file name, with completion and history support."
  (interactive)
  (setq program (read-file-name "Enter executable: ")))

(defun run-program()
  "Run program using compilation."
  (interactive)
  (compile program))

(defun open-folder()
  "Opens the current folder at current directory."
  (interactive)
  (shell-command "start."))

(defun open-cmd()
  "Opens the command prompt at current directory."
  (interactive)
  (call-process-shell-command "start" nil 0)) ; Using this instead of async-shell-command to avoid creating an output buffer.

;; Kill text by word without adding it to the kill ring.
(defun backward-delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

(defun forward-delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

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

(defun yank-and-indent ()
  "Yank and indent yanked material according to mode."
  (interactive)
  (yank)
  (indent-region (point-min) (point-max))
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

;; (defun open-private-url(url)
;;   (interactive "sEnter URL: \n")
;;   (shell-command (concat "firefox -private-window " url))
;;   )

(defun set-frame-alpha (arg &optional active)
  (interactive "nEnter alpha value (1-100): \np")
  (let* ((elt (assoc 'alpha default-frame-alist))
         (old (frame-parameter nil 'alpha))
         (new (cond ((atom old)     `(,arg ,arg))
                    ((eql 1 active) `(,arg ,(cadr old)))
                    (t              `(,(car old) ,arg)))))
    (if elt (setcdr elt new) (push `(alpha ,@new) default-frame-alist))
    (set-frame-parameter nil 'alpha new)))

;; Kill text without adding to kill ring.
;; Use M-<backspace> for vanilla behaviour.
(global-set-key (kbd "C-<backspace>") 'backward-delete-word)
(global-set-key (kbd "M-d") 'forward-delete-word)

(global-set-key (kbd "C-z") 'undo-only)
(global-set-key (kbd "C-S-z") 'undo-redo)

(global-set-key (kbd "C-y") 'yank)

(global-set-key (kbd "C-c t") 'set-frame-alpha)
(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "C-c f") 'gofmt)

(global-set-key (kbd "C-c C-u") 'go-remove-unused-imports)

(global-set-key (kbd "M-r") 'go-rename)

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

(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-j")   'switch-to-buffer)

(global-set-key (kbd "M-p") 'move-text-line-up)
(global-set-key (kbd "M-n") 'move-text-line-down)
(global-set-key [M-up]      'move-text-line-up)
(global-set-key [M-down]    'move-text-line-down)

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
(global-set-key (kbd "C-x w") 'kill-current-buffer)

(global-set-key (kbd "M-j") 'ff-find-other-file)
(global-set-key (kbd "M-k") 'mark-whole-buffer)

(global-set-key (kbd "C-S-y") 'indent-region)
(global-set-key (kbd "M-y") 'yank-pop)

;; (require 'lsp)
;; (define-key lsp-mode-map (kbd "C-S-SPC") 'set-mark-command)
;; (define-key lsp-mode-map [C-return] 'lsp-find-definition)
;; (define-key lsp-mode-map [C-S-return] 'lsp-find-references)
;; (define-key lsp-mode-map (kbd "M-r") 'lsp-rename)

(global-set-key (kbd "C-,") 'pop-to-mark-command)

(global-set-key (kbd "C-q") 'replace-string)
(global-set-key (kbd "M-q") 'query-replace)
(global-set-key (kbd "C-M-q") 'replace-regexp)
(global-set-key (kbd "C-M-S-q") 'query-replace-regexp)

(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "C-S-n") 'forward-paragraph)

(global-set-key (kbd "C-S-f") 'forward-sexp)
(global-set-key (kbd "C-S-b") 'backward-sexp)

(global-set-key (kbd "C-o") 'projectile-find-file)

(global-set-key (kbd "C-u") 'other-window)

(global-set-key (kbd "M-e") 'delete-window)
(global-set-key (kbd "M-a") 'delete-other-windows)
(global-set-key (kbd "M-h") 'split-window-horizontally)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#32302f" "#fb4933" "#98971a" "#d79921" "#458588" "#d3869b" "#689d6a" "#282828"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#689d6a")
 '(cua-normal-cursor-color "#a89984")
 '(cua-overwrite-cursor-color "#d79921")
 '(cua-read-only-cursor-color "#98971a")
 '(custom-enabled-themes '(them))
 '(custom-safe-themes
   '("731f8f2854c054c4efc63532deff53bfb2f4e7be5d596abe9cba41f110f76bc3" "76de67a83c466b9cb5f6315f56b502fef722aa11b09e7bda222741475feda420" "7c2f9fdbbbcea08aaf6794f83822aa3f4d27fdc4e7c62ca021363570100b1402" "cba9a53495fcc9fb7c6f9d82d5806cfd3c77d4b999dc6e540fabeda26e24ae71" "2b73fb36900085ed72dedc7e9b88e53c09e8dfcd0ce7cfafafbd119b26cfcfb1" "2152c151282e3d4c0b9d277ca1a3384c01561b59d53ff352298c00bae3de153c" "3007cdb606d4d0ca534efbcbf42a2e238d3fd0d6ba2fe06303f6af20fe3e4548" "d48402cdd10e08df90a9bd3f1581af657739f07002e571fd7fbad6e3fb26ff41" "0302cba0d0f4db3d12403670e2057066800cf06479f9944e4f524157c807395b" "b8774fd6c7014df18232911a1a8ad54942c8107ac5fe6df713fbe5842c20496b" "043437278716221d5b26932498657b7a88bd58d78d291b24a4fe2167f48ae97f" "23f0e9424bbe173293aa7e85c10801ffd4b4418d2188095a9ef0d0fc067443f5" "2dee857a617b186d7e03036d653348b0f2721362e5aa3d6dbbba7d6334c5cc79" "b4ae60f388f8ed3491673df35ce73960ff59d8197ea13b23c2d40ffab9f280e2" "1ef5f1be156b14870401996e79a9caec9991ca0b2c31eb917ee1bbbb835a463d" "3e6ad21cf68acae4fe79d64b79d29529328766b36858d5b2679223fe71834e4e" "ca7b1e57c857e765435de39bcac6b6d1ac25fba00cb20c798453c211dde00da1" "d565ce46662488e7fd72c9e66a9b6b98a684adcb1fc9f335b6f5afd6c730066e" "05bc5f8241cca6529c2a9bb2c3c9211f142000bf3a8cb7fe48017bc79b91725e" "293abb6136fc9a95b9d0700e57101a857970d655c4e02334cf6127cdae89c266" "f24e2db97f29bfde5bb60ad05ec5c8604f8c4d314b4ddd6d1aba95c94002bc3b" "c90ddffc1338a1f6ffb59a56443612042bb87925b931fc9adf3571f2c2e8bee5" "0b79fa55c3c5b59bc7720c9afe891dfe5a7156dcee54fc280dd47b7f93d4dae3" "711316767c7153c8126258861663953a50128538bc44d24d0bd0edf221cf4e75" "2ffe1f78aa086d79dc51d45e6f201e757ec568d9cb686a57ccdb990182b56956" "b25bf46e7ef5d9e4e0704b572c744dd53a4185042276d30957ce1ecb225d15f8" "a03ef9d2e53fcec16e8845b0438b3557b698a13f32b0501eaf3c471a8b66fbec" "ab102ce8a68c5629eddd17601d803b233352831a5ebe3c11321d4f54d323ba41" "d886ebb0ee0ba5e54a8cf48c576edc1f6eb3d73951269f186c93c80c3713bb44" "01bee75e9b212b309e998081824ab6b5e5017f7cbf1d160c4ccda08169fe187e" "b9efba4edf6819bfbfe405851ef8769fa1f799d68c7a4675ba2b4fef4f1bb423" "143062d8d1bf4f0db4b935e903d1cc5ea272deee253384ec82016ba8f1a9f897" "4402457b600812717c4bc64d3a8c92b8cd1d0e22aa9b3ea8efdb79ffb5899f06" "10498e6dd0d7b6aef8c72f34937f1ffaa5aa799b72e084da5ae09d4852bf15a3" "0fb2f735fc1579daa0e2a76d39ed86e5dca675832d62b6aae6dd22b0982a43de" "ceeb4aab634be2f9a5be1aeadf2a2af9b37475e0b1406b2878bf8fb80bfc3ae4" "1ffeb745a25738b3950084c8b6315467d61d56e47b5fba8410197ef17a9acac3" "9aa1e0bc33a04a8a7d1e7377af380f4a8686e207dba3b6f1d7bbaf3269bc5b14" "5d6aa0a524f0724c7e3f2245e4057a9fc5f4f7fb5ff3bad163de6ca57351b33f" "46379cb9c0df4c920536d62d07ab864c416da7d7ad89baab416d3b4bc4bd155f" "0a10d05dc33515c2fb0d7a042831a3a216b9d3f598e9d25defa6e859109cb36c" "0f2f1feff73a80556c8c228396d76c1a0342eb4eefd00f881b91e26a14c5b62a" "cba5ebfabc6456e4bbd68e0394d176161e1db063c6ca24c23b9828af0bdd7411" "13880fa28757754bc40c85b05689c801ddaa877f2fe65abf1779f37776281ef1" "6ebdb33507c7db94b28d7787f802f38ac8d2b8cd08506797b3af6cdfd80632e0" "bd3b9675010d472170c5d540dded5c3d37d83b7c5414462737b60f44351fb3ed" "aca70b555c57572be1b4e4cec57bc0445dcb24920b12fb1fea5f6baa7f2cad02" "a6473f7abf949f4a6a1a9cc0dd37ea2e35ba3cea65d3442b98d65c5c5c5cb8d7" "30b14930bec4ada72f48417158155bc38dd35451e0f75b900febd355cda75c3e" "cecaee22ce0d262339811bcd3893b8948d11a5ead28d8c1e2a0fa3c377c87c6a" "fa036ae8fbc6fb0525a7c86b2624740f2cb37438556a3800b833a7bcf81a0538" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "57e3f215bef8784157991c4957965aa31bac935aca011b29d7d8e113a652b693" "3d4df186126c347e002c8366d32016948068d2e9198c496093a96775cc3b3eaa" "6df412e59dbfe7f72f24319b9ee4513e40bb0e44384fc93a2c77399e641348f6" "cbd85ab34afb47003fa7f814a462c24affb1de81ebf172b78cb4e65186ba59d2" "b7133876a11eb2ded01b4b144b45d9e7457f80dd5900c332241881ab261c50f4" "b89a4f5916c29a235d0600ad5a0849b1c50fab16c2c518e1d98f0412367e7f97" "d0fd069415ef23ccc21ccb0e54d93bdbb996a6cce48ffce7f810826bb243502c" "ffba0482d3548c9494e84c1324d527f73ea4e43fff8dfd0e48faa8fc6d5c2bc7" "8f5b54bf6a36fe1c138219960dd324aad8ab1f62f543bed73ef5ad60956e36ae" "03e26cd42c3225e6376d7808c946f7bed6382d795618a82c8f3838cd2097a9cc" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "46b2d7d5ab1ee639f81bde99fcd69eb6b53c09f7e54051a591288650c29135b0" "b5e75f219d41e6e3516560ac493d808b621a99847d6128ce8e6c74b1495ce875" "d3c80a59b17a34fd62336e753743e14ffcd3de07cd78b8b61a6df4c0026bcb2b" "13bb60578fddd069b3fa75e6c53293a836bdf68ee970dc35084137df22c65831" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "432c44ce7e3b2418e413425d5a7053fa0ed2d77ab5cc1261481e86234eba76a5" "62c5f3d9045997edf73e2a9ef027ff4029effde71972d6c3efd683100a66b215" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "8f567db503a0d27202804f2ee51b4cd409eab5c4374f57640317b8fcbbd3e466" "5d59bd44c5a875566348fa44ee01c98c1d72369dc531c1c5458b0864841f887c" "8b58ef2d23b6d164988a607ee153fd2fa35ee33efc394281b1028c2797ddeebb" "669b0c23ee436f297bb286f46daeea9b8ec322cb50758e7ad704d68b36271da3" "f8aa0da2755c476ab683c124df22a7c8aced57caed23d887849e7cade149580e" "f7b2b47cce08a9a6034d04048e9b0cef443e4ea7d3254194b7159b04fae8add7" "98a9469270cbfe77f1cedfdfe46139dbe1401e5af6f87767362aeaf38c6b1211" "fe36e4da2ca97d9d706e569024caa996f8368044a8253dc645782e01cd68d884" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" "73fa7f35aa862e29b07de70966a29636a3fcd98215072ef3988c82fa02ee6845" default))
 '(display-time-mode t)
 '(fci-rule-color "#32302f")
 '(frame-brackground-mode 'dark)
 '(fringe-mode 10 nil (fringe))
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
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   '("#fb4933" "#d65d0e" "#d79921" "#747400" "#b9b340" "#14676b" "#689d6a" "#d3869b" "#b16286"))
 '(package-selected-packages
   '(imenu-anywhere go-eldoc lush-theme tramp-theme nano-theme moe-theme lab-themes basic-theme gotham-theme clues-theme ample-theme afternoon-theme abyss-theme jazz-theme subatomic-theme cyberpunk-theme doom-themes almost-mono-themes gruber-darker-theme go-dlv bury-successful-compilation go-autocomplete auto-complete go-rename projectile crux selectrum dumb-jump go-complete move-text go-mode sublime-themes waher-theme good-scroll zenburn-theme yasnippet which-key use-package solarized-theme rustic rust-mode rtags ripgrep naysayer-theme monokai-theme monokai-alt-theme molokai-theme magit lsp-ui lsp-dart key-chord ivy irony iedit hover helm-xref helm-lsp helm-gtags god-mode glsl-mode ggtags evil-visual-mark-mode esup elcord csharp-mode company-c-headers chess ccls c-eldoc bongo arjen-grey-theme))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(pos-tip-background-color "#32302f")
 '(pos-tip-foreground-color "#bdae93")
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
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
 '(warning-suppress-log-types '((comp)))
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
 '(default ((t (:background nil :family "Consolas" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
