.extern mergesort
.extern input_number
.extern input_str_list
.extern output_string
.extern output_number
.extern output_new_line
.extern length
.text

main:
    ldr r0, =msg1 
	bl output_string
    bl input_number       @input list size
    mov r5, r0

    cmp r5, #40          
    ldr r0, =msg7
    blge output_string
    blge ee

mt3:
    ldr r0, =msg2 
	bl output_string
    ldr r0, =mainstr
    ldr r4, =mainpoi
    bl input_str_list      @input list

    ldr r0, =msg4
	bl output_string
    bl input_number         @input comparison mode
    mov r10, r0
    ldr r0, =cmpmain
    str r10, [r0]

    @call merge sort
    mov r11, #0
    sub r12, r5, #1
    ldr r2, =mainpoi
    bl mergesort

	ldr r0, =msg5
	bl output_string
    bl input_number          @input duplicate or not
    mov r1, r5
    ldr r11, =cmpmain
    ldr r11, [r11]
    ldr r9, =mainpoi
    cmp r0, #1
    bne mmm
    bl remdup               @function to remove duplicates

mmm:
    ldr r3, =mainpoi
    bl length               @returns length in r4
    ldr r0, =msg3
	bl output_string
    bl print_list
ee: mov r0, #0x18
    swi 0x123456

@print final ans list
@r4 has total size of list
@r10 is initially 0
@r4 set already
print_list:
	stmfd	sp!, {r8,lr}
	mov r10, #0
PL:	ldr r1, =mainpoi
	add r1, r1, r10, LSL #2
	add r10, r10, #1
	ldr r0, [r1, #0]
	cmp r0, #0
	beq PLl
	bl output_string
	bl output_new_line
	cmp r10, r4
	blt PL
PLl:	ldmfd	sp!, {r8,lr}
	mov pc, lr 


.data
    cmpmain: .space 4
    mainstr: .space 512
    mainpoi: .space 512
    msg1: .asciz "Enter size of list\n\0"
    .align 4
    msg2: .asciz "Enter elements of list\n\0"
    .align 4
    msg3: .asciz "\nSorted list:\n\0"
    .align 4
    msg4: .asciz "Enter 1 for case sensitive, else it will be case insensitive \n\0"
    .align 4
    msg5: .asciz "Enter 1 to remove duplicate else it will not remove duplicate\n\0"
    .align 4
    msg6: .asciz "Size of sorted list:\0"
    .align 4
    msg7: .asciz "Invalid Input\n\0"
    .align 4

.end