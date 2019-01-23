.data
	message1: .asciiz " Max_Min_Program \n "

	message2: .asciiz "Fill In The List with 15 Number \n"

	message3: .asciiz  "Welcome \nTo Get The Max Number in The List Press : 1\nTo Get The Min Number in The List Press : 2\nTo Exit The Program Press : 0 \n"

      	message4: .asciiz "Please Enter A Valid Option Number : \n"

      	message5: .asciiz "Max Value := "

      	message6: .asciiz "Min Value := "

      	message7: .asciiz "\n"

      	byemessage: .asciiz "Have A Nice Day \n"

      	test: .asciiz "Exit max\n"

      	test2: .asciiz "Exit min\n"

      	gomax: .asciiz "going to max\n"

      	print:.asciiz "Enter Value: "

      	array: .word 0:15

.text
	main:					#Main Function
	 li 	$v0 , 4  		#Tell the system that it will print a string
	 la 	$a0 , message1	#load message1(Max_Min_program)
	 syscall 				#go print message1
	 li $v0 , 4 			#Tell the syscall that it will print a string
	 la $a0 , message2      #load message2(Fill Array )
	 syscall 				#go print message2

	 li $v0 , 4				#Tell the system that it will print a string
	 la $a0 , print			#load print message (Enter value)
	 syscall				#go print "print" message

	 li $v0 , 5             #Tell the system that it will scan int
	 syscall 				#go to scan integer

	 move $t1 ,$v0			#move the value from v0 to temprory(t1)
	 la $t2,array  			#load array to temprory (t2)
	 sw $t1,0($t2) 			#add 0 to t2 and store it into t1
	 addi $t2,$t2,4    		#increment t2 with 4
	 andi $t3 ,$t3 ,0		#make t3 = 00000000
	 addi $t3,$t3,0

	 li $v0 , 4				#Tell the system that it will print a string
	 la $a0 , message7		#load message7 (\n)
	 syscall				#go print message7

	 while:					#start whill loop
		beq $t3,14,next		#go to next label if t3 is equal to 14
		li $v0 , 4			#Tell the system that it will print a string
		la $a0 , print		#load print message (Enter value)
		syscall				#go print "print" message
		li $v0 , 5          #Tell the system that it will scan int
		syscall 			#go to scan integer
	 	move $t1 ,$v0		#move the value from v0 to temprory(t1)
		sw $t1,($t2)		#store t2 into t1
	 	addi $t2,$t2,4		#increment t2 with 4
	 	addi $t3,$t3,1		#increment t3 with 1
	 	li $v0 , 4			#Tell the system that it will print a string
	 	la $a0 , message7	#load message7 (\n)
	 	syscall				#go print message7
	 	j while
 #--------------------------------------------------------------------------------------------------block1

	 next:
	 li $v0,4               #Tell the system that it will print a string
	 la $a0,message3        #load message3 ("contain options to choose")
	 syscall                #go print message3

	 li $v0,5               #Tell the system that it will scan int
	 syscall                #go to scan integer
	 move $t0,$v0           #move the value from v0 to temprory(t0)



	 while_1:               # start while_1 loop
	 	beq $t0,0,exit      #branch to exit if temprory equal 0
	 	beq $t0,1,max       #branch to max if temprory equal 1
	 	beq $t0,2,min       #branch to min if temprory equal 2
	 	bne $t0,0,go_back1  #branch to go_back1 if temprory not equal 0
	 	bne $t0,1,go_back1  #branch to go_back1 if temprory not equal 1
	 	go_back1:           # start go_back1
	 	jal go_back         # jump to go_back  and stores the return address in $31 ($ra)
	 	move $t0,$v1        #move the value from v1 to temprory(t0)
	 	b while_1
	 #--------Max---------------------------------------------
	 	max:
	 	    jal maxf
	 	move		$a1,$v1			 #store max value which returned by maxf in $a1 ' $a1 = $v1 = max '
	 	li		$v0,4			 #preper system to print string '$v0 = 4'
	 	la		$a0,message5		 #load message5 'max value := ' to $a0 be printed when call system ' $a0 = message5 '
	 	syscall					 #call system to print
	 	li		$v0 ,1		         #preper system to print integer ' max value' '$v0 = 1'
	 	move		$a0,$a1			 #store max value in $a0 to be printed $a0 = $a1 = max '
	 	syscall					 #call system to print
	 	li		$v0,4			 #preper system to print string '$v0 = 4'
	 	la		$a0,message7		 #load message7 '\n' to $a0 be printed when call system ' $a0 = message7 '
	 	syscall					 #call system to print
	 	li		$v0 ,4			 #preper system to print string '$v0 = 4'
	 	la		$a0 ,message3 		 #load message3'welcome menue' to $a0 be printed when call system ' $a0 = message7 '
	 	syscall					 #call system to print
	 	li		$v0 ,5			 #preper system to read integer '$v0 = 5'
	 	syscall					 #call system to read
	 	move		$t0,$v0			 #stroe scaned option value to $t0
	 	j while_1				 #jumb to while_1 loop to cheack option value again

	#-------Min----------------------------------------------------------
		min: 
	 	    jal minf				#jump to the (function)subroutine minf, it returns the value to $v1
	 	move  $a1,$v1				#store the min value returned from minf in $a1 to be printed
	 	li   $v0,4				#Telling the system it will print string
	 	la   $a0,message6 			#loading the promote message into $a0	
	 	syscall					#printing the promote message before the number
	 	li $v0 ,1				#Telling the system it will print integer
	 	move $a0,$a1				#preparing the min value to be printed in $a0
	 	syscall					#printing the min number
	 	li $v0,4				#Telling the system it will print string
	 	la $a0,message7				#loading the message (newline) into $a0 to be printed
	 	syscall					#printing the new line
	 	li $v0 ,4				#Telling the system it will print a string
	 	la $a0 ,message3			#loading the message (menu options) into $a0
	 	syscall					#printing the message
	 	li $v0 ,5				#Telling the system it will read an integer
	 	syscall					#getting the input from the keyboard and store it in $v0
	 	move $t0,$v0				#moving the option selected in $t0
	 	j while_1				#jumping to the menu selection agains


	go_back:
	   li $v0 ,4             #Tell the system that it will print a string
	   la $a0,message4       #load message4 (Please Enter A Valid Option Number : \n)
	   syscall               #print message4
	   li $v0,5              #Tell the system that it will scan integer
	   syscall               #scan integer
	   move $v1,$v0          #move the value from v0 to v1
	   jr $ra                #Jump to the address contained in register $ra

	exit:                    #Tell The system End of The Main  program
	 li $v0 ,4               #Tell the system that it will print a string
	 la $a0 ,byemessage      #load byemessage ("Have A Nice Day \n")
	 syscall                 #print byemessage
	 li $v0 ,10              #Tell The system that it will Exit
	 syscall                 #Exit From program




	maxf:
	lw $t4,array	#load first value in the array
	move $a1,$t4	#max value
	la $t4,array	#load address of array in t4
	andi $t5,$t5,0	#make t5 zero to make t5 count to compare with size of array
	loop_mx:
	    if1: beq $t5 ,15,Finish #compare if t5 is a count the branch to Finish
	   	continue:
	   	lw $s2,($t4)	#if max == Arr[iterator]		
	   	bge $s2,$a1,replace			
	   	inc:			#increment iterator and start the next iteration
	   	addi $t5,$t5,1	#incerment t5 to the next count(byte)
	   	addi  $t4,$t4,4	#incerment t4 to the next element (word) 
	   	j loop_mx		#jump to start the loop again
	   	replace:
	   	move $a1,$s2	#move s2to a1 ,because the element is greater than the local max
	   	j inc			#then jump to fuction inc
	       	Finish:
	     	move $v1,$a1 	#move a1  the max value to  v1
	     	li $v0 ,4		#Tell the system i will print string 
	     	la $a0,test	#load address of test to be printed into a0
	     	syscall
	     	jr $ra		#jump register

	minf:
	lw $t4,array	#load first value into the array
	move $a2,$t4	#min value
	la $t4,array	#array
	andi $t5,$t5,0	#iterator
	loop_min:
	    if2: beq $t5 ,15,go_to_main_1	#if iterator == 15 branch to main lable 
	   else2: bne $t5 ,15,continue_1
	   	continue_1:
	   	lw 		$s4,($t4)
	   	ble 		$s4,$a2,replace_1			#if min >= Arr[iterator] go to replace
	   	increment:						#else increment iterator 
	   	addi $t5,$t5,1
	   	addi  $t4,$t4,4
	   	j loop_min		#jump to start the loop again
	   	replace_1:		#swap the current min with Arr[iterator]
	   	move $a2,$s4
	   	j increment
	       	go_to_main_1:  		#go back to  main 
	     	move $v1,$a2
	     	li $v0 ,4
	     	la $a0,test2		#this message indicate the end of function
	     	syscall
	     	jr $ra			#return to saved address 


	#Exit The Program
	li $v0 , 10
	syscall
