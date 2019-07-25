# Name: Aaron VanderGraaff
# Section: 09
# Description: This program takes a 32-bit unsigned number in decimal  and 
# reverses its order in binary. It then displays the answer in decimal.

# Java Solution:
# int reverse(int num) { 
#	int result = 0;
#	int bitNum = 1;
#	int temp;
#	for (int i=0; i<32; i++) {
#		temp = bitNum && num; 
#		if (temp!=0) {
#			result += 1;
#		}
#		bitNum = bitNum*2;	
#		result = result*2;
#	}
#	return result;
# }

# MIPS Solution:

.globl welcome
.globl prompt
.globl answer
.globl loop
#.globl breakpoint

.data

welcome: .asciiz " This program reverses a 32 bit unisigned number in
 binary \n\n"


prompt: .asciiz " Enter a number: "

answer: .asciiz "\n The reversed value is: "

.text

main:
	ori $v0, $0, 4 # Display welcome message
	lui $a0, 0x1001 
	syscall
	
	ori $v0, $0, 4 # Display prompt
	lui $a0, 0x1001
	ori $a0, $a0, 0x3F #61
	syscall 
	
	ori $v0, $0, 5 # Read number from user
	syscall
	add $s0, $v0, $0 # Store number into $s0
	breakpoint:	
	and $s1, $s1, $0 # Initialize result
	and $s2, $s2, $0 # Initialize mask 
	addi $s2, $s2, 1
	and $s3, $s3, $0 # Initialize loop counter
	and $t1, $t1, $0 # Initialize loop end
	addi $t1, $t1, 31

	loop: 
		beq $t1, $s3, end # branch to end if counter==31
		and $t0, $s2, $s0 # temp = mask && num
		beq $t0, $0, zero # if temp is 0, don't add 1
		addi $s1, $s1, 1
		zero:
		sll $s2, $s2, 1 # increment mask (shift left)
		sll $s1, $s1, 1 # increment result (shift left)
		addi $s3, $s3, 1 # increment counter
		j loop # Jump back to loop
	end:
	
	ori  $v0, $0, 4 # Display the answer text
	lui $a0, 0x1001
	ori $a0, $a0, 0x51 #61+25=86
	syscall	

	ori $v0, $0, 1 # Display answer
	add $a0, $s1, $0 # Load answer into $a0
	syscall
	
	ori $v0, $0, 10 # Exit program
	syscall
