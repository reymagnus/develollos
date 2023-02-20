;; chars_paint.asm
;; paint a charset from memory
init    equ &4000       ;; initial memory address
cls     equ &bb14       ;; clear screen for graph
clsscr  equ &bb6c       ;; clear screen for text
;;
org init
run init
;; MAIN
call clsscr
call cls
ld hl, #c000		;; initial position of video
ld a,(ca);;ld a,#01
ld bc,chars		;; initial position of chars
call loop1		;; call main loop
                        ;; loop1->loop_paint->loop_chars->(chars)
jr $
;; END MAIN
loop1:
   ld (ca),a
   ld e,#08
   call loop_paint
   ld de, #c050
   add hl,de
   ld a,(ca)
   dec a
jr nz, loop1
ret
;;
loop_paint:
   ld d,#27
   call loop_chars	;; call to paint logo
;; primera linea  403c=10 a 4064=e0
;; segunda linea
   push bc		;; save bc in stack
			;; for using adding in bc
   ld bc,#07D8 		;; 800 for next row (minus) 4f last column
   add hl,bc
   pop bc 
   dec e
jr nz, loop_paint
ret
;;
;;
loop_chars:		;; finally 'paints' logo
                        ;; in memory video
   ld a, (bc)
   ld (hl), a
   inc hl;;inc l
   inc bc;;inc c
   dec d
