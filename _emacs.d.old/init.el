
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;;
;; Load settings from config files in .emacs.d/site-lisp
(mapc
 'require
 '(basic-settings
   plugin-settings
   org-settings
   keybindings
   system
   misc-hacks))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8ffaf449297bd9a08517f4b03a4df9dbf3e347652746cefceb3ee57c8e584b9f" "39e93a10eb292941640adfe28509e0c3eeb84e30cbfed6ef9841be136081ca34" "50e7f9d112e821e42bd2b8410d50de966c35c7434dec12ddea99cb05dd368dd8" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "455d6059dfbcd1990350ed5fded17b028d7208e81c644cdb9c84d4b12d99f0fa" "a3d519ee30c0aa4b45a277ae41c4fa1ae80e52f04098a2654979b1ab859ab0bf" "76b226dd750d085eaaf7efa5eb07a3282223d74f327a0f4319512c0a59f6df39" "332955730fca9174f96461664ac7524314f181eefc390ef2fc7bc6cfac9a8573" "7694bfb46ec19cfc47093783633d8cd4df208d620104910bf5c1c840528a8dd1" "4a60f0178f5cfd5eafe73e0fc2699a03da90ddb79ac6dbc73042a591ae216f03" 4de75ba320d26ccecd719d50239f2c36bec18628 "e80a0a5e1b304eb92c58d0398464cd30ccbc3622425b6ff01eea80e44ea5130e" "0e121ff9bef6937edad8dfcff7d88ac9219b5b4f1570fd1702e546a80dba0832" "c27b3d858a9c033b93f9447337659d3ba34a72251b794e8bfe792ed722cc1f67" "bad832ac33fcbce342b4d69431e7393701f0823a3820f6030ccc361edd2a4be4" default)))
 '(package-selected-packages
   (quote
    (company-irony irony company async goto-chg helm-core popup undo-tree w3m fzf paredit org-plus-contrib helm evil-surround evil elfeed auctex)))
 '(w3m-filter-configuration
   (quote
    ((t
      ("Strip Google's click-tracking code from link urls" "Google の click-tracking コードをリンクの url から取り除きます")
      "\\`https?://[a-z]+\\.google\\." w3m-filter-google-click-tracking)
     (t
      ("Align table columns vertically to shrink the table width in Google" "Google 検索結果のテーブルを縦方向で揃えて幅を狭めます")
      "\\`http://\\(www\\|images\\|news\\|maps\\|groups\\)\\.google\\." w3m-filter-google-shrink-table-width)
     (t
      ("Add name anchors that w3m can handle in all pages" "すべてのページに w3m が扱える name アンカーを追加します")
      "" w3m-filter-add-name-anchors)
     (t
      ("Substitute disabled attr with readonly attr in forms" "フォーム中の disabled 属性を readonly 属性で代用します")
      "" w3m-filter-subst-disabled-with-readonly)
     (nil
      ("Render <tfoot>...</tfoot> after <tbody>...</tbody>" "テーブル内の <tfoot> を <tbody> の後に描画します")
      "" w3m-filter-fix-tfoot-rendering)
     (nil
      ("Remove garbage in http://www.geocities.co.jp/*" "http://www.geocities.co.jp/* でゴミを取り除きます")
      "\\`http://www\\.geocities\\.co\\.jp/"
      (w3m-filter-delete-regions "<DIV ALIGN=CENTER>
<!--*/GeoGuide/*-->" "<!--*/GeoGuide/*-->
</DIV>"))
     (nil
      ("Remove ADV in http://*.hp.infoseek.co.jp/*" "http://*.hp.infoseek.co.jp/* で広告を取り除きます")
      "\\`http://[a-z]+\\.hp\\.infoseek\\.co\\.jp/"
      (w3m-filter-delete-regions "<!-- start AD -->" "<!-- end AD -->"))
     (nil
      ("Remove ADV in http://linux.ascii24.com/linux/*" "http://linux.ascii24.com/linux/* で広告を取り除きます")
      "\\`http://linux\\.ascii24\\.com/linux/"
      (w3m-filter-delete-regions "<!-- DAC CHANNEL AD START -->" "<!-- DAC CHANNEL AD END -->"))
     (nil "A filter for Google" "\\`http://\\(www\\|images\\|news\\|maps\\|groups\\)\\.google\\." w3m-filter-google)
     (nil "A filter for Amazon" "\\`https?://\\(?:www\\.\\)?amazon\\.\\(?:com\\|co\\.\\(?:jp\\|uk\\)\\|fr\\|de\\)/" w3m-filter-amazon)
     (nil
      ("A filter for Mixi.jp" "ミクシィ用フィルタ")
      "\\`https?://mixi\\.jp" w3m-filter-mixi)
     (nil "A filter for http://eow.alc.co.jp/*/UTF-8*" "\\`http://eow\\.alc\\.co\\.jp/[^/]+/UTF-8" w3m-filter-alc)
     (nil
      ("A filter for Asahi Shimbun" "朝日新聞用フィルタ")
      "\\`http://www\\.asahi\\.com/" w3m-filter-asahi-shimbun)
     (nil "A filter for http://imepita.jp/NUM/NUM*" "\\`http://imepita\\.jp/[0-9]+/[0-9]+" w3m-filter-imepita)
     (nil "A filter for http://allatanys.jp/*" "\\`http://allatanys\\.jp/" w3m-filter-allatanys)
     (t "A filter for Wikipedia" "\\`http://.*\\.wikipedia\\.org/" w3m-filter-wikipedia)
     (nil
      ("Remove inline frames in all pages" "すべてのページでインラインフレームを取り除きます")
      "" w3m-filter-iframe)))))

;; Start with agenda mode
(org-agenda-list)
(delete-other-windows)
(message "Loaded .emacs")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
