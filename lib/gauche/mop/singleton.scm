;;;
;;; singleton.scm - implements singleton mixin
;;;
;;;  Copyright(C) 2000-2002 by Shiro Kawai (shiro@acm.org)
;;;
;;;  Permission to use, copy, modify, distribute this software and
;;;  accompanying documentation for any purpose is hereby granted,
;;;  provided that existing copyright notices are retained in all
;;;  copies and that this notice is included verbatim in all
;;;  distributions.
;;;  This software is provided as is, without express or implied
;;;  warranty.  In no circumstances the author(s) shall be liable
;;;  for any damages arising out of the use of this software.
;;;
;;;  $Id: singleton.scm,v 1.1 2002-10-15 04:09:13 shirok Exp $
;;;

;; EXPERIMENTAL

(define-module gauche.mop.singleton
  (export <singleton-meta> instance-of))
(select-module gauche.mop.singleton)

(define-class <singleton-meta> (<class>)
  (%the-singleton-instance)
  )

;; TODO: MT safeness
(define-method make ((class <singleton-meta>) . initargs)
  (if (slot-bound? class '%the-singleton-instance)
      (slot-ref class '%the-singleton-instance)
      (let ((ins (next-method)))
        (slot-set! class '%the-singleton-instance ins)
        ins)))

(define-method instance-of ((class <singleton-meta>) . initargs)
  (apply make class initargs))

(provide "gauche/mop/singleton")
