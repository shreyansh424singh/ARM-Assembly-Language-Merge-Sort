.global mergesort
.global merge
.extern A
.text


@r11 has begin
@r12 has end
@r10 has comparison mode
@r2 has pointer to list
mergesort:
    ldr r0, =str3
    str r2, [r0]
    ldr r0, =cmp3
    str r10, [r0]

mrgs1:
    cmp r11, r12
    blt mcon
    mov pc, lr
mcon:
    stmfd   sp!, {r3-r10}
    mov r9, r11
    mov r10, r12
    mov r7, r12
    @calculate mid(r8) = begin + (end-begin)/2
    sub r8, r10, r9
    lsr r8, r8, #1
    add r8, r8, r9
    @call mergersort(begin, mid)
    mov r12, r8
    push {lr}
    bl mrgs1
    pop {lr}
    @call mergersort(mid+1, end)
    add r11, r8, #1
    mov r12, r7
    push {lr}
    bl mrgs1
    pop {lr}
    @r9 - begin, r8 - mid, r10 - end
    @call merge function
    push {lr}
    bl merge
    pop {lr}
    ldmfd   sp!, {r3-r10}
    mov pc, lr


@r9 has begin
@r8 has mid
@r10 has end
@r2 has pointer to list
merge:
    stmfd   sp!, {r0-r6}
    ldr r2, =str3
    ldr r2, [r2]
    sub r7, r10, r8
    add r8, r8, #1
    sub r6, r8, r9
    mov r0, r2
    add r0, r0, r9, LSL #2     @r0 will have pointer to list 1
    mov r1, r2
    add r1, r1, r8, LSL #2     @r1 will have pointer to list 2
    ldr r12, =temp
    push {lr}
    push {r11}
    ldr r11, =cmp3
    ldr r11, [r11]        @r11 will have comparison mode
    bl A
    pop {r11}
    pop {lr}

    @after merging sorted list will be in temp 
    @transfer it back to original location
    ldr r12, =temp       
    ldr r2, =str3
    ldr r2, [r2]
    add r2, r2, r9, LSL #2
trf:
    cmp r9, r10
    bgt mrgend
    ldr r0, [r12], #4
    str r0, [r2], #4
    add r9, r9, #1
    b trf

mrgend:
    ldmfd   sp!, {r0-r6}
    mov pc, lr

.data
	str3: .space 8
    cmp3:  .space 8
	temp: .space 512
.end