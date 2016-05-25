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

(if (not (file-exists-p (concat lisp-storage "bencode.el")))
    (save-url-to-file
     "https://www.emacswiki.org/emacs/download/bencode.el"
;;;     "https://raw.githubusercontent.com/emacsmirror/bencode/master/bencode.el"
     (concat lisp-storage "bencode.el")))
(require 'cl)

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

(defvar java8url "http://docs.oracle.com/javase/8/docs/")
(defvar javaurl java8url)

(defun opendotemacs () (interactive) (find-file "~/.emacs.d/随便记记.org"))
(global-set-key "\C-c\C-o" 'opendotemacs)

(ido-mode)

(show-paren-mode)

;; 设置阴历显示，在 calendar 上用 pC 显示阴历
(setq chinese-calendar-celestial-stem
  ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
      ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])
