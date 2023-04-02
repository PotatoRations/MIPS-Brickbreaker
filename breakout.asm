################ CSC258H1F Fall 2022 Assembly Final Project ##################
# This file contains our implementation of Breakout.
#
# Student 1: Aerin Wang, 1008226484
# Student 2: Name, Student Number
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       4
# - Unit height in pixels:      4
# - Display width in pixels:    256
# - Display height in pixels:   512
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!

.globl ADDR_DSPL
ADDR_DSPL:
    .word 0x10008000
.globl DSPL_WIDTH
DSPL_WIDTH: .word 0x00000040	# Width of the display in pixels (64)
.globl DSPL_MEM_WIDTH
DSPL_MEM_WIDTH: .word 0x00000100	# Width of the display in memory (64*4=256)
.globl DSPL_HEIGHT
DSPL_HEIGHT:
	.word 0x00000080	# Height of the display in pixels (128)

# The address of the keyboard. Don't forget to connect it!
.globl ADDR_KBRD
ADDR_KBRD:
    .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################

.globl PAD_X
PAD_X:	.word 0x00000019 	# Leftmost pixel position of paddle (25 initially)
.globl PAD_Y
PAD_Y:	.word 0x00000078	# Paddle is 8 pixels off of bottom
.globl PAD_WIDTH
PAD_WIDTH: .word 0x0000000F	# Paddle is 15 pixels wide
.globl PAD_HEIGHT
PAD_HEIGHT: .word 0x00000003	# Paddle is 4 pixels tall
.globl PAD_COL
PAD_COL: .word 0x00CCCCFF	# Paddle colour (blue)

.globl BRICK_ARR
BRICK_ARR: .word 0 : 112	# Array for the bricks
				# Bricks are in a 7 wide x 16 tall grid
				# Each brick is 1 word in data, representing its health (if I implement it), or 0 if not exist
				
.globl BRICK_MEM_SIZE
BRICK_MEM_SIZE: .word 4		# Store the size of each brick in memory
.globl BRICK_ROW_MEM_SIZE
BRICK_ROW_MEM_SIZE: .word 28	# Store the size of each row in memory (20 bytes)

.globl BRICKS_IN_ROW
BRICKS_IN_ROW: .word 7		# Stores number of bricks in row
.globl BRICKS_IN_COL
BRICKS_IN_COL: .word 16		# Stores the nnumber of bricks in the column



.globl BALL_X
BALL_X: .word 0x00000020		# X location of ball
.globl BALL_Y
BALL_Y: .word 0x00000074		# Y loccation of ball
.globl BALL_X_V
BALL_X_V: .word 1			# X velocity of the ball, between 1 and -1
.globl BALL_Y_V
BALL_Y_V: .word -1			# Y velocity of the ball, always either 1 or -1


##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Brick Breaker game.
main:
	# Draw title screen
	jal set_bricks
	jal draw_paddle
	jal draw_walls
	jal jank_draw_bricks
	jal draw_ball 
	jal set_title
	jal draw_title
	jal title_logic # blocks game until A is pressed and we exit title screen
	jal clear_screen	# Clear the screen

    # Initialize the game
    jal set_bricks
    
    # start initial draw
    	jal draw_paddle
	jal draw_walls
	jal jank_draw_bricks
	jal draw_ball 

game_loop:
	# Clear screen
	jal clear_ball
	jal move_ball
	jal clear_paddle
	jal move_paddle
	# 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	
	
	
	# 3. Draw the screen
	jal draw_paddle
	jal draw_walls
	jal draw_ball 
	# Don't need to draw bricks as thos are handled when we calculare collisions
	
	# 4. Sleep
	li $v0, 32
	li $a0, 50
	syscall

    #5. Go back to 1
    b game_loop
    
game_over:	# Ends the game
	li $v0, 10
	syscall