jp p,loop_chars
ret
;;
chars:
;;  A,  A,  B,  B,  C,  C,  D,  D,  E,  E,  F,  F,  G,  G,  H,  H,  I,  I,  J,  J,  K,  K,  L,  L,  M,  M,  N,  N,  O,  O,  P,  P,  Q,  Q,  R,  R,  S,  S,  T,  T
;;  00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F, 20, 21, 22, 23, 24, 25, 26, 27  
db #10,#80,#f0,#c0,#30,#c0,#f0,#80,#f0,#e0,#f0,#e0,#30,#c0,#60,#60,#70,#e0,#10,#e0,#e0,#60,#f0,#00,#c0,#60,#c0,#60,#30,#80,#f0,#c0,#30,#80,#F0,#C0,#30,#c0,#70,#e0
db #30,#c0,#60,#60,#60,#60,#60,#c0,#60,#20,#60,#20,#60,#60,#60,#60,#10,#80,#00,#c0,#60,#60,#60,#00,#e0,#e0,#e0,#60,#60,#c0,#60,#60,#60,#c0,#60,#60,#60,#60,#50,#A0
db #60,#60,#60,#60,#c0,#00,#60,#60,#60,#80,#60,#80,#c0,#00,#60,#60,#10,#80,#00,#c0,#60,#c0,#60,#00,#f0,#e0,#f0,#60,#c0,#60,#60,#60,#c0,#60,#60,#60,#60,#00,#10,#80
db #60,#60,#70,#80,#c0,#00,#60,#60,#70,#80,#70,#80,#c0,#00,#70,#e0,#10,#80,#00,#c0,#70,#80,#60,#00,#f0,#e0,#D0,#e0,#c0,#60,#70,#80,#c0,#60,#70,#C0,#30,#c0,#10,#80
db #70,#e0,#60,#60,#c0,#00,#60,#60,#60,#80,#60,#80,#c0,#e0,#60,#60,#10,#80,#c0,#c0,#60,#c0,#60,#20,#D0,#60,#c0,#e0,#c0,#60,#60,#00,#D0,#A0,#60,#C0,#00,#60,#10,#80
db #60,#60,#60,#60,#60,#60,#60,#c0,#60,#20,#60,#00,#c0,#60,#60,#60,#10,#80,#c0,#c0,#60,#60,#60,#60,#c0,#60,#c0,#60,#60,#c0,#60,#00,#c0,#c0,#60,#60,#60,#60,#10,#80
db #60,#60,#f0,#c0,#30,#c0,#f0,#80,#f0,#e0,#F0,#00,#70,#e0,#60,#60,#70,#e0,#70,#80,#e0,#60,#f0,#e0,#c0,#60,#c0,#60,#30,#80,#f0,#00,#70,#60,#E0,#20,#30,#c0,#30,#C0
db #00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
;;
;;  U,  U,  V,  V,  W,  W,  X,  X,  Y,  Y,  Z,  Z,  a,  a,  b,  b,  c,  c,  d,  d,  e,  e,  f,  f,  g,  g,  h,  h,  i,  i,  j,  j,  k,  k,  l,  l,  m,  m,  n,  n
;;  00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F, 20, 21, 22, 23, 24, 25, 26, 27  
db #60,#60,#60,#60,#C0,#60,#C0,#60,#60,#60,#F0,#E0,#00,#00,#E0,#00,#00,#00,#10,#C0,#00,#00,#10,#C0,#00,#00,#E0,#00,#10,#80,#00,#20,#E0,#00,#30,#80,#00,#00,#00,#00
db #60,#60,#60,#60,#C0,#60,#60,#C0,#60,#60,#c0,#60,#00,#00,#E0,#00,#00,#00,#00,#C0,#00,#00,#30,#60,#00,#00,#60,#00,#00,#00,#00,#00,#60,#00,#10,#80,#00,#00,#00,#00
db #60,#60,#60,#60,#C0,#60,#30,#80,#60,#60,#80,#c0,#70,#80,#70,#C0,#30,#C0,#70,#C0,#30,#C0,#30,#00,#30,#E0,#60,#C0,#30,#80,#00,#E0,#60,#60,#10,#80,#60,#C0,#D0,#80
db #60,#60,#60,#60,#D0,#60,#30,#80,#30,#C0,#10,#80,#00,#C0,#60,#60,#60,#60,#C0,#C0,#60,#60,#70,#80,#60,#60,#70,#60,#10,#80,#00,#60,#60,#C0,#10,#80,#F0,#E0,#60,#60
db #60,#60,#60,#60,#F0,#E0,#60,#C0,#10,#80,#30,#20,#70,#C0,#60,#60,#60,#00,#C0,#C0,#70,#E0,#30,#00,#60,#60,#60,#60,#10,#80,#00,#60,#70,#80,#10,#80,#D0,#60,#60,#60
db #60,#60,#30,#C0,#E0,#E0,#C0,#60,#10,#80,#60,#60,#C0,#C0,#60,#60,#60,#60,#C0,#C0,#60,#00,#30,#00,#30,#E0,#60,#60,#10,#80,#60,#60,#60,#C0,#10,#80,#D0,#60,#60,#60
db #30,#C0,#10,#80,#C0,#60,#C0,#60,#30,#C0,#f0,#E0,#70,#60,#b0,#C0,#30,#C0,#70,#60,#30,#C0,#70,#80,#00,#60,#E0,#60,#30,#C0,#60,#60,#E0,#60,#30,#C0,#C0,#60,#60,#60
db #00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#70,#C0,#00,#00,#00,#00,#30,#C0,#00,#00,#00,#00,#00,#00,#00,#00
;;
;;  o,  o,  p,  p,  q,  q,  r,  r,  s,  s,  t,  t,  u,  u,  v,  v,  w,  w,  x,  x,  y,  y,  z,  z,  0,  0,  1,  1,  2,  2,  3,  3,  4,  4,  5,  5,  6,  6,  7,  7
;;  00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F, 20, 21, 22, 23, 24, 25, 26, 27  
db #00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#30,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#70,#C0,#10,#80,#30,#c0,#30,#c0,#10,#80,#70,#e0,#30,#C0,#70,#e0
db #00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#30,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#70,#E0,#C0,#60,#30,#80,#60,#60,#40,#60,#30,#80,#60,#20,#60,#60,#40,#60
db #30,#C0,#D0,#C0,#70,#60,#D0,#80,#30,#C0,#70,#C0,#60,#60,#60,#60,#C0,#60,#C0,#60,#60,#60,#40,#C0,#C0,#E0,#10,#80,#00,#60,#00,#60,#50,#80,#60,#00,#60,#00,#00,#60
db #60,#60,#60,#60,#C0,#C0,#60,#C0,#60,#00,#30,#00,#60,#60,#60,#60,#D0,#60,#60,#C0,#60,#60,#10,#80,#D0,#60,#10,#80,#30,#c0,#10,#C0,#90,#80,#30,#C0,#70,#c0,#00,#c0
db #60,#60,#60,#60,#C0,#C0,#60,#00,#30,#C0,#30,#00,#60,#60,#60,#60,#D0,#60,#30,#80,#60,#60,#30,#00,#E0,#60,#10,#80,#60,#00,#00,#60,#F0,#E0,#00,#60,#60,#60,#10,#80
db #60,#60,#70,#C0,#70,#C0,#60,#00,#00,#60,#30,#60,#60,#60,#30,#C0,#F0,#E0,#60,#C0,#30,#E0,#70,#E0,#C0,#60,#10,#80,#60,#60,#60,#60,#10,#80,#60,#60,#60,#60,#10,#80
db #30,#C0,#60,#00,#00,#C0,#F0,#00,#70,#C0,#10,#C0,#30,#E0,#10,#80,#60,#C0,#C0,#60,#00,#60,#00,#00,#70,#C0,#70,#e0,#70,#e0,#30,#C0,#30,#C0,#30,#C0,#30,#C0,#10,#80
db #00,#00,#F0,#00,#10,#E0,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#70,#C0,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
;;
;;  8,  8,  9,  9, enie,enie,ENIE,ENIE,!,!, ",  ",  :,  :,  =,  =,  ?,  ?,  /,  /
;;  00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F, 20, 21, 22, 23, 24, 25, 26, 27  
db #30,#C0,#30,#C0,#30,#C0,#30,#80,#10,#80,#60,#C0,#00,#00,#00,#00,#30,#C0,#00,#30,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
db #60,#60,#60,#60,#00,#00,#C0,#60,#10,#80,#60,#C0,#00,#00,#00,#00,#60,#60,#00,#70,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
db #60,#60,#60,#60,#D0,#80,#E0,#60,#10,#80,#60,#C0,#10,#80,#70,#e0,#00,#60,#00,#c0,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
db #30,#C0,#30,#E0,#60,#60,#F0,#60,#10,#80,#00,#00,#10,#80,#00,#00,#00,#C0,#10,#80,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
db #60,#60,#00,#60,#60,#60,#D0,#E0,#10,#80,#00,#00,#00,#00,#00,#00,#10,#80,#30,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
db #60,#60,#60,#60,#60,#60,#C0,#E0,#00,#00,#00,#00,#10,#80,#70,#e0,#00,#00,#60,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
db #30,#C0,#30,#C0,#60,#60,#C0,#60,#10,#80,#00,#00,#10,#80,#00,#00,#10,#80,#c0,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
db #00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#c0,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00,#00
;;
ca:
db #04