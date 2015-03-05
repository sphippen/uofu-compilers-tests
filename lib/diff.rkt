#lang racket
(require "proc.rkt")
(require "term-colors.rkt")

(provide diff diff/bytes)

(define *diff-args* `( "--unchanged-group-format=%="
                       "--changed-group-format=%<%>"
                       ,(format "--old-line-format=~a %l\n" 
                                (color "+" 'green))
                       ,(format "--unchanged-line-format=~a %l\n" 
                                (color "=" 'white))
                       ,(format "--new-line-format=~a %l\n" 
                                (color "-" 'red)) ))

(define *temp-format* "test-cases.tmp~a")

(define (fill-file-with-port f p)
 (let ([output (open-output-file f #:exists 'truncate)])
  (copy-port p output)
  (close-output-port output)))

(define (diff old/port new/port)
 (let ([diff-path      (find-executable-path "diff")]
       [old-temp-path  (make-temporary-file *temp-format*)]
       [new-temp-path  (make-temporary-file *temp-format*)])
  (fill-file-with-port old-temp-path old/port)
  (fill-file-with-port new-temp-path new/port)
  (let* ([args `(,diff-path ,@*diff-args* ,old-temp-path ,new-temp-path)]
         [proc  (apply run args)])
   (begin0
    (if (= (hash-ref proc 'status) 2) ; diff exits with 2 on error
        (error 'diff-exit-nonzero)
        (hash-ref proc 'stdout))
    (delete-file old-temp-path)
    (delete-file new-temp-path)))))

(define (diff/bytes old/bytes new/bytes)
 (diff (open-input-bytes old/bytes)
       (open-input-bytes new/bytes)))