# Puts onto $v0 the corresponding address of the pixel at (x,y)
# $a0 is the x
# $a1 is the y
# Function makes no use of $t registers (free to call without using stack)
.globl go_to_screen_mem
go_to_screen_mem:
	lw $v0, ADDR_DSPL	# Load display address into return value (cursor)
	lw $a2, DSPL_MEM_WIDTH	# Load display memory width for a line
	mult $a2, $a1		# Multiply to go down y rows
	mflo $a2		# Save row offset to $a2
	add $v0, $v0, $a2	# Add y offset to cursor
	li $a2, 4		# Load pixel size to $a2
	mult $a2, $a0		# Multiply x value with pixel size
	mflo $a2
	add $v0, $v0, $a2	# Add x offset to cursor
   	jr $ra
    
move_ball:
	lw $t0, BALL_X		# Load ball x position
	lw $t1, BALL_X_V	# Load ball x velocity
	lw $t2, BALL_Y		# Load ball y position
	lw $t3, BALL_Y_V	# Load ball y velocity
	li $t8, 0		# Set to 1 if we changed the x velocity
	li $t9, 0		# Set to 1 if we changed the y velocity
	addi $sp, $sp, -4	# Decrement stack
	sw $ra, 0($sp)		# Save return address
	
	# Hosuekeeping stuff to fix edge cases
	lw $t4, DSPL_HEIGHT	# Load display height
	bge $t2, $t4, game_over	# End game if the ball is off screen
	lw $t4, PAD_Y		# Load paddle height
	bge $t2, $t4, resolve_ball_v	# Prevent weird things like the ball getting stuck inside the paddle
	
	ball_x_collision:
	beq $t1, $zero, ball_y_collision	# If we have no x velocity, just resolve the y
	add $t4, $t0, $t1	# Set $t4 to the next x of the ball
	# Get cursor to position beside ball
	add $a0, $t4, $zero	# Set $a0 (x) to next x
	add $a1, $t2, $zero	# Set $a1 (y) to same y (will check y direction later)
	jal go_to_screen_mem	# Get the screen location
	lw $t5, 0($v0)		# Get pixel colour value from screen memory into $t4
	beq $t5, $zero, no_x_col# Check if pixel colour is black
	# If we have a collision
	x_col:
		li $t8, 1		# Set to 1 to say that we have changed the x velocity
		sub $t1, $zero, $t1	# Reverse the x velocity
		sw $t1, BALL_X_V	# Save the reversed velocity
		
		# Send call to break the brick we hit
		# Save registers to stack
		jal push_all_registers
		add $a0, $t4, $zero	# Set a0 to x of brick
		add $a1, $t2, $zero	# set a1 to y of brick
		jal break_brick_from_coords	# call break brick
		# pop all registers from stack
		jal pop_all_registers	
		j ball_y_collision
	# If we don't have a collision
	no_x_col:
		
	ball_y_collision:	# Check y collision
	add $t4, $t2, $t3	# Set $t4 to the next y of the ball
	# Get cursor to position above/below ball
	add $a0, $t0, $zero	# Set $a0 (x) to same x
	add $a1, $t4, $zero	# Set $a1 (y) to next y
	jal go_to_screen_mem	# Get the screen location
	lw $t5, 0($v0)		# Get pixel colour value from screen memory into $t4
	beq $t5, $zero, no_y_col# Check if pixel colour is black
	# If we have a collision
	y_col:
		li $t9, 1		# Set to 1 to say that we have changed the y velocity
		sub $t3, $zero, $t3	# Reverse the y velocity
		sw $t3, BALL_Y_V	# Save the reversed velocity
		
		# Send call to break the brick we hit
		# Save registers to stack
		jal push_all_registers
		add $a0, $t0, $zero	# Set a0 to x of brick
		add $a1, $t4, $zero	# set a1 to y of brick
		jal break_brick_from_coords	# call break brick
		# pop all registers from stack
		jal pop_all_registers	
		
		j resolve_ball_v	# Jump to resolve velocity
	# If we don't have a collision
	no_y_col:
	
	ball_diag_collision: # only fire if we have not changed any velocity, meant to handle corner case where ball bounces off protruding corner
	beq $t8, $zero, resolve_ball_v	# Skip if we have changed any velocity
	beq $t9, $zero, resolve_ball_v
	beq $t1, $zero, resolve_ball_v	# Skip if we have no x velocity
	add $t4, $t0, $t1	# Set $t4 to the next x of the ball
	add $t5, $t2, $t3	# Set $t5 to the next y of the ball
	# Get cursor to position on diag
	add $a0, $t4, $zero	# Set $a0 (x) to next x
	add $a1, $t5, $zero	# Set $a1 (y) to next y
	jal go_to_screen_mem
	lw $t6, 0($v0)		# Get pixel colour value from screen memory into $t4
	beq $t6, $zero, no_xy_col# Check if pixel colour is black
	# If we have a collision
	xy_col:
		sub $t1, $zero, $t1	# Reverse the x velocity
		sw $t1, BALL_X_V	# Save the reversed x velocity
		sub $t3, $zero, $t3	# Reverse the y velocity
		sw $t3, BALL_Y_V	# Save the reversed y velocity
		
		# Send call to break the brick we hit
		# Save registers to stack
		jal push_all_registers
		add $a0, $t4, $zero	# Set a0 to x of brick
		add $a1, $t5, $zero	# set a1 to y of brick
		jal break_brick_from_coords	# call break brick
		# pop all registers from stack
		jal pop_all_registers	
		
		j resolve_ball_v	# Jump to resolve velocity
	# If we don't have a collision
	no_xy_col:
	
	resolve_ball_v:	# resolve velocity
	add $t0, $t0, $t1	# Add x velocity to x position
	sw $t0, BALL_X		# Save new x position
	add $t2, $t2, $t3	# Add y velocity to y position
	sw $t2, BALL_Y		# Save new y position
	move_ball_end: # Get return address from stack and return
	lw $ra, 0($sp)		# Pop return address from stack
	addi $sp, $sp, 4	# Increment stack pointer
	jr $ra

