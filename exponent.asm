# Name: Aaron VanderGraaff
# Section: 09
# Description: This program raises x to the power of y.

# Java Solution: 
# int exponent(int x, int y) {
#	int prev_result;
#	int result = 1;
#	for(int i=0; i<y; i++) {
#		prev_result = result;
#		for(int j=0; j<x; j++) {
#			result += prev_result;
#		}
#	}
# } 

# MIPS Solution:

.globl welcome
.globl answer
.globl loop1

.data

welcome:
	.asciiz " This program takes raises x to the power of y. \n\n "

promptX:
	.asciiz " Enter x: "

promptY:
	.asciiz "\n  Enter y: "

answer:
	.asciiz "\n x^y is: "

.text

main:

	ori $v0, $0, 4 # Display welcome message
	lui $a0, 0x1001 
	syscall
	
	ori $v0, $0, 4 # Display prompt for x
	lui $a0, 0x1001
	ori $a0, $a0,0x34 #54
	syscall 
	
	ori $v0, $0, 5 # Read number from user
	syscall
	add $s0, $v0, $0 # Store x into $s0
	
	ori $v0, $0, 4 # Display prompt for y
	lui $a0, 0x1001
	ori $a0, $a0, 0x3F #53+10=63
	syscall

	ori $v0, $0, 5 # Read y from user
	syscall
	add $s1, $v0, $0 # Store y into $s1
	
	and $t0, $t0, $0 # initialize counter i
	and $t1, $t1, $0 # initialize counter j
	#addi $t1, $t1, 1
	and $s2, $s2, $0 # initialize result
	addi $s2, $s2, 1

	loop1: 
		beq $t0, $s1, end1
		add $t2, $0, $s2 # initialize prev result 
		loop2:
			# This loop multiplies result by x
			addi $t1, $t1, 1 # increment counter j
			beq $t1, $s0, end2 # if counter is x, end loop
			add $s2, $s2, $t2 # result += result 
			j loop2
		end2:
		and $t1, $t1, $0 # reinitialize counter j
		addi $t0, $t0, 1 # increment counter i
		j loop1
	end1:

	
	ori  $v0, $0, 4 # Display the answer text
	lui $a0, 0x1001
	ori $a0, $a0, 0x4C #63+11=74
	syscall	

	ori $v0, $0, 1 # Display answer
	add $a0, $s2, $0 # Load answer into $a0
	syscall
	
	ori $v0, $0, 10 # Exit program
	syscall

