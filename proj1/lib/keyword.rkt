#lang racket

(require "random-extra.rkt")

(provide *keywords* *keywords/weighted* random-keyword)

(define *keywords* '(
 'False 'None 'True 'and 'as 'assert 'break
 'class 'continue 'def 'del 'elif 'else 'except
 'finally 'for 'from 'global 'if 'import 'in
 'is 'lambda 'nonlocal 'not 'or 'pass 'raise
 'return 'try 'while 'with 'yield))

(define *keywords/weighted* (uniformly-weighted *keywords*))

(define (random/keyword)
 (weighted-choice *keywords/weighted*))
