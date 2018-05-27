;; 输入name内容: 用户使用的时候，提示yasnippet名称
;; 输入key内容: 用户使用时，输入匹配的key内容，然后TAB键，就可以得到对应的yasnippet代码模版
;; 在 # --的下一行输入内容，语法参考http://ergoemacs.org/emacs/yasnippet_templates_howto.html
;;(require 'yasnippet)
;;(yas/global-mode 1)
;;(yas/minor-mode-on) ;; 以mini-mode打开，配合主mode
(global-set-key (kbd "M-y") 'yas-new-snippet)
