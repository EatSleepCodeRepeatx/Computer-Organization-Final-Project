.data

	# prompt to read
num1:		.float 0.0
first:	.asciiz "\n<Any invalid input would be considered as zero>\nEnter first point cordinate: \n"
firstx1:	.asciiz "\nX1:"
firstx2:	.asciiz "\nX2:"
second:  	.asciiz "\n<Any invalid input would be considered as zero>\nEnter second point cordinate: \n"
secondy1:	.asciiz "\nY1:"
secondy2:  .asciiz "\nY2:"
result:	.asciiz "\nEuclidean Distance is:"
newInput:   .asciiz "\n\nDo you want to run the program again  (1:Yes, 2:No)      : "
invalidInputTwo:   .asciiz "\nInvalid operation input, enter new input (1:Yes, 2:No)   : "
endingOutput: .asciiz "\nYou choose to end the program, please close window\n"

newline: 	.asciiz "\n"
	.globl	main

	.text

main:

# get first str
	li $v0, 4			# system call code for printing string = 4
	la $a0, first		# load address of string to be printed into $a0
	syscall			# call operating system to perform print operation

	li $v0, 4			# system call code for printing string = 4
	la $a0, firstx1		# load address of string to be printed into $a0
	syscall			# call operating system to perform print operation

	li $v0, 5			# get ready to read in X1
	syscall			# system waits for input
	move		$t0,$v0	# save X1

	li $v0, 4			# system call code for printing string = 4
	la $a0, firstx2		# load address of string to be printed into $a0
	syscall			# call operating system to perform print operation

	li $v0, 5			# get ready to read in X1
	syscall			# system waits for input
	move		$t1,$v0	# save X2


	li $v0, 4			# system call code for printing string = 4
	la $a0, second		# load address of string to be printed into $a0
	syscall			# call operating system to perform print operation

	li $v0, 4			# system call code for printing string = 4
	la $a0, secondy1	# load address of string to be printed into $a0
	syscall			# call operating system to perform print operation

	li $v0, 5			# get ready to read in X1
	syscall			# system waits for input
	move		$t2,$v0	# save X1

	li $v0, 4			# system call code for printing string = 4
	la $a0, secondy2	# load address of string to be printed into $a0
	syscall			# call operating system to perform print operation

	li $v0, 5			# get ready to read in X1
	syscall			# system waits for input
	move		$t3,$v0	# save X2


# get Euclidean distance
	li		$t5,0			# set initial Euclidean distance
	sub		$t0,$t0,$t2	# X1 - Y1
	multu		$t0,$t0		# (X1-Y1) ^ 2
	mflo		$t0			# get result in $t0

	sub		$t1,$t1,$t3	# X2 - Y2
	multu		$t1,$t1		# (X2-Y2) ^ 2
	mflo		$t1			# get result in $t1

	add		$t0,$t0,$t1	# x
	move		$a0,$t0
	jal		math
	# result in $v0
	move		$t5,$v0


# print result
	li 		$v0, 4			# system call code for printing string = 4
	la 		$a0, result		# load address of string to be printed into $a0
	syscall					# call operating system to perform print operation

	move		$a0,$t5
	li 		$v0, 1			# get ready to print a number
	syscall					# system waits for input

	li         $v0, 4
	la         $a0, newInput
	syscall

	li         $v0, 5            # get ready to read in number
	syscall                      # system waits for input
	move        $s3,$v0          # store operator int in $s3

	#compare $s3
	beq        $s3,1, doAgain
	beq        $s3,2, endTheCode

	bne        $s3,1, badInput
	bne        $s3,2, badInput
	badInput:
	li         $v0, 4
	la         $a0, invalidInputTwo
	syscall

	li         $v0, 5            # get ready to read in number
	syscall                      # system waits for input

	move        $s3,$v0          # store operator int in $s3

	beq        $s3,1, doAgain
	beq        $s3,2, endTheCode
	bne        $s3,1, badInput
	bne        $s3,2, badInput

	doAgain:
	b        main

	endTheCode:

	li         $v0, 4             # system call code for printing string = 4

	la         $a0, endingOutput  # load address of string to be printed into $a0
	syscall                       # call system to perform print operation

	li $v0, 10                    # exits program
	syscall


math:
	addi	$v0, $zero, 0	# r := 0
loop:
	mul        $t0,$v0,$v0	# t0 := r*r
	bgt		$t0,$a0, end	# if (r*r > n) goto end
	addi		$v0,$v0,1		# r := r + 1
	j		loop			# goto loop
end:
  addi		$v0,$v0,-1		# r := r - 1
	jr		$ra			# return with r-1 in $v0
