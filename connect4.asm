# CS 3340.502 
# Ji Won Lee, Name Here, Name Here
# Professor Nhut Nguyen
#
# Connect 4 
# End of Semester Project

# The board state is defined in 3 states: empty (0), Player 1 (1 or O), and Player 2(2 or X).

# Remove the Following Before Submission.
# Useful Link: http://people.cs.pitt.edu/~xujie/cs447/AccessingArray.htm

# Change log:
# 4/11/17: Ji Won Lee added board array and completed draw function.


.data
# Data array for a 7x6 game board (7 wide, 6 high)
board_6: .word 0, 0, 0, 0, 0, 0, 0
board_5: .word 0, 0, 0, 0, 0, 0, 0
board_4: .word 0, 0, 0, 0, 0, 0, 0
board_3: .word 0, 0, 0, 0, 0, 0, 0
board_2: .word 0, 0, 0, 0, 0, 0, 0
board_1: .word 0, 0, 0, 0, 0, 0, 0
board_bottom: .asciiz  " A ", " B ", " C ", " D ", " E ", " F ", " G "

# Board State
board_O: .asciiz "_O_ "
board_X: .asciiz "_X_ "
board_empty: .asciiz "___ "

# Basic game prompts

.text
# Game initialization
	#Load the game board address	
	la $s1, board_1
	la $s2, board_2
	la $s3, board_3
	la $s4, board_4
	la $s5, board_5
	la $s6, board_6
	la $s7, board_bottom
	
	j main_loop
	
# Draw Function
draw:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	j draw_main

determine:
	# Determine the value of the element
	add $t2, $zero, $zero
	
determine_loop:
	lw $t1, 0($t0)
	beq $t2, 7, determine_exit
	
	beq $t1, 0, print_0
	beq $t1, 1, print_1
	beq $t1, 2, print_2
	
	li $v0, 4
	la $a0, 0($t0)
	syscall
	
	li $v0, 11
	la $a0, ' '
	syscall
	
	addi $t2, $t2, 1
	addi $t0, $t0, 4
	
	j determine_loop
	
print_0:
	li $v0, 4
	la $a0, board_empty
	syscall
	
	addi $t2, $t2, 1
	addi $t0, $t0, 4
	
	j determine_loop
	
print_1:
	li $v0, 4
	la $a0, board_O
	syscall
	
	addi $t2, $t2, 1
	addi $t0, $t0, 4
	
	j determine_loop

print_2:
	li $v0, 4
	la $a0, board_X
	syscall
	
	addi $t2, $t2, 1
	addi $t0, $t0, 4
	
	j determine_loop
	
determine_exit:
	addi $a0, $0, 0xA
	addi $v0, $0, 0xB
	syscall
	
	jr $ra

draw_main:
	# Print each element in the row
	add, $t0, $s6, $zero # board_6
	jal determine
	add, $t0, $s5, $zero # board_5
	jal determine
	add, $t0, $s4, $zero # board_4
	jal determine
	add, $t0, $s3, $zero # board_3
	jal determine
	add, $t0, $s2, $zero # board_2
	jal determine
	add, $t0, $s1, $zero # board_1
	jal determine
	add, $t0, $s7, $zero # board_bottom
	jal determine
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	 
# Main Loop
main_loop:
	jal draw

# Exit statement
	li $v0, 10
	syscall