move_paddle:
	lw $t0, ADDR_KBRD		# Load keyboard address
	lw $t1, 0($t0)			# Load if key has been pressed
	beq $t1, $zero, no_key		# If no key has been pressed, skip
	lw $t1, 4($t0)			# Load the key pressed
	beq $t1, 0x61, move_pad_left	# If A is pressed, move paddle left
	beq $t1, 0x64, move_pad_right	# If D is pressed, move paddle right
	j no_key	# not a key we care about
	move_pad_right:
		lw $t2, PAD_X	# Load paddle x position
		addi $t2, $t2, 1	# Increment paddle pos
		sw $t2, PAD_X		# Store paddle x pos
		j no_key
	move_pad_left:
		lw $t2, PAD_X	# Load paddle x position
		addi $t2, $t2, -1	# Increment paddle pos
		sw $t2, PAD_X		# Store paddle x pos
		
		j no_key
	no_key:
	jr $ra

# Set up bricks, used at initialisation
set_bricks:
	add $t9, $zero, $ra	# Save return address to $t9
	li $a0, 0		# Work on the first row	
	li $a1, 255		# Set 3 middle bricks of top row (01110 = 14)
	jal set_brick_row	# Call function to set the row
	li $a0, 1		# Work on the first row	
	li $a1, 1		# Set 3 middle bricks of top row
	jal set_brick_row	# Call function to set the row
	li $a0, 2		# Work on the first row	
	li $a1, 2		# Set 3 middle bricks of top row
	jal set_brick_row	# Call function to set the row
	li $a0, 3		# Work on the first row	
	li $a1, 3		# Set 3 middle bricks of top row
	jal set_brick_row	# Call function to set the row
	li $a0, 4		# Work on the first row	
	li $a1, 4		# Set 3 middle bricks of top row
	jal set_brick_row	# Call function to set the row
	li $a0, 5		# Work on the first row	
	li $a1, 5		# Set 3 middle bricks of top row
	jal set_brick_row	# Call function to set the row
	jr $t9				# Return to caller
	
