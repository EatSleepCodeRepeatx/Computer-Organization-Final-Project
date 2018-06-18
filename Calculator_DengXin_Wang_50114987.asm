
.data

# prompt to read
num1:        .float 0.0
first:    .asciiz "<Any invalid input would be considered as zero>\nEnter first number : "
second:      .asciiz "<Any invalid input would be considered as zero>\nEnter second number: "
operation:    .asciiz "Input operation (1-4,1:+,2:-,3:*,4:\) : "
invalidInput:   .asciiz "Invalid operation input, enter new input \n"
result:    .asciiz "Result is : "
newInput:   .asciiz "\nDo you want to use the calculator again  (1:Yes, 2:No)   : "
invalidInputTwo:   .asciiz "Invalid operation input, enter new input (1:Yes, 2:No) : "
endingOutput: .asciiz "You choose to end the program, please close window\n"
newline:     .asciiz "\n"
    .globl    main

    .text

main:


loop:

# get first int
    li $v0, 4                    # system call code for printing string = 4
    la $a0, first                # load address of string to be printed into $a0
    syscall                      # call system to perform print operation


    li $v0, 5                    # get ready to read in number
    syscall                      # system waits for input

    move    $s0,$v0              # store first number in $s0

# get second int
    li $v0, 4                    # system call code for printing string = 4
    la $a0, second               # load address of string to be printed into $a0
    syscall                      # call system to perform print operation


    li $v0, 5                    # get ready to read in number
    syscall                      # system waits for input

    move    $s1,$v0              # store second number in $s1

# get operator
    operator_input:
    li         $v0, 4            # system call code for printing string = 4
    la         $a0, operation    # load address of string to be printed into $a0
    syscall                      # call system to perform print operation


    li         $v0, 5            # get ready to read in number
    syscall                      # system waits for input

    move        $s2,$v0          # store operator int in $s2

#compare $s2 and perform operation
    beq        $s2,1,add_op
    beq        $s2,2,sub_op
    beq        $s2,3,mult_op
    beq        $s2,4,div_op

    li         $v0, 4
    la         $a0, invalidInput
    syscall

    b        operator_input

add_op:
    add        $s2,$s0,$s1
    b        print_result
sub_op:
    sub        $s2,$s0,$s1
    b        print_result
div_op:
    div        $s0,$s1
    mflo        $s2
    b        print_result
mult_op:
    multu     $s0,$s1
    mflo        $s2
    b        print_result

print_result:
    li        $v0, 4              # system call code for printing string = 4
    la         $a0, result        # load address of string to be printed into $a0
    syscall                       # call system to perform print operation

    li          $v0,1               # system call code for printing integer = 1
    move        $a0,$s2
    syscall                       # call system to perform print operation

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
