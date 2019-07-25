# Name: Aaron VanderGraaff
# Section: 09
# Description: This program takes two integers as inputs: a number and a 
# divisor. The program returns the remainder of number/divisor.


# Java Solution: 
# int mod(int num, int div) {
#	return (num && (div-1));
# }

# MIPS Solution:

.globl welcome
.globl promptNum
.globl promptDiv
.globl answer

.data

welcome:
	.asciiz " This program mods a number with an even divisor \n\n "

promptNum:
	.asciiz " Enter a number: "

promptDiv:
	.asciiz "\n Enter an even divisor: "

answer:
	.asciiz "\n The modulus is: "

.text

main:
	ori $v0, $0, 4 # Display welcome message
	lui $a0, 0x1001 
	syscall
	
	ori $v0, $0, 4 # Display prompt
	lui $a0, 0x1001
	ori $a0, $a0,0x36 #53
	syscall 
	
	ori $v0, $0, 5 # Read number from user
	syscall
	add $s0, $v0, $0 # Store number into $s0
	
	ori $v0, $0, 4 # Display divisor prompt
	lui $a0, 0x1001
	ori $a0, $a0, 0x47 #53+25=78
	syscall

	ori $v0, $0, 5 # Read divisor from user
	syscall
	add $s1, $v0, $0 # Store divisor in $s1

	addi $s1, $s1, -1 # Subtract 1 from divisor
	and $s2, $s0, $s1 # And num, (div-1)
	
	ori  $v0, $0, 4 # Display the answer text
	lui $a0, 0x1001
	ori $a0, $a0, 0x61 #78+19=97
	syscall	

	ori $v0, $0, 1 # Display answer
	add $a0, $s2, $0 # Load answer into $a0
	syscall
	
	ori $v0, $0, 10 # Exit program
	syscall
