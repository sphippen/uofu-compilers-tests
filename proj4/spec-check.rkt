#lang racket

(provide f-spec f-spec*)

(define (is-fix? of what)
 (equal? what (of what)))

(define identifier? symbol?)
(define arg? identifier?) 

(define (operator? x)
 (set-member? (list 'Add 'Sub 'Mult 'Div 'Mod 'Pow 
                    'LShift 'RShift 
                    'BitOr 'BitXor 'BitAnd 
                    'FloorDiv) x))

(define (unary-op? x)
 (set-member? '(Invert Not UAdd USub) x))

(define (cmp-op? x)
 (set-member? '(Eq NotEq Lt LtE Gt GtE Is IsNot In NotIn) x))

(define (name-constant? n)
 (set-member? (list 'True 'False 'None) n))

(define f-spec/identifier?
 (match-lambda
  [#f #f]
  [(? identifier? i) i]
  [else '()]))

(define f-spec/arg?
 (match-lambda
  [#f #f]
  [(? arg? arg) arg]
  [else '()]))

(define (arg?? what)
 (if (null? what) #f (is-fix? f-spec/arg? what)))

(define f-spec/int?
 (match-lambda
  [#f #f]
  [(? integer? i) i]
  [else '()]))

(define f-spec/alias
 (match-lambda
  [`(,(? identifier? id) ,oid)
   `(,id ,(f-spec/identifier? oid))]
  [else '()]))

(define f-spec/args
 (match-lambda 
  [(and args 
        `(Arguments (args ,(? arg?) ...)
                    (arg-types ,(? false?) ...)
                    (vararg ,(? arg??)) 
                    (kwonlyargs ,(? arg?) ...)
                    (kwonlyarg-types ,(? false?) ...)
                    (kw_defaults ,(? false?) ...)
                    (kwarg ,(? arg??))
                    (defaults ,(? false?) ...))) args]
  [else '()]))

(define f-spec/aexpr
 (match-lambda
  [(and expr `(Num ,(? number?))) expr]
  [(and expr `(NameConstant ,(? name-constant?))) expr]
  [(and expr `(Ellipsis)) expr]
  [(and expr `(Name ,(? identifier?))) expr]
  [else '()]))

(define f-spec/aexpr?
 (match-lambda
  [#f #f]
  [e (f-spec/aexpr e)]))

(define (aexpr? what)
 (if (null? what) #f (is-fix? f-spec/aexpr what)))

(define f-spec/slice
 (match-lambda
  [`(Slice ,a ,b ,c)
   `(Slice ,(f-spec/aexpr? a) 
           ,(f-spec/aexpr? b)
           ,(f-spec/aexpr? c))]
  [`(ExtSlice . ,slices)
   `(ExtSlice . ,(map f-spec/slice slices))]
  [`(Index ,a)
   `(Index ,(f-spec/aexpr a))]
  [else '()]))

(define f-spec/except-handler
 (match-lambda
  [`(except ,a ,(? identifier? id) . ,body)
   `(except ,(f-spec/aexpr a) ,id . ,(map f-spec/stmt body))]
  [else '()]))

(define f-spec/keyword
 (match-lambda
  [`(,(? identifier? id) ,a)
   `(,id ,(f-spec/aexpr a))]
  [else '()]))

(define f-spec/cexpr
 (match-lambda
  [(? aexpr? what) what]
  [`(BinOp ,a ,(? operator? op) ,aa)
   `(BinOp ,(f-spec/aexpr a) ,op ,(f-spec/aexpr aa))]
  [`(UnaryOp ,(? unary-op? op) ,a)
   `(UnaryOp ,op ,(f-spec/aexpr a))]
  [`(Dict (keys . ,keys) (values . ,values))
   `(Dict (keys . ,(map f-spec/aexpr keys))
          (values . ,(map f-spec/aexpr values)))]
  [`(Set . ,set)
   `(Set . ,(map f-spec/aexpr set))]
  [`(Yield ,a)
   `(Yield ,(f-spec/aexpr a))]
  [`(Compare (left ,left)
             (ops ,(? cmp-op? op))
             (comparators ,cmp))
   `(Compare (left ,(f-spec/aexpr left))
             (ops ,op)
             (comparators ,(f-spec/aexpr cmp)))]
  [`(Call (func ,func)
          (args . ,args)
          (keywords . ,keywords)
          (starargs ,star)
          (kwargs ,kwarg))
   `(Call (func ,(f-spec/aexpr func))
          (args . ,(map f-spec/aexpr args))
          (keywords . ,(map f-spec/keyword keywords))
          (starargs ,(f-spec/aexpr? star))
          (kwargs ,(f-spec/aexpr? kwarg)))]
  [(and expr `(Str ,(? string?))) expr]
  [(and expr `(Bytes ,(? bytes?))) expr]
  ; the following expressions can appear in assignment context:
  [`(Attribute ,a ,(? identifier? id))
   `(Attribute ,(f-spec/aexpr a) ,id)]
  [`(Subscript ,a ,slice)
   `(Subscript ,(f-spec/aexpr a) ,(f-spec/slice slice))]
  [`(List . ,as)
   `(List . ,(map f-spec/aexpr as))]
  [`(Tuple . ,as)
   `(Tuple . ,(map f-spec/aexpr as))]
  [else '()]))

(define f-spec/stmt
 (match-lambda
  [`(FunctionDef
     (name ,(? identifier? name))
     ; NOTE: <arguments> is simplified below.
     (args ,args) 
     (body . ,body)
     (decorator_list)
     (returns #f))
   `(FunctionDef
     (name ,name)
     (args ,(f-spec/args args))
     (body . ,(map f-spec/stmt body))
     (decorator_list)
     (returns #f))]
   [`(Return ,aexpr)
    `(Return ,(f-spec/aexpr aexpr))]
   [`(Delete ,cexpr) 
    `(Delete ,(f-spec/cexpr cexpr))]
   [`(Assign (targets ,t) (value ,v))
    `(Assign (targets ,(f-spec/cexpr t)) (value ,(f-spec/cexpr v)))]
   [`(AugAssign ,a ,(? operator? op) ,c)
    `(AugAssign ,(f-spec/aexpr a) ,op ,(f-spec/cexpr c))]
   [`(While (test ,a) (body . ,body) (orelse . ,orelse))
    `(While (test ,(f-spec/aexpr a))
            (body . ,(map f-spec/stmt body))
            (orelse . ,(map f-spec/stmt orelse)))]
   [`(If (test ,a) (body . ,body) (orelse . ,orelse))
    `(If (test ,(f-spec/aexpr a))
         (body . ,(map f-spec/stmt body))
         (orelse . ,(map f-spec/stmt orelse)))]
   [`(Raise ,a) `(Raise ,(f-spec/aexpr a))]
   [`(Raise ,a ,aa) `(Raise ,(f-spec/aexpr a)
                            ,(f-spec/aexpr aa))]
   [`(Try (body . ,body)
          (handlers ,handler)
          (orelse . ,orelse)
          (finalbody . ,finalbody))
    `(Try (body . ,(map f-spec/stmt body))
          (handlers ,(f-spec/except-handler handler))
          (orelse . ,(map f-spec/stmt orelse))
          (finalbody . ,(map f-spec/stmt finalbody)))]
   [`(Import . ,aliases)
    `(Import . ,(map f-spec/alias aliases))]
   [`(ImportFrom (module ,id)
                 (names . ,aliases)
                 (level , level))
    `(ImportFrom (module ,(f-spec/identifier? id))
                 (names . ,(map f-spec/alias aliases))
                 (level ,(f-spec/int? id)))]
   [(and stmt `(Global ,(? identifier?) ..1)) stmt]
   [(and stmt `(NonLocal ,(? identifier?) ..1)) stmt]
   [(and stmt '(Pass)) stmt]
   [(and stmt '(Break)) stmt]
   [(and stmt '(Continue)) stmt]
   [(and stmt `(Local ,(? identifier?) ...)) stmt]
   [(and stmt `(Comment ,(? string?))) stmt]
   [else '()]))

(define f-spec
 (match-lambda
  [`(Module . ,stmts)
   `(Module . ,(map f-spec/stmt stmts))]
  [else '()]))

(define (f-spec* what)
 (if (null? what) 
     '(#f ())
     (let ([after (f-spec what)])
      (list (equal? what after) after))))
