.data
	string: .asciiz "nhathao"

.text
main:
	la $a0, string
	addi $a0, $a0, -1
	
	li $v0, 4
	la $a0, string
	syscall