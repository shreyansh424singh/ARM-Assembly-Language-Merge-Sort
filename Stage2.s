.global A
.global length
.global remdup
.extern L1
.extern L2
.text

@r6, r7 have size of list1 and list2
@r0 has pointer to list 1
@r1 has pointer to list 2
@r12 has pointer to list where sorted pointers will be stored
@r11 has comparison mode


@take pointer to a list of pointers in r3
@makes no change to r3
@return list length in r4
length:
	stmfd   sp!, {r5-r7, lr}
	mov r4, #0
st: 	
	ldr r5, [r3, r4, LSL #2]
	cmp r5, #0
	beq enl
	add r4, r4, #1
	bl st
enl:	ldmfd	sp!, {r5-r7,pc}


@sorts list without removing duplicates
A:	
	ldr r5, =str1
	str r0, [r5]
	ldr r5, =str2
	str r1, [r5]
    stmfd	sp!, {r0-r4, r8-r9,lr}
	mov r8, #0
	mov r9, #0

A1a:    
	ldr r4, =str1
	ldr r4, [r4]
	add r4, r4, r8, LSL #2
	ldr r4, [r4]
	ldr r5, =str2
	ldr r5, [r5]
	add r5, r5, r9, LSL #2
	ldr r5, [r5]
    
	mov r3, #0          @counter for comparing
					   @cmp_mode = 1 means case sensitive
	cmp r11, #1        @check compare
	bleq L1
	blne L2

A2c:cmp r0, #1           
	bllt S0
	bleq S1
	blgt S2
	
	cmp r8, r6   @check if all elements of list 1 are sorted
	bleq E2
	cmp r9, r7    @check if all elements of list 2 are sorted
	bne A1a
	bleq E1
	ldmfd	sp!, {r0-r4, r8-r9,pc}

@stores in ans list both the elements as they are equal no duplicates are not to be removed
@r4, r5 are pointers to strings and r8, r9 are counters   
   S0: 
    stmfd sp!, {r6-r7,lr}
	str r4, [r12], #4
   	add r8, r8, #1
	str r5, [r12], #4
   	add r9, r9, #1
    ldmfd sp!, {r6-r7,lr}
   	mov pc, lr

@stores in ans list one element in list 1	
@r4 is pointer to string and r8 is counter
   S1:  
    stmfd sp!, {r6-r7,lr}
	str r4, [r12], #4
   	add r8, r8, #1
    ldmfd sp!, {r6-r7,lr}
   	mov pc, lr

@stores in ans list one element in list 1
@r5 is pointer to string and r9 is counter	
   S2:  
    stmfd sp!, {r6-r7,lr}
	str r5, [r12], #4
   	add r9, r9, #1
    ldmfd sp!, {r6-r7,lr}
   	mov pc, lr

	
   E1:  @when string 2 has no element left just store string 1
   	@r8 has from where to store. r6 has till where	
	stmfd	sp!, {r1,lr}
ZE1:	
	cmp r8, r6
	bge ter1
	ldr r4, =str1
	ldr r4, [r4]
	add r4, r4, r8, LSL #2
	ldr r4, [r4]

	str r4, [r12], #4
	add r8, r8, #1
	b ZE1
ter1: ldmfd	sp!, {r1,pc}
  	mov pc, lr	
	
	
E2:  @when string 1 has no element left just store string 2
   	@r9 has from where to store r7 has till where	
	stmfd	sp!, {r1,lr}
ZE2:	cmp r9, r7
	bge ter2
	ldr r4, =str2
	ldr r4, [r4]
	add r4, r4, r9, LSL #2
	ldr r4, [r4]
E2a:	
	str r4, [r12], #4
	add r9, r9, #1
	b ZE2
ter2: 
	ldmfd	sp!, {r1,pc}
  	mov pc, lr


@r9 has list pointer
@r1 has length
@r11 has comparison mode
@r6 initially 0
@r7 will have temporary memory
@stores final in original list 
remdup:
	stmfd	sp!, {r4-r8,lr}
	cmp r1, #0
	beq rdend
	mov r6, #0
	sub r10, r1, #1
	ldr r8, =temp
rd: 
	cmp r6, r10
	bge rde
	ldr r4, [r9, r6, LSL #2]
	add r6, r6, #1
	ldr r5, [r9, r6, LSL #2]
	mov r3, #0          @counter for comparing	
	cmp r11, #1        @check compare, cmp_mode = 1 means case sensitive
	bleq L1
	blne L2           
	
rdc:cmp r0, #0      @if ith and i+1 th elelment are equal
	beq rd
	str r4, [r8], #4
	b   rd
rde:
	ldr r4, [r9, r6, LSL #2]
	str r4, [r8], #4
	mov r4, #0
	str r4, [r8], #4
	@store from temp to original space
	mov r6, #0
	add r10, r10, #1
	ldr r8, =temp
rdl:
	ldr r5, [r8]
	str r5, [r9], #4
	add r8, r8, #4
	add r6, r6, #1
	cmp r6, r10
	blt rdl

rdend:	
	ldmfd	sp!, {r4-r8,pc}

.data
	str1: .space 8
	str2: .space 8
	temp: .space 512
.end