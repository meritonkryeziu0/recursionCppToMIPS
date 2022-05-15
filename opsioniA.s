.text
.globl main

main:
	addi $a1, $zero, 20				#int test = 4

printFun:
	addi $sp, $sp, -8				#decrement stack pointer 2*4 to store $ra and $a1
	sw $ra, 4($sp)
	sw $a1, 0($sp)

	slti $t0, $a1, 1 				#if test<1
	beq $t0, $zero, unravel			#jump to start popping and printing arguments from stack
	
	addi $sp, $sp, 8
	jr $ra

unravel:							#cout << test << " ";
	move $a0, $a1					#print argument
	li $v0, 1
	syscall

	li $a0, ' '						#print space
	li $v0, 11
	syscall

	addi $a1, $a1 -1				#test--


	jal printFun					#printFun(test - 1); // statement 2

	lw $a1, 0($sp)					#pop argument and return address
	lw $ra, 4($sp)
	addi $sp, $sp, 8
									#cout << test << " ";
	move $a0, $a1					#print argument
	li $v0, 1
	syscall

	li $a0, ' '						#print space
	li $v0, 11
	syscall


	jr $ra 							#jump to return address

exit:
	li $a0, 10
	syscall

# #include <iostream>
# using namespace std;
# void printFun(int test){
#     if (test < 1)
#         return;
#     else{
#         cout << test << " ";
#         printFun(test - 1); // statement 2
#         cout << test << " ";
#         return;
#     }
# }
# // Driver Code
# int main(){
#     int test = 4;
#     printFun(test);
# }