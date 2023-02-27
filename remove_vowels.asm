.data
	string: .asciiz "hellohowareyoudoingtoday"
	removed: .asciiz "Letters removed: "
	size: .word 24
	vowels: .asciiz "aeoui"
	endline: .asciiz "\n"
.text
main:
	la $a0, string
	jal remove_vowels
		
	li $v0, 4
	la $a0, string
	syscall

exit_pr:
	li $v0, 10
	syscall

remove_vowels:
	li $v0, 0
	check_letter:
		lb $a1, ($a0)
		beq $a1, $zero, exit
		la $t1, vowels# address string check
		check_vowel:
			lb $t2, ($t1)
			beq $t2, $zero, end_vowel_loop
			beq $t2, $a1, remove_letter
			addi $t1, $t1, 1
			j check_vowel
			remove_letter:
				move $t3, $a0
				move $t4, $a0
				addi $t4, $t4, 1
				remove_loop:
					lb $t5, ($t4)
					lb $t6, ($t3)
					beq $t6, $zero, end_remove_loop
					sb $t5, ($t3)
					addi $t3, $t3, 1
					addi $t4, $t4, 1
					j remove_loop
				end_remove_loop:		
					addi $a0, $a0, -1
		
		end_vowel_loop:
			addi $a0, $a0, 1
			j check_letter 
	

exit:
	jr $ra	
