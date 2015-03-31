#lang racket
(provide in-spec?/edit)

(define (in-spec?-module/edit mod)
 (match mod
  [`(Module . ,stmts) 
   (match-let ([(list in? nstmts) (in-spec?-stmts/edit stmts)])
    `(,in? (Module ,@nstmts)))]
  [else '(#f ())]))

(define (in-spec?-stmts/edit stmts)
 (foldr 
  (lambda (v acc)
   (match-let ([(list in? stmt) (in-spec?-stmt/edit v)]
               [(list cin? done) acc])
    (list (and in? cin?) (if (not (null? stmt)) (cons stmt done) done))))
  '(#t ())
  stmts))

(define (in-spec?-expr/edit expr)
 (match expr
  [`(Starred ,expr) '(#f ())]
  ; Assume that sxpy catches everything else
  [else (list #t else)]))

(define (in-spec?-args/edit args)
 (match args
  [(and `(Arguments
          ,(list 'args (? symbol?) ...)
          ,(list 'arg-types (? false?) ...)
          (vararg ,(or (? symbol?) #f))
          ,(list 'kwonlyargs (? symbol?) ...)
          ,(list 'kwonlyarg-types (? false?) ...)
          ,(list 'kw_defaults (? false?) ...)
          (kwarg ,(or (? symbol?) #f))
          ,(list 'defaults (? false?) ...)) args)
   (list #t args)]
  [else '(#f ())]))

(define (in-spec?-stmt/edit stmt)
 (match stmt
  [`(FunctionDef
     (name ,(? symbol? name))
     (args ,args)
     (body . ,body)
     (decorator_list . ,_)
     (returns #f))
   (match-let ([(list in-args? nargs) (in-spec?-args/edit args)]
               [(list in-body? nbody) (in-spec?-stmts/edit body)])
    (list (and in-args? in-body?)
          `(FunctionDef
            (name ,name)
            (args ,nargs)
            (body . ,nbody)
            (decorator_list)
            (returns #f))))]
   [`(ClassDef . ,rest) '(#f ())]
   [`(Return . ,expr) 
    (if (not (= (length expr) 0))
        (match-let ([(list in? nexp) (in-spec?-expr/edit (car expr))])
         `(,in? (Return ,nexp)))
        '(#f ()))]
   [`(Assign (targets . ,texpr) (value ,vexpr))
    (if (not (= (length texpr) 1))
        '(#f ())
        (match-let ([(list in-targets? nt) (in-spec?-expr/edit (car texpr))]
                    [(list in-value? nv) (in-spec?-expr/edit vexpr)])
         (list (and in-targets? in-value)
               `(Assign (targets ,nt) (value ,nv)))))]
   ; Assume that sxpy will catch anything else
   [else (list #t else)]))

(define (in-spec?/edit tree) 
 (match-let ([(list in? module) (in-spec?-module/edit (car tree))])
  (list in? (list module))))
