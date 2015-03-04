#lang racket

(require "random-extra.rkt")
(require "common.rkt")

(provide *unicode-ranges/weighted*
 random-character 
 char->raw 
 char->escaped/hex
 char->escaped/octal 
 char->escaped/basic)

(define (range-length r)
 (- (apply max r) (apply min r)))

(define weighted-ranges (lambda rs
 (let ([size
        (foldl + 0 (map range-length rs))])
  (map (lambda (r) 
        (list (/ (range-length r) size) r))
       rs))))

(define (padl-to len with str)
 (let ([remaining (- len (string-length str))])
  (if remaining
      (string-append (make-string remaining with) str)
      str)))

(define (char-one-byte? char)
 (<= (char->integer char) 256))

(define *unicode-ranges/weighted*
 (weighted-ranges
  '(#x0     #xD7FF)
  '(#xE000  #x10FFFF)))

(define (random-character ranges)
 (integer->char
  (apply random-integer (weighted-choice ranges))))

(define (char->raw char) char)

(define (char-escapeable/always? char)
 (in? char '(#\\

#\

(define (char-escapeable? char)
 (in? char '(#\uA #\\ #\' #\" #\u7 #\u8 #\uC #\uD #\u9 #\uB)))

(define (char->escaped/basic char chance?)
 (match char
  ; Note: this match handles both newline escaping scenarios
  [#\uA (if (chance? 'escaped-actual-newline) "\\\n" "\\n")]
  [#\\  "\\\\"]  [#\'  "\\'" ]
  [#\"  "\\\""]  [#\u7  "\\a"]
  [#\u8  "\\b"]  [#\uC  "\\f"]
  [#\uD  "\\r"]  [#\u9  "\\t"]
  [#\uB  "\\v"]))

(define (char->escaped/hex char)
 (unless (char-one-byte? char) (unreachable))
 (string-append "\\x" 
  (padl-to 2 #\0 (format "~X" (char->integer char)))))

(define (char->escaped/octal char)
 (unless (char-one-byte? char) (unreachable))
 (string-append "\\"
  (padl-to 3 #\0 (format "~O" (char->integer char)))))

(define (random-string/newline-escapes))

(define (random-string/single length)

(define (random/literal/string length chance?) 
 (cond
  [(chance? 'quote-single) (random-string/single length]
  [(chance? 'quote-double) ...]
  [(chance? 'quote-triple) ...]))

(define (random/literal/number) (unreachable))
(define (random/punctuation) (unreachable))
(define (random/identifer) (unreachable))

(define (random-line) (unreachable))

