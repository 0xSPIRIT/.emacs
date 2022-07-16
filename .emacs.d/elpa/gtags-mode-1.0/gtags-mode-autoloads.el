;;; gtags-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "gtags-mode" "gtags-mode.el" (0 0 0 0))
;;; Generated autoloads from gtags-mode.el

(autoload 'gtags-mode-create "gtags-mode" "\
Create a GLOBAL GTAGS file in ROOT-DIR asynchronously.

\(fn ROOT-DIR)" t nil)

(defvar gtags-mode nil "\
Non-nil if Gtags mode is enabled.
See the `gtags-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `gtags-mode'.")

(custom-autoload 'gtags-mode "gtags-mode" nil)

(autoload 'gtags-mode "gtags-mode" "\
Use GNU Global as backend for project, xref, capf and imenu.
When the buffer is not in a global-project, then all these tools
rely on their original or user configured default behavior.

This is a minor mode.  If called interactively, toggle the `Gtags
mode' mode.  If the prefix argument is positive, enable the mode,
and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='gtags-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "gtags-mode" '("gtags-mode-"))

;;;***

;;;### (autoloads nil nil ("gtags-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8-emacs-unix
;; End:
;;; gtags-mode-autoloads.el ends here
