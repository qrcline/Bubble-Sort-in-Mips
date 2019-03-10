##BUbble Sort
#Quinton Cline

	.data

# Constant strings to be output to the terminal



linefeed:	.asciiz	"\n"
space: .asciiz " " # number seperator
#Xarray: .word 20, 19, 18, 17, 16, 15 # elements in array
Xarray: .word 14, -2, 3, 5, 9
Xsize:		.word 5


.text


	#Registers
	#$t1--the start of the array(Do not change)
	#$t2--size of the array (Do not change)
	#$t3-- temp register used for walking in array
	#$t4-- counter for the outer loop
	#$t5-- counter for the inner loop
	#$t6-- temp register for comparisons

main: 
	lw		$t1,Xarray	#loads the pointer of the array
	la $a3, Xsize # loads address of array size
	lw $a3, 0($a3) # loads array size
	jal printlist
	
lA $a0, Xarray  
	lA $a1, Xsize

	li $t4,0

loop1:
	
	beq	$t2,$t4,end
	loop2:
		jal compare
		li $t6,0
		beq $t6,$vo,noswap	#checks if swap needed  0-no swap   1-swap needed
		jal swap		#jump and link to swap

		noswap:
		addi $t5,$t5,1  #increment inner loop counter


compare:
#Return $vo-  0-no swap   1-swap needed
lw $a0,$a0	#load the value of ao
lw $a1,$a1	#laod the value of a1
slt $v0,$a0,$sa1      # checks if $a0 > $a1
jr $ra#goes back


swap:
lw $a0,$a0	#load the value of ao
lw $a1,$a1	#laod the value of a1
li $v1,0 
addi $v1,$a0,0	#a0 into v1
li $v0,0 
addi $v0,a1,0	#a1 into v0

jr $ra#goes back





end:
# All done, thank you!
	li	$v0,10			# code for exit
	syscall				# exit program











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

	



# All done, thank you!
	li	$v0,10			# code for exit
	syscall				# exit program



