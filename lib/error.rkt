#lang racket
(provide exn:fail:timeout exn:fail:timeout? begin/timeout)

(struct exn:fail:timeout exn:fail (timeout)
    #:extra-constructor-name make-exn:fail:timeout
    #:transparent)

(define-syntax-rule (begin/timeout timeout body ...)
 (let* ([ch     (make-channel)])
  (thread 
   (thunk (channel-put ch
           (with-handlers ([(thunk* #t) (lambda (x) (list 'error x))])
            (list 'success (begin body ...))))))
  (match (sync/timeout timeout ch)
   [#f              (raise (make-exn:fail:timeout 
                            (format "Timeout after ~a s" timeout)
                            (current-continuation-marks)
                            timeout))]
   [`(error ,what)  (raise what)]
   [`(success ,r)   r])))

