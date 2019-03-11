##BUbble Sort
#Quinton Cline

	.data

# Constant strings to be output to the terminal



linefeed:	.asciiz	"\n"
space: .asciiz " " # number seperator
Xarray: .word 20, 19, 18, 17, 16, 15 # elements in array
#Xarray: .word 14, -2, 3, 5, 9
Xsize:		.word 6


.text
.globl main
.globl compare
.globl swap
.globl printlist

###################################
###     Compare Subroutine		###
###################################

compare:
#Return $v1-  0-no swap   1-swap needed
lw $s0,0($a1)	#load the value of a1
lw $s1,0($a2)	#laod the value of a2

slt $v1,$s1,$s0      # checks if $a0 > $a1
#move $a0, $v1	# print number at current index
	#li $v0, 1		#load for syscall
	#syscall

jr $ra#goes back

###################################
###     Swap Subroutine			###
###################################
swap:
lw $s0,0($a1)	#load the value of a1
lw $s1,0($a2)	#laod the value of a2
sw	$s1,0($a1)	#swaps
sw	$s0,0($a2)	#swaps


jr $ra#goes back

###################################
###     Print Subroutine		###
###################################

printlist:
	li		$t7,0#counter 
	la $t3, Xarray # load array first index address
printLoop:
	beq $t7,$a3,printEnd
	
	lw $a0, ($t3)	# print number at current index
	li $v0, 1		#load for syscall
	syscall

	la $a0, space	# print space
	li $v0, 4		#load for syscall
	syscall

	addi $t7, $t7, 1 # loop counter++
	addi $t3, $t3, 4 #arraypointer ++ 
	j printLoop		 # loop
printEnd:
	jr $ra #goes back to where called+1 line



	#Registers
	#$t1--the start of the array(Do not change)------changed
	#$t2--size of the array (Do not change)-----------changed
	#$t3-- temp register used for walking in array
	#$t4-- counter for the outer loop
	#$t5-- counter for the inner loop
	#$t6-- temp register for comparisons

main: 
	lw $a3,Xsize	#loads the pointer of the array
	#jal printlist
	li $t4,0  
	li $t5,0

	la $a1,Xarray #the first number
	addi $a2,$a1,4 #the second number
loop1:
	
	beq	$a3,$t4,end
	addi $t4,$t4,1  #increment outer loop counter
	li $t5,1
	la $a1,Xarray #the first number
	addi $a2,$a1,4 #the second number
	loop2:

		beq	$a3,$t5,loopexit
		jal compare
		li $t6,0
		beq $t6,$v1,noswap	#checks if swap needed  0-no swap   1-swap needed
		jal swap		#jump and link to swap
		addi	$t5,$t5,1#increments the counter for the loop
		addi	$a1,$a1,4	#increments the pointer for the array
		addi	$a2,$a2,4	#increments the pointer for the array
		j	loop2
		
		noswap:
		
	

	loopexit:
	jal printlist
	#new line
	la $a0, linefeed	# print space
	li $v0, 4		#load for syscall
	syscall

j	loop1






end:
# All done, thank you!
	li	$v0,10			# code for exit
	syscall				# exit program
