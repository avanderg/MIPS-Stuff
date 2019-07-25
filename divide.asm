# Name: Aaron VanderGraaff
# Section: 09
# Description: This program divides a 64 bit unsigned number with a 31 bit 
# unisigned number. The divisor is guaranteed to be a power of 2.

# Java Solution:
# int divide(int high, int low, int div){
#	int temp;	
#	while(div != 0) {
#		(then shift up into low)	
#		temp = high && 1; (bitwise and...get the rightmost digit)
#		temp = temp * 2^31; (shift this bit all the way to the left)
#		low = low/2;
#		low += temp; (put this bit in the far left spot
#		
#		(now shift up to the right)
#		high = high/2;
#		
#		(We have successfully divided by 2, do this div times)
#		div = div/2;	
#	}
#}	 

# MIPS Solution:

.globl welcome
.globl promptUp
.globl promptLow
.globl answerUp
.globl answerLow

.data

welcome:
	.asciiz " This program divides a 64 bit unsigned number with 
 an even  31 bit unsigned number. The 64 bit dividend is 
 split into 2 32 bit unsigned numbers. \n\n"


promptUp:
	.asciiz " Enter the 32 bit upper dividend: "

promptLow:
	.asciiz "\n Enter the 32 bit lower dividend: "

promptDiv:
	.asciiz"\n Enter an even 31 bit divisor: "

answerUp:
	.asciiz "\n The upper quotient is: "

answerLow:
	.asciiz "\n The lower quotient is: "

.text

main:
	ori $v0, $0, 4 # Display welcome message
	lui $a0, 0x1001 
	syscall
	
	ori $v0, $0, 4 # Display prompt for upper dividend
	lui $a0, 0x1001
	ori $a0, $a0,0x99 
	syscall 
	
	ori $v0, $0, 5 # Read upper dividend from user
	syscall
	add $s0, $v0, $0 # Store upper dividend into $s0
	
	ori $v0, $0, 4 # Display prompt for lower dividend
	lui $a0, 0x1001
	ori $a0, $a0, 0xBD
	syscall

	ori $v0, $0, 5 # Read lower dividend from user
	syscall
	add $s1, $v0, $0 # Store lower dividend in $s1
	
	ori $v0, $0, 4 # Display prompt for divisor 
	lui $a0, 0x1001
	ori $a0, $a0, 0xE1 # 241
	syscall

	ori $v0, $0, 5 # Read divisor from user
	syscall
	add $s2, $v0, $0 # Store divisor in $s2

	#add $t0, $t0, $0 # initialize upResult
	#add $t1, $t1, $0 # initialize lowResult
	add $t2, $t2, $0 # initialize temp
	srl $s2, $s2, 1

	loop:
		beq $s2, $0, end
		andi $t2, $s0, 1 # take out the rightmost bit of high
		sll $t2, $t2, 31 # shift it all the way to the left
		srl $s1, $s1, 1  # shift low to the right 1 (divide by 2)
		add $s1, $s1, $t2 # add in temp

		srl $s0, $s0, 1 # shift high to the right once (divide by 2)
		
		# We have divided by 2, do this once for each power of div
		srl $s2, $s2, 1
		j loop
	end:
	
	
	ori  $v0, $0, 4 # Display the answer upper text
	lui $a0, 0x1001
	ori $a0, $a0, 0x102 
	syscall	

	ori $v0, $0, 1 # Display answer upper
	add $a0, $s0, $0 # Load answer upper  into $a0
	syscall
	
	ori  $v0, $0, 4 # Display the answer lower text
	lui $a0, 0x1001
	ori $a0, $a0, 0x11B 
	syscall	

	ori $v0, $0, 1 # Display answer lower 
	add $a0, $s1, $0 # Load answer lower  into $a0
	syscall
	
	ori $v0, $0, 10 # Exit program
	syscall
