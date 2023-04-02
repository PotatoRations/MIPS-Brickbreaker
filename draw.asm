.data
.globl BRICK_OFFSET_X
.globl BRICK_OFFSET_Y
BRICK_OFFSET_X: .word 4		# brick draw left offset
BRICK_OFFSET_Y: .word 5		# Brick draw top offset

WALL_COL: .word 0x00FF0000	# Wall colour (white)
CEIL_HEIGHT: .word 0x00000004	# Ceiling height (offset from top)

.globl BRICK_WIDTH
BRICK_WIDTH: .word 0x00000008		# Width of each brick (8 pixels)
.globl BRICK_HEIGHT
BRICK_HEIGHT: .word 0x00000004 		# Height of each brick (4 pix)


.text
.globl jank_draw_bricks
jank_draw_bricks:
	addi $sp, $sp, -4	# Increment stack to next open slot
	sw $ra, 0($sp)	# Push return address
	
	lw $a0, BRICK_OFFSET_X	# Load x offset into a0
	lw $a1, BRICK_OFFSET_Y	# Load y offset into a1
	jal go_to_screen_mem	# Get starting cursor postion 
	add $t0, $v0, $zero	# Load starting cursor postion to $t0
	lw $t4, BRICKS_IN_COL	# Set outer loop var
	lw $t5, BRICKS_IN_ROW	# Set inner loop var
	la $t9, BRICK_ARR	# Load brick array pointer position
	
	jdb_outer:	# Outer loop, draws each row
		beq $t4, $zero, end_jdb_outer	# Exit loop
		# push the cursor into the stack (to reset for later after the row is drawn)
		addi $sp, $sp, -4	# Increment stack to next open slot
		sw $t0, 0($sp)		# Push
		jdb_inner:	# Inner loop, draws each brick in row
			beq $t5, $zero, end_jdb_inner	# Exit loop
			
			lw $t7, 0($t9)				# Get brick health from array
								# if 3, paint blue, if 2, paint green, if 1, paint red, if 0 paint black
			# save colour in $t3
			li $t3, 0	
			blez $t7, jdb_finish_colour		# If 0, paint black
			li $t3, 0x00EE1111		
			beq $t7, 1, jdb_finish_colour		# If 1, paint red
			li $t3, 0x0011EE11	
			beq $t7, 2, jdb_finish_colour		# If 2, paint green
			li $t3, 0x001111EE			# if 3, paint blue
			
			jdb_finish_colour:
			# Save variables onto stack
			addi $sp, $sp, -4	# Increment stack to next open slot
			sw $t0, 0($sp)	# Push cursor
			addi $sp, $sp, -4	# Increment stack to next open slot
			sw $t3, 0($sp)	# Push colour
			addi $sp, $sp, -4	# Increment stack to next open slot
			sw $t4, 0($sp)	# Push outer counter
			addi $sp, $sp, -4	# Increment stack to next open slot
			sw $t5, 0($sp)	# Push inner counter
			addi $sp, $sp, -4	# Increment stack to next open slot
			sw $t9, 0($sp)	# Push brick array pointer
			
			# Call rectangle drawing function
			add $a0, $zero, $t0		
			lw $a1, BRICK_HEIGHT
			lw $a2, BRICK_WIDTH
			add $a3, $t3, $zero
			jal draw_rect
			
			# Pop off the stack
			lw $t9, 0($sp)		# Pop brick array pointer from stack
			addi $sp, $sp, 4		# Increment stack
			lw $t5, 0($sp)		# Pop inner counter from stack
			addi $sp, $sp, 4		# Increment stack
			lw $t4, 0($sp)		# Pop outer counter from stack
			addi $sp, $sp, 4		# Increment stack
			lw $t3, 0($sp)		# Pop colour counter from stack
			addi $sp, $sp, 4		# Increment stack
			lw $t0, 0($sp)		# Pop cursor from stack
			addi $sp, $sp, 4		# Increment stack
			
			addi $t5, $t5, -1	# Decrement loop var
			lw $t7, BRICK_MEM_SIZE	# Load brick memory size
			add $t9, $t7, $t9 	# Increment brick array pointer
			
			# Increment cursor by brick width
			lw $t6, BRICK_WIDTH	# Brick width
			li $t7, 4		# Width of pixel
			mult $t6, $t7
			mflo $t6
			add $t0, $t0, $t6
			j jdb_inner	
		end_jdb_inner:
		lw $t5, BRICKS_IN_ROW		# Reset brick in row count
		# Reset cursor
		lw $t0, 0($sp)		# Pop old cursor from stack
		addi $sp, $sp, 4		# Increment stack
		# Bring cursor to next row
		lw $t6, BRICK_HEIGHT	# Height of brick
		lw $t7, DSPL_MEM_WIDTH	# Memory offset to next row
		mult $t6, $t7		# multiply to get total offset
		mflo $t6	
		add $t0, $t6, $t0	# Bring cursor to next row (brick height)
		addi $t4, $t4, -1	# Decrement row	
		j jdb_outer
	end_jdb_outer:
	lw $ra, 0($sp)		# Pop return address from stack
	addi $sp, $sp, 4		# Increment stack
	jr $ra
	
.globl draw_ball
draw_ball:
	# Setup cursor
	lw $a0, BALL_X		# Load ball x and y
	lw $a1, BALL_Y
	addi $sp, $sp, -4	# Decrement stack pointer
	sw $ra, 0($sp)		# Save return address to stack
	jal go_to_screen_mem	# Get positioned screen cursor in $v0
	lw $ra, 0($sp)		# Get return value back
	addi $sp, $sp, 4	# Increment stack pointer
	
	add $a0, $v0, $zero	# Load cursor to a0
	li $a1, 1		# Load ball width and height to a1 and a2
	li $a2, 1		
	li $a3, 0x00FFFFFF	# Load ball colour
	add $t9, $ra, $zero	# Transfer return address (about to make function call)
	jal draw_rect	
	jr $t9

.globl clear_ball		
clear_ball:
	# Setup cursor
	lw $a0, BALL_X		# Load ball x and y
	lw $a1, BALL_Y
	addi $sp, $sp, -4	# Decrement stack pointer
	sw $ra, 0($sp)		# Save return address to stack
	jal go_to_screen_mem	# Get positioned screen cursor in $v0
	lw $ra, 0($sp)		# Get return value back
	addi $sp, $sp, 4	# Increment stack pointer
	
	add $a0, $v0, $zero	# Load cursor to a0
	li $a1, 1		# Load ball width and height to a1 and a2
	li $a2, 1		
	li $a3, 0x000000	# Load ball colour
	add $t9, $ra, $zero	# Transfer return address (about to make function call)
	jal draw_rect	
	jr $t9

.globl draw_walls
# Draws the walls 
draw_walls:
	lw $t0, ADDR_DSPL	# Load screen memory address
	lw $t4, WALL_COL	# Load wall colour
	# Draw the top ceiling
	lw $t1, DSPL_WIDTH	# Load screen width
	lw $t2, CEIL_HEIGHT	# Load ceiling height
	mult $t1, $t2		# Multiply screen width by ceiling height to get number of pixels to offset
	mflo $t2		# Move pixel offset into $t2
	addi $t3, $zero, 4	# Load 4 into $t3
	mult $t3, $t2		# Multiply pixel offset by 4 to get memory offset
	mflo $t2		# Move memory offset into $t2
	add $t0, $t0, $t2	# Add memory offset to $t0 (display address)
	addi $t3, $t0, 0	# Display address copy (for later)
	draw_ceiling_loop:	# Loop that draws the top ceiling
		beq $t1, $zero, end_draw_ceiling_loop	# Ends drawing the ceiling once we have all pixels done
		sw $t4, 0($t0)		# Draw pixel
		addi $t0, $t0, 4	# Increment cursor
		addi $t1, $t1, -1 	# Decrement loop variable
		j draw_ceiling_loop
	end_draw_ceiling_loop:
	# Draw the two walls
	addi $t0, $t0, -4		# Move $t0 back by 1, so we end up back at last pixel of line
	lw $t1, DSPL_HEIGHT		# Load display height into $t1
	lw $t2, CEIL_HEIGHT		# Load ceiling height into $t2
	sub $t1, $t1, $t2		# Make $t1 the # of pixels in wall
	lw $t2, DSPL_MEM_WIDTH		# Load the total memory offset of a row into $t2
	draw_wall_loop:			# Loop to draw walls
		beq $t1, $zero, end_draw_wall	# If we have run out of wall, end
		sw $t4, 0($t0)			# draw left
		sw $t4, 0($t3)			# draw right
		addi $t1, $t1, -1		# decrement $t1
		add $t0, $t0, $t2		# Increase $t0 to next row
		add $t3, $t3, $t2		# Increase $t3 to next row
		j draw_wall_loop
	end_draw_wall:
	jr $ra

.globl draw_paddle
# Draws the paddle
# Uses $t0, $t1, $t2, $t3, $t4, and $t5
draw_paddle:
	# Get address of cursor
	lw $a0, PAD_X		# Load paddle x and y
	lw $a1, PAD_Y
	addi $sp, $sp, -4	# Decrement stack pointer
	sw $ra, 0($sp)		# Save return address to stack
	jal go_to_screen_mem	# Get positioned screen cursor in $v0
	
	
	# Drawing the paddle
	add $a0, $v0, $zero	# Load cursor to a0
	lw $a1, PAD_HEIGHT
	lw $a2, PAD_WIDTH	# Load paddle width and height  to a
	lw $a3, PAD_COL		# Load paddle colour
	jal draw_rect	
	lw $ra, 0($sp)		# Get return value back
	addi $sp, $sp, 4	# Increment stack pointer
	jr $ra
	
.globl clear_paddle
# Draws the paddle
# Uses $t0, $t1, $t2, $t3, $t4, and $t5
clear_paddle:
	# Get address of cursor
	lw $a0, PAD_X		# Load paddle x and y
	lw $a1, PAD_Y
	addi $sp, $sp, -4	# Decrement stack pointer
	sw $ra, 0($sp)		# Save return address to stack
	jal go_to_screen_mem	# Get positioned screen cursor in $v0
	lw $ra, 0($sp)		# Get return value back
	addi $sp, $sp, 4	# Increment stack pointer
	
	# Drawing the paddle
	add $a0, $v0, $zero	# Load cursor to a0
	lw $a1, PAD_HEIGHT
	lw $a2, PAD_WIDTH	# Load paddle width and height  to a
	li $a3, 0x00000000	# Load black
	add $t9, $ra, $zero	# Transfer return address (about to make function call)
	jal draw_rect	
	jr $t9

	
	
# rectangle drawing function, adapted from in-class demo by Prof. Engels
# takes in the following:
# - $a0 : Starting location of the rectange
# - $a1 : height of the rectangle
# - $a2 : width of the reactangle
# - $a3 : colour of rectangle to draw
draw_rect:
	addi $t0, $a0, 0	 	# put location to $t0
	addi $t1, $a1, 0	 	# put height to $t1
	addi $t2, $a2, 0	 	# put width to $t2
	draw_rect_outer_loop:
		beq $t1, $zero, draw_rect_end	# if the height variable is 0, jump to end
		draw_rect_inner_loop:					# This draws a line of specified width
			beq $t2, $zero, draw_rect_inner_loop_end	# if the width variable is 0, jump to end of inner loop
			sw $a3, 0($t0)					# Draw a pixel at the current location
			addi $t2, $t2, -1 				# Decrement the width variable
			addi $t0, $t0, 4				# Move drawing location to the right
			j draw_rect_inner_loop				# Jump to start of inner loop
		draw_rect_inner_loop_end:
		add $t2, $zero, $a2				# Restore the value of $t2
		addi $t1, $t1, -1				# Decrement height variable
		# Bring drawing address to new line
		lw $t3, DSPL_MEM_WIDTH				# Get the memory width of a row
		add $t0, $t0, $t3				# Bring cursor to new line
		sll $t4, $t2, 2					# Multiply $t2 by 4, to change it to bytes
		sub $t0, $t0, $t4				# Reset drawing address to start of the new line
		j draw_rect_outer_loop				# Jump to beginning of outer loop
	draw_rect_end:			# return to calling location
		jr $ra
