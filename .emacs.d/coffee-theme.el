(deftheme coffee
  "A simple theme on your eyes.")

(custom-theme-set-faces 'coffee
 '(default ((t (:foreground "#fdf4c1" :background "#282828" ))))
 '(cursor ((t (:background "#fdf4c1" ))))
 '(fringe ((t (:background "#282828" ))))
 '(region ((t (:background "#34586d" ))))
 '(secondary-selection ((t (:background "#3e3834" ))))
 '(font-lock-builtin-face ((t (:foreground "#84a341" ))))
 '(font-lock-comment-face ((t (:foreground "#7c6f64" :italics t))))
 '(font-lock-function-name-face ((t (:foreground "#a99865" ))))
 '(font-lock-keyword-face ((t (:foreground "#db963d" ))))
 '(font-lock-string-face ((t (:foreground "#6d7c5d" ))))
 '(font-lock-type-face ((t (:foreground "#af9849" ))))
 '(font-lock-constant-face ((t (:foreground "#bbaa97" ))))
 '(font-lock-variable-name-face ((t (:foreground "#abb780" ))))
 '(minibuffer-prompt ((t (:foreground "#cea03d" :bold t ))))
 '(font-lock-warning-face ((t (:foreground "red" :bold t ))))
 '(mode-line ((t (:foreground "#ece09f" :background "#383634"))))
 '(mode-line-inactive ((t (:inherit mode-line :background "282828" :foreground "gray40" :weight light))))
)

(provide-theme 'coffee)
