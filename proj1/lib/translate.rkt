#lang racket

(provide
 token-list->string
 port->token-list
 *default-context*
 default-gen/lit/string
 default-gen/lit/number
 default-gen/indent-to
 default-gen/space)

(define *indent-whitespace* "    ")
(define *triple-quote* (make-string 3 #\"))

(struct context 
 (indent last 
  gen/lit/string gen/lit/number
  gen/indent-to gen/space))

(define (default-gen/lit/string l)
 (string-append *tripple-quote* l *tripple-quote*))

(define default-gen/lit/number number->string)

(define (default-gen/indent-to to)
 (string-append* (make-list to *indent-whitespace*)))

(define (default-gen/space kw) " ")

(define (token->context t ctx)
 (let ([with-last   (lambda (l) (struct-copy context ctx [last x]))]
       [with-indent (lambda (i) (struct-copy context ctx [indent i]))])
  (match t
   ['(INDENT)     (with-indent (+ (context-indent ctx) 1))]
   ['(DEDENT)     (with-indent (- (context-indent ctx) 1))]
   ['(NEWLINE)    (with-last 'NEWLINE)]
   [`(KEYWORD ,_) (with-last 'KEYWORD)]
   [`(ID ,_)      (with-last 'ID)]
   [`(LIT ,_)     (with-last 'LIT)]
   [_             (with-last (void))])))

(define (py-printable? p)
 (match p
  [`(KEYWORD ,_) #t]
  [`(ID ,_)      #t]
  [`(PUNCT ,_)   #t]
  [`(LIT ,_)     #t]
  [`(NEWLINE)    #t]
  [_ #f]))

(define (token->whitespace t ctx)
 (let ((gen/space (context-gen/space ctx)))
  (cond
   [(eq? (context-last ctx) 'NEWLINE)        ((context-gen/indent-to ctx) 
                                              (context-indent ctx))]
   [(eq? (car t) 'PUNCT)                     (gen/space 'PUNCT)]
   [(eq? (context-last ctx) 'KEYWORD)        (gen/space 'KEYWORD)]
   [(eq? (context-last ctx) 'ID)             (gen/space 'ID)]
   [(and (eq? (car t) 'LIT)
         (eq? (context-last ctx) 'LIT))      (gen/space 'LIT)]
   [else ""]))

(define (py-keyword->string k) (symbol->string k))

(define (py-literal->string l ctx)
 (cond [(string? l) ((context-gen/lit/string ctx) l)]
       [(number? l) ((context-gen/lit/number ctx) l)]))

(define (token->string t ctx)
 (match t
  [`(KEYWORD ,k)            (py-keyword->string k)]
  [`(ID ,id)                id]
  [`(PUNCT ,p)              p ]
  ['(NEWLINE)               "\n"]
  [`(LIT ,l)                (py-literal->string l ctx)]
  [_ ""]))

(define (token->source t ctx)
 (string-append
  (if (py-printable? t)
      (token->whitespace t ctx)
      "")
  (token->string t ctx)))

(define (port->token-list p) (port->list read p))

(define *default-context*
 (context 0 (void)
  default-gen/lit/string
  default-gen/lit/number
  default-gen/indent-to
  default-gen/space))

(define (context/from-functions
         gen/indent-to gen/space 
         gen/lit/number gen/lit/string)
 (struct-copy context *defaut-context*
  [gen/indent-to    gen/indent-to]
  [gen/space        gen/space]
  [gen/lit/number   gen/lit/number]
  [gen/lit/string   gen/lit/string]))

(define (token-list->string tl [ctx *default-context*] [str ""])
 (if (null? tl)
     str
     (token-list->string 
      (cdr tl)
      (token->context (car tl) ctx)
      (string-append str (token->source t ctx)))))
