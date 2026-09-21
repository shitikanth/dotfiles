;;; w3m-livemint.el --- Distraction-free livemint.com  -*- lexical-binding: t; -*-

;;; Commentary:

;; Livemint wraps every page in a ~110-line navigation menu and a ~150-line
;; footer of share-price links, so the article itself is under a third of what
;; w3m renders.  Both article and author pages hang their real content off a
;; `mainSec' element, which is what this filter keeps.
;;
;; The site is a Next.js build, so most class names carry a per-deploy hash
;; (`giftArticle_giftCTAPair__jG24R').  Every pattern below anchors on an id or
;; on the unhashed half of a class name instead.

;;; Code:

(require 'w3m-filter)

(defun w3m-filter-livemint (url)
  "Strip navigation, promos and footer cruft from livemint.com pages."
  (w3m-filter-delete-regions
   url "<body[^>]*>" "<\\(?:article\\|section\\)[^>]*\\bmainSec\\b"
   t t t nil nil 1)
  (w3m-filter-delete-regions
   url "<div class=\"rightPanel\">" "</body>" nil t nil nil nil 1)
  ;; Author pages have no rightPanel; their rail is a run of .rightBlock divs.
  (w3m-filter-delete-regions
   url "<div[^>]*\\bclass=\"[^\"]*\\brightBlock\\b" "<footer id=\"footer\""
   nil t t nil nil 1)
  (w3m-filter-delete-regions
   url "<footer id=\"footer\"" "</body>" nil t nil nil nil 1)
  ;; The gift/subscribe CTAs sit between the summary and the story body.
  (w3m-filter-delete-regions
   url "<div class=\"[^\"]*lm-gift-cta-pair[^\"]*\">" "<div class=\"mainArea\""
   nil t t nil nil 1)
  (w3m-filter-delete-regions
   url "<div class=\"[^\"]*lm-gift-cta-pair[^\"]*\">" "</button></div>"
   nil nil t nil nil 1)
  ;; SEO boilerplate ("Catch all the Business News...") plus the topic tags
  ;; and app download pitch that follow it.
  (w3m-filter-delete-regions
   url "<div class=\"seoTxtContainer" "</article>" nil t nil nil nil 1)
  ;; w3m 0.5.6 does not know <article>, and renders the leftover attributes as
  ;; text once the tag is the first thing in <body>.  Must run after the
  ;; deletion above, which uses </article> as its end marker.
  (w3m-filter-replace-regexp url "</?article[^>]*>" ""))

(add-to-list 'w3m-filter-configuration
             '(t "Strip navigation and promos from livemint.com"
                 "\\`https?://\\(?:www\\.\\)?livemint\\.com/"
                 w3m-filter-livemint))

(provide 'w3m-livemint)

;;; w3m-livemint.el ends here