# Set up bricks, used at initialisation
set_full_bricks:
	addi $sp, $sp, -4	# Decrement stack
	sw $ra, 0($sp)		# Save return address
	
	lw $t1, BRICKS_IN_COL	# get number of columns of bricks
	set_full_bricks_loop:
		blez $t1, set_full_bricks_end	# If we are at row 0 or less, stop
		addi $sp, $sp, -4	# push $t1 onto stack
		sw $t1, 0($sp)		
		
		addi $a0, $t1, -1	# Assign row 1 less than our loop var
		li $a1, 255		# Set all bricks on
		jal set_brick_row	# call helper function
		# Pop $t1 from stack
		lw $t1, 0($sp)		# Load return address
		addi $sp, $sp, 4	# Increment stack pointer
		addi $t1, $t1, -1	# Decrement $t1
		j set_full_bricks_loop
	set_full_bricks_end:
	lw $ra, 0($sp)		# Load return address
	addi $sp, $sp, 4	# Increment stack pointer
	jr $ra				# Return to caller
	
# set brick row
# $a0: the row to work on (0-8)
# $a1: the mask for the bricks (i.e. 11000 represents the right 2 bricks (is mirrored))
# Could also pass in brick health or something
# Will keep $t9 free for return function calls
set_brick_row:
	# Set up memory pointer
	la $t0, BRICK_ARR		# Load pointer to bricks array into $t0
	lw $t1, BRICK_ROW_MEM_SIZE	# Load the size of a row's memory into $t0
	mult $a0, $t1			# Multiply the number of rows we're skipping with the size of each row in memory
	mflo $t1			# Load total memory offset to $t0
	add $t0, $t0, $t1		# Add memory offset to $t0
	# Start changing brick values
	lw $t1, BRICKS_IN_ROW		# Load the number of bricks in row into $t1 (loop variable)
	set_brick_loop:
		beq $t1, $zero, end_set_brick_loop 	# Branch statment if we have finished each brick in row	
		li $t2, 2	
		div $a1, $t2				# Get the last digit value (by dividing by 2 and checking if 0)
		mfhi $t2
		beq $t2, $zero, not_brick		# If it is 1, we make it a brick
			li $a0, 1			# Make brick health 1 (can change later)
			sw $a0, 0($t0)			# Save health value to brick	
							# Store other values here
			j brick_branch_end
		not_brick:
			sw $zero, 0($t0)		# Set brick value to black
							# Store other values here
		brick_branch_end:
		addi $t1, $t1, -1 	# Decrement loop var
		lw $t3, BRICK_MEM_SIZE	# Increment brick row pos
		add $t0, $t0, $t3
		srl $a1, $a1, 1		# Shift mask right by 1
		j set_brick_loop	# Restart loop
	end_set_brick_loop:
	jr $ra

# Break a brick from coordonates, if the coordonate is inside the brick, it will break
# $a0 x coord of brick
# $a1 y coord of brick
break_brick_from_coords:
	lw $t0, BRICK_OFFSET_X		# Load brick offsets
	lw $t1, BRICK_OFFSET_Y		
	la $t2, BRICK_ARR		# Load brick array pointer
	lw $t3, BRICKS_IN_COL		# Load bricks in row and column (for sanity check)
	lw $t4, BRICKS_IN_ROW		
	
	# get raw array element from coords
	sub $a0, $a0, $t0	# sub brick_offset_x from x coord
	lw $t0, BRICK_WIDTH	# Load brick width
	div $a0, $t0		# divide new x coord by brick width to get the column
	mflo $t0		# Load raw column value into $t0
	
	sub $a1, $a1, $t1	# sub brick_offset_y from y coord
	lw $t1, BRICK_HEIGHT	# Load brick height
	div $a1, $t1		# divide new y coord by brick height to get the column
	mflo $t1		# Load raw row value into $t0
	
	# perform sanity check
	bltz $t0, end_break_brick_from_coords 		# If column value is negative or too high, fail
	bge $t0, $t4, end_break_brick_from_coords
	bltz $t1, end_break_brick_from_coords 		# If row value is negative or too high, fail
	bge $t1, $t3, end_break_brick_from_coords
	
	# get brick index
	mult $t1, $t4		# multiply row by number of bricks in each row
	mflo $t5		# Add to index ($t5)
	add $t5, $t5, $t0	# Add column number to index
	lw $t0, BRICK_MEM_SIZE	# Load brick memory size
	mult $t5, $t0		# Multiply index by brick memory size to get true offset
	mflo $t5		# Save true offset to $t5
	add $t2, $t2, $t5	# add true offset to brick array pointer
	
	# break the brick if it exists
	lw $t0, 0($t2)		# Load health of brick
	beqz $t0, end_break_brick_from_coords	# If the brick is nonexistent, we can't break it
	addi $t0, $t0, -1	# decrement $t0
	sw $t0, 0($t2)		# save $t0
	# Redraw bricks now that we have broken one
	addi $sp, $sp, -4	# decrement stack
	sw $ra, 0($sp)		# save return address
	jal jank_draw_bricks	# redraw bricks
	lw $ra, 0($sp)		# load return address
	addi $sp, $sp, 4	# increment stack
	
	end_break_brick_from_coords:
	jr $ra
	

