;;; spaceline-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "spaceline" "spaceline.el" (0 0 0 0))
;;; Generated autoloads from spaceline.el

(register-definition-prefixes "spaceline" '("spaceline-"))

;;;***

;;;### (autoloads nil "spaceline-config" "spaceline-config.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from spaceline-config.el

(autoload 'spaceline-spacemacs-theme "spaceline-config" "\
Install the modeline used by Spacemacs.

ADDITIONAL-SEGMENTS are inserted on the right, between `global' and
`buffer-position'.

\(fn &rest ADDITIONAL-SEGMENTS)" nil nil)

(autoload 'spaceline-emacs-theme "spaceline-config" "\
Install a modeline close to the one used by Spacemacs, but which
looks better without third-party dependencies.

ADDITIONAL-SEGMENTS are inserted on the right, between `global' and
`buffer-position'.

\(fn &rest ADDITIONAL-SEGMENTS)" nil nil)

(defvar spaceline-helm-mode nil "\
Non-nil if Spaceline-Helm mode is enabled.
See the `spaceline-helm-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `spaceline-helm-mode'.")

(custom-autoload 'spaceline-helm-mode "spaceline-config" nil)

(autoload 'spaceline-helm-mode "spaceline-config" "\
Customize the mode-line in helm.

This is a minor mode.  If called interactively, toggle the
`Spaceline-Helm mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value 'spaceline-helm-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(defvar spaceline-info-mode nil "\
Non-nil if Spaceline-Info mode is enabled.
See the `spaceline-info-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `spaceline-info-mode'.")

(custom-autoload 'spaceline-info-mode "spaceline-config" nil)

(autoload 'spaceline-info-mode "spaceline-config" "\
Customize the mode-line in info.
This minor mode requires info+.

This is a minor mode.  If called interactively, toggle the
`Spaceline-Info mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value 'spaceline-info-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "spaceline-config" '("spaceline--"))

;;;***

;;;### (autoloads nil "spaceline-segments" "spaceline-segments.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from spaceline-segments.el

(register-definition-prefixes "spaceline-segments" '("spaceline-"))

;;;***

;;;### (autoloads nil nil ("spaceline-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; spaceline-autoloads.el ends here
