;;; integration-test.el --- Integration Tests for company-suggest  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Jürgen Hötzel

;; Author: Jürgen Hötzel <juergen@hoetzel.info>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'buttercup)
(require 'company-suggest)

(describe "Google backend"
  (it "Completes single words"
    (let* ((company-backend 'company-suggest-google)
	   ;; non deterministic, so we just compare the first word
	   (results (mapcar (lambda (w) (car (split-string (downcase w))))
			    (company-call-backend 'candidates "operati"))))
      (expect results :to-contain "operation")))
  (it "Completes sentences"
    (let* ((company-suggest-complete-sentence t)
	   (company-backend 'company-suggest-google)
	   (results (mapcar #'downcase (company-call-backend 'candidates "Emacs is"))))
      (expect results :to-contain "emacs is a great operating system"))))

(describe "Wiktionary backend"
  (it "Completes single words"
    (let* ((company-backend 'company-suggest-wiktionary)
	   (results (mapcar #'downcase (company-call-backend 'candidates "Hal"))))
      (expect results :to-contain "hallo"))))

(provide 'integration-test)
;;; integration-test.el ends here
