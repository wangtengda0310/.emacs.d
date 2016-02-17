(defun save-url-to-file (url file)
  (url-retrieve url
		`(lambda (cbargs)	;不使用宏会报错变量没定义 http://emacs.stackexchange.com/questions/4265/symbols-value-as-variable-is-void-in-callback-from-url-retrieve
		   (re-search-forward "\r?\n\r?\n") ;下载的内容包涵http header http://stackoverflow.com/questions/15582015/how-to-use-url-retrieve-to-download-a-tar-gz-file-in-emacs
		   (write-region (point) (point-max) ,file))))

(defvar lisp-storage "~/.emacs.d/lisp/")
(if (not (file-exists-p lisp-storage))
    (make-directory lisp-storage))

(if (not (file-exists-p (concat lisp-storage "paredit-beta.el")))
    (save-url-to-file
     "http://mumble.net/~campbell/emacs/paredit-beta.el"
     (concat lisp-storage "paredit-beta.el")))

(add-to-list 'load-path "~/.emacs.d/lisp")

;https://www.emacswiki.org/emacs/ParEdit
(autoload 'enable-paredit-mode "paredit-beta.el"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
