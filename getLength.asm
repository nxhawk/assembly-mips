.data 
	str: .asciiz "Input your string: "
	res: .space 256
	endline: .byte '\n'
.text
.globl main
main:
	li $v0, 4
	la $a0, str
	syscall

	li $v0, 8
	la $a0, res
	li $a1, 256
	syscall	

	la $t2, res
	li $t1, 0
	lb $t3, endline
	loop:
		lb $t0, ($t2)
		beq $t0, $t3, strEnd
		addi $t2, $t2, 1
		addi $t1, $t1, 1
		j loop
	strEnd:
	
exit:
	li $v0, 10
	syscall
	