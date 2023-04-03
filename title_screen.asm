.data
.globl title_banner
title_banner: .word 0x00000000 : 1280 # 64x20 (1280) pixels
title_banner_size: 1280			# Size in pixels of title banner
title_height: .word 20			# Height of title banner
title_offset_y: .word 15		# offset of banner from top



.text
.globl draw_title
draw_title:
	addi $sp, $sp, -4	# Decrement stack
	sw $ra, 0($sp)		# Save return value
	
	# setting up cursor
	li $a0, 0
	lw $a1, title_offset_y
	jal go_to_screen_mem	# setup cursor at right spot
	add $t0, $zero, $v0	# move cursor into $t0
	
	la $t1, title_banner	# Load pointer to title banner in memory
	lw $t2, title_banner_size	# Load loop variable
	
	draw_title_loop:
		beq $t2, $zero, draw_title_loop_end
		# copy memory over
		lw $t3, 0($t1)		# Load banner pixel into $t3
		sw $t3, 0($t0)		# Save banner pixel into screen
		addi $t2, $t2, -1	# decrement loop var
		addi $t1, $t1, 4	# Increment pointers to screen and title_banner memory
		addi $t0, $t0, 4
		j draw_title_loop
	draw_title_loop_end:
	
	lw $ra, 0($sp)		# load return value
	addi $sp, $sp, 4
	jr $ra

# Loops endlessly until the player presses A
.globl title_logic
title_logic:
	lw $t0, ADDR_KBRD		# Load keyboard address
	title_check_key:
	lw $t1, 0($t0)			# Load if key has been pressed
	beq $t1, $zero, title_check_key	# If no key has been pressed, return to check key
	lw $t1, 4($t0)			# Load the key pressed
	beq $t1, 0x61, start_game	# If A is pressed, start the game
	j title_check_key
	start_game:
	jr $ra

#  Sets up the title in memory
.globl set_title
set_title:
	la $t0, title_banner
	li $t1, 0x00FFFFFF	# Text will be white
	
	addi $t0, $t0, 256	# skip first row (all blank)
	## Big breakout text
	# Second row
	addi $t0, $t0, 4
		
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# T
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# Third row
	addi $t0, $t0, 4
		
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# T
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# forth row
	addi $t0, $t0, 4	
	
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
		
	addi $t0, $t0, 4	# T
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# Fifth row
	addi $t0, $t0, 4	
	
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
		
	addi $t0, $t0, 4	# T
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# Sixth row
	addi $t0, $t0, 4	
	
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
				# T
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# Seventh row
	addi $t0, $t0, 4	
	
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
				# T
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# Eighth row
	addi $t0, $t0, 4	
	
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
		
	addi $t0, $t0, 4	# T
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# Ninth row
	addi $t0, $t0, 4	
	
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
		
	addi $t0, $t0, 4	# T
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# Tenth row
	addi $t0, $t0, 4
		
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
				# T
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	# Eleventh row
	addi $t0, $t0, 4
		
	sw $t1, 0($t0)		# B
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# K
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# O
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# U
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
				# T
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	addi $t0, $t0, 256	# skip next two rows
	addi $t0, $t0, 256	
	
	## Press A
	## First row
	addi $t0, $t0, 76	# first 19 pixels are empty
	
	sw $t1, 0($t0)		# P
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# S
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# S
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4	# :
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 80	# last 20 pixels are empty
	
	## Second row
	addi $t0, $t0, 76	# first 19 pixels are empty
	
	sw $t1, 0($t0)		# P
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# S
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# S
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
			
	addi $t0, $t0, 4	# :
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 80	# last 20 pixels are empty
	
	## Third row
	addi $t0, $t0, 76	# first 19 pixels are empty
	
	sw $t1, 0($t0)		# P
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# S
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# S
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4	# :
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 80	# last 20 pixels are empty
	
	## Fourth row
	addi $t0, $t0, 76	# first 19 pixels are empty
	
	sw $t1, 0($t0)		# P
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
				# S
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
				# S
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
			
	addi $t0, $t0, 4	# :
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 80	# last 20 pixels are empty
	
	## Fifth row
	addi $t0, $t0, 76	# first 19 pixels are empty
	
	sw $t1, 0($t0)		# P
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# R
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# E
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# S
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# S
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 4	# :
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	
	sw $t1, 0($t0)		# A
	addi $t0, $t0, 4
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	
	addi $t0, $t0, 80	# last 20 pixels are empty
	
	jr $ra
	
