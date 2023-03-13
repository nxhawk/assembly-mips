# ((5x+3y+z)/2)*3
.data
	promptx: .asciiz "Input a number x: "
	prompty: .asciiz "Input a number y: "
	promptz: .asciiz "Input a number z: "
	result: .asciiz "Result: "
	zero: .float 0.0
	two: .float 2.0
	three: .float 3.0
	five: .float 5.0
.text
.globl main
main:
	#input x
	li $v0, 4
	la $a0, promptx
	syscall

	li $v0, 6
	syscall
	mov.s $f1,$f0

	#input y
	li $v0, 4
	la $a0, prompty
	syscall

	li $v0, 6
	syscall
	mov.s $f2,$f0

	#input z
	li $v0, 4
	la $a0, promptz
	syscall

	li $v0, 6
	syscall
	mov.s $f3,$f0

	# ((5x + 3y + z)/2)*3
	# ((5*f1 + 3*f2 + f3)/2)*3
	l.s $f4, five
	l.s $f5, three
	
	#5x + 3y
	mul.s $f1, $f1, $f4
	mul.s $f2, $f2, $f5

	# 5x + 3y + z
	add.s $f1, $f1, $f2
	add.s $f1, $f1, $f3
	
	l.s $f2, two
	div.s $f1, $f1, $f2
	mul.s $f1, $f1, $f5

	#print result
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 2
	mov.s $f12, $f1
	syscall 


exit:
	li $v0, 10
	syscall

 
	