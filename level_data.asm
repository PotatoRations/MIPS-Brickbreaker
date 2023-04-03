.text

.globl set_test_lvl
set_test_lvl:
	addi $sp, $sp, -4	# decrement stack pointer
	sw $ra 0($sp)		# Save return address
	
	li $a0, 1		# Work on the second row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	lw $ra, 0($sp)		# Load return from stack
	addi $sp, $sp, 4	# Increment stack pointer
	jr $ra

.globl set_bricks_lvl_1
# Set up bricks, used at initialisation
set_bricks_lvl_1:
	addi $sp, $sp, -4	# decrement stack pointer
	sw $ra 0($sp)		# Save return address
	
	# Top row (all 7 empty
	li $a0, 0		# Work on the first row	
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# Seconrd row (1000001)
	li $a0, 1		# Work on the second row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# Third row (0100010)
	li $a0, 2		# Work on the third row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# fourth row (0011100)
	li $a0, 3		# Work on the fourth row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# fifth row (0111110)
	li $a0, 4		# Work on the fifth row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# sixth row (1121211)
	li $a0, 5		# Work on the sixth row	
	li $t0, 1		# Make $t0, 1
	li $t1, 2		# Make $t1, 2
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# seventh row (1111111)
	li $a0, 6		# Work on the seventh row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# eighth row (1011101)
	li $a0, 7		# Work on the eighth row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# Ninth row (1000001)
	li $a0, 8		# Work on the ninth row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make  brick 0
	jal set_brick_row	# Call function to set the row
	
	
	lw $ra, 0($sp)		# Load return from stack
	addi $sp, $sp, 4	# Increment stack pointer
	jr $ra
	
.globl set_bricks_lvl_2
# Set up bricks for level 2
set_bricks_lvl_2:
	addi $sp, $sp, -4	# decrement stack pointer
	sw $ra 0($sp)		# Save return address
	
	# Top row (all 7 empty
	li $a0, 0		# Work on the first row	
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# Seconrd row (0020200)
	li $a0, 1		# Work on the second row	
	li $t0, 2		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# Third row (1020201)
	li $a0, 2		# Work on the third row	
	li $t0, 2		# Make $t0, 2
	li $t1, 1		# Make $t1, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# fourth row (0222220)
	li $a0, 3		# Work on the fourth row	
	li $t0, 2		# Make $t0, 2
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# fifth row (2222222)
	li $a0, 4		# Work on the fifth row	
	li $t0, 2		# Make $t0, 2
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# sixth row (0232320)
	li $a0, 5		# Work on the sixth row	
	li $t0, 2		# Make $t0, 2
	li $t1, 3		# Make $t1, 3
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# seventh row (2232322)
	li $a0, 6		# Work on the seventh row	
	li $t0, 2		# Make $t0, 2
	li $t1, 3		# Make $t1, 3
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# eighth row (0222220)
	li $a0, 7		# Work on the eighth row	
	li $t0, 2		# Make $t0, 2
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make first brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make first brick 0
	jal set_brick_row	# Call function to set the row
	
	# Ninth row (1000001)
	li $a0, 8		# Work on the ninth row	
	li $t0, 1		# Make $t0, 1
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make  brick 0
	jal set_brick_row	# Call function to set the row
	
	# Tenth row (1103011)
	li $a0, 9		# Work on the tenth row	
	li $t0, 1		# Make $t0, 1
	li $t1, 3		# Make $t1, 3
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t1, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $zero 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make  brick 0
	addi $sp, $sp, -4	# decrement stack pointer
	sw $t0, 0($sp)		# make  brick 0
	jal set_brick_row	# Call function to set the row
	
	lw $ra, 0($sp)		# Load return from stack
	addi $sp, $sp, 4	# Increment stack pointer
	jr $ra
