.data

	# prompt to read
num1:		.float 0.0
first:	.asciiz "\nEnter first input: "
second:  	.asciiz "\nEnter second input: "
result:	.asciiz "\nHamming distance is:"
fstr:		.asciiz "  "
sstr:		.asciiz "  "
newInput:          .asciiz "\nDo you want to run the program again  (1:Yes, 2:No)    : "
invalidInputTwo:   .asciiz "Invalid operation input, enter new input (1:Yes, 2:No) : "
endingOutput: .asciiz "You choose to end the program, please close window\n"

newline: 	.asciiz "\n"
	.globl	main

	.text

main:


loop:
# get first str
	li $v0, 4			# system call code for printing string = 4
	la $a0, first		# load address of string to be printed into $a0
	syscall			# call operating system to perform print operation

	la $a0,fstr		# initialize string buffer
	li $a1,3
	li $v0, 8			# get ready to read in string with length upto 2
	syscall			# system waits for input

# get second str
	li $v0, 4			# system call code for printing string = 4
	la $a0, second		# load address of string to be printed into $a0
	syscall			# call operating system to perform print operation


	la $a0,sstr		# initialize string buffer
	li $a1,3
	li $v0, 8			# get ready to read in string with length upto 2
	syscall			# system waits for input

# get ham distance
	li	$t5,0			# set initial ham distance
	la	$t0,fstr
	la	$t1,sstr
	lbu	$t2,0($t0)		# first char in first str
	lbu	$t3,0($t1)		# first char in second str
	beq	$t2,$t3,first_equal
	li	$t5,1

first_equal:
	lbu	$t2,1($t0)		# first char in first str
	lbu	$t3,1($t1)		# first char in second str
	beq	$t2,$t3,second_equal
	add	$t5,1
second_equal:
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
