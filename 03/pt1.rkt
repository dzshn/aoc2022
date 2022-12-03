#lang racket

(define (balls)
  (let ([line (read-line)])
    (if (eq? line eof)
      empty
      (cons line (balls)))))

(define (intersect a b)
  (first (filter (lambda (x) (member x b)) a)))

(define (priority x)
  (if (char<=? #\A x #\Z)
    (- (char->integer x) 38)
    (- (char->integer x) 96)))

(apply + (map (lambda (line)
       (let ([len (string-length line)])
         (priority (intersect 
                     (string->list (substring line 0 (/ len 2)))
                     (string->list (substring line (/ len 2)))))))
     (balls)))