# Clears the screen
clear_screen:
	lw $t0, ADDR_DSPL	# Load screen memory address
	lw $t1, DSPL_WIDTH	# Load screen width
	lw $t2, DSPL_HEIGHT	# Load screen height
	
	mult $t1, $t2		# Multiply height and width to get the number of pixels to clear
	
	mflo $t1		# save total number of pixels to $t1
	
	clear_loop:
		beq $t1, $zero, end_clear	# End loop once we have cleared all pixels
		sw $zero, 0($t0)		# Draw blank pixel
		addi $t1, $t1, -1 		# Decrement pixels to update
		addi $t0, $t0, 4		# Increment the cursor
		j clear_loop
	end_clear:
	jr $ra

# Save all registers
push_all_registers:
	addi $sp, $sp, -4	# Decrement stack
	sw $t0, 0($sp)		# Save t0
	addi $sp, $sp, -4	# Decrement stack
	sw $t1, 0($sp)		# Save t1
	addi $sp, $sp, -4	# Decrement stack
	sw $t2, 0($sp)		# Save t2
	addi $sp, $sp, -4	# Decrement stack
	sw $t3, 0($sp)		# Save t3
	addi $sp, $sp, -4	# Decrement stack
	sw $t4, 0($sp)		# Save t4
	addi $sp, $sp, -4	# Decrement stack
	sw $t5, 0($sp)		# Save t5
	addi $sp, $sp, -4	# Decrement stack
	sw $t6, 0($sp)		# Save t6
	addi $sp, $sp, -4	# Decrement stack
	sw $t7, 0($sp)		# Save t7
	addi $sp, $sp, -4	# Decrement stack
	sw $t8, 0($sp)		# Save t8
	addi $sp, $sp, -4	# Decrement stack
	sw $t9, 0($sp)		# Save t9
	jr $ra
	
# Pop all registers
pop_all_registers:
	lw $t9, 0($sp)		# load $t9
	addi $sp, $sp, 4	# Increment stack
	lw $t8, 0($sp)		# load $t8
	addi $sp, $sp, 4	# Increment stack
	lw $t7, 0($sp)		# load $t7
	addi $sp, $sp, 4	# Increment stack
	lw $t6, 0($sp)		# load $t6
	addi $sp, $sp, 4	# Increment stack
	lw $t5, 0($sp)		# load $t5
	addi $sp, $sp, 4	# Increment stack
	lw $t4, 0($sp)		# load $t4
	addi $sp, $sp, 4	# Increment stack
	lw $t3, 0($sp)		# load $t3
	addi $sp, $sp, 4	# Increment stack
	lw $t2, 0($sp)		# load $t2
	addi $sp, $sp, 4	# Increment stack
	lw $t1, 0($sp)		# load $t1
	addi $sp, $sp, 4	# Increment stack
	lw $t0, 0($sp)		# load $t0
	addi $sp, $sp, 4	# Increment stack
	jr $ra

