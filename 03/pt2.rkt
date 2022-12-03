#lang racket

(define (balls)
  (let ([line (read-line)])
    (if (eq? line eof)
      empty
      (cons line (balls)))))

(define (intersect a b)
  (remove-duplicates (filter (lambda (x) (member x b)) a)))

(define (priority x)
  (if (char<=? #\A x #\Z)
    (- (char->integer x) 38)
    (- (char->integer x) 96)))

(define (group-trios a)
  (if (> (length a) 3)
    (cons (take a 3) (group-trios (drop a 3)))
    (cons a empty)))

(apply + (map (lambda (trio)
       (priority (first (intersect (intersect (string->list (first trio)) (string->list (second trio))) (string->list (third trio))))))
     (group-trios (balls))))

