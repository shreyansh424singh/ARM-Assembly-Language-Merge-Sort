.global L1
.global L2
.text

@returns ans in r0. 0 -> equal, 1 -> str1, 2 -> str2

L1:       @r4, r5 has string pointers and initialy r3=0

	ldrb r0, [r4, r3]       @element at r3 position in string 1
	ldrb r1, [r5, r3]       @element at r3 position in string 2
	mov r2, #0              @r2 will have (0: if neither r0, r1 is null character) 
	                        @(1: if only r0 is null character)
	                        @(2: if only r1 is null character)
	                        @(3: if both r0, r1 is null character)
	cmp r0, #0              @check if r0 is null character
	addeq r2, r2, #1          @if null then add 1 to r2
    cmp r1, #0
	addeq r2, r2, #2          @if r1 null then add 2 to r2
    cmp r2, #1
	blt K1
	beq Pstr2               @if r2=1 then string 2 greater
	cmp r2, #2
	beq Pstr1               @if r2=2 then string 1 greater
	bgt Peq                 @if r2=3 then both equal
	mov pc, lr
	
  K1:   
  	add r3, r3, #1              @increment counter
  	cmp r0, r1                  @compare r0, r1
    beq L1                      @if equal check next element
	blt Pstr2                   @if less then String 2 greater
    bgt Pstr1                   @else then String 1 greater
	mov pc, lr
    	
    	
L2:                                 @for case insensitive (same as previous just the uppercase element is converted to lowercase element)
	ldrb r0, [r4, r3]
	ldrb r1, [r5, r3]
	
	cmp r0, #'Z
	bgt T
	cmp r0, #'A                 
	blt T
	add r0, r0, #32             @if r0 is in uppercase add 32 to it. To convert to lowercase
     T: cmp r1, #'Z
	bgt U
	cmp r1, #'A
	blt U
	add r1, r1, #32             @if r1 is in uppercase add 32 to it. To convert to lowercase

     U: mov r2, #0
	cmp r0, #0
	bne C
	add r2, r2, #1
     C: cmp r1, #0
	bne D
	add r2, r2, #2
     D: cmp r2, #1
	blt K2
	beq Pstr2               @if r2=1 then string 2 greater
	cmp r2, #2
	beq Pstr1               @if r2=2 then string 1 greater
	bgt Peq                 @if r2=3 then both equal
	mov pc, lr
	
  K2:   
  	add r3, r3, #1
  	cmp r0, r1
    beq L2
    blt Pstr2
    bgt Pstr1
    	mov pc, lr
    	

Pstr1:
	mov r0, #2
	mov pc, lr

Pstr2:
	mov r0, #1
	mov pc, lr
	
Peq:    
	mov r0, #0
	mov pc, lr
	
.end