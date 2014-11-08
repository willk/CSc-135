; William Kinderman
; Dr. Gordon
; CSc 135 - Assignment 2

;----------------   A  -------------------
(define (fracktorial i)
  (if (= i 1) 1
      (if (= (modulo i 2) 0) (* i (fracktorial(- i 1)))
          (fracktorial(- i 1)))))
;----------------   B  -------------------
; reverse
(define (r L)
  (if (null? (cdr L)) L
      (append (r (cdr L)) (list (car L)))))

; size of the list
(define (sizeList L)
  (if (null? L) 0
      (+ 1 (sizeList (cdr L)))))

; take returns a list with first n items in it.
(define (take n L)
  (if (= n 0) empty
      (cons (car L) (take (- n 1) (cdr L)))))

; drop returns a list with the first n items of a list removed.
(define (drop n L)
  (if (= n 0) L
      (drop (- n 1) (cdr L))))


; splits a list and reverse
(define (splitAndReverse L)
(let ([n (sizeList L)])
  (if (= (modulo n 2) 0) (cons (r (take (/ n 2) L)) (list (r (drop (/ n 2) L))))
      (cons (r (take (floor (/ n 2)) L)) (cons (list (car (drop (floor (/ n 2)) L))) (list (r (drop (ceiling (/ n 2)) L))))))))

; flatten a list
(define (flatten L)
  (cond ((null? L) empty)
        ((not (pair? L)) (list L))
        (else (append (flatten (car L)) (flatten (cdr L))))))

;(reverseListHalves `(1 2 3 4 5))
(define (reverseListHalves L)
  (flatten (splitAndReverse L)))

;----------------   C  -------------------
(define (nth n L)
  (if (= n 1) (car L)
      (nth (- n 1) (cdr L))))

;(sumPicker '(2 4 7) '(8 3 2 9 1 1 6 6 7))
(define (sumPicker M N)
  (if (null? M) 0
      (+ (nth (car M) N) (sumPicker (cdr M) N))))

;----------------   D  -------------------
(define (countEvens L)
  (if (null? L) 0
      (if (list? (car L)) (+ (countEvens (car L)) (countEvens (cdr L)))
          (if (even? (car L)) (+ 1 (countEvens (cdr L)))
              (countEvens (cdr L))))))

;----------------   E  -------------------

(define (add n)
  (+ n 2))

(define (double n)
  (* n 2))

(define (pow n)
  (expt n 2))

(define (applyUntilTooBig fnct n)
  (if (> n 100) n
      (applyUntilTooBig fnct (fnct n))))
  

;----------------   F  -------------------