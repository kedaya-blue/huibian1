/* store 
 * r0 src1
 * r1 step1
 * r2 src2
 * r3 step2
 * [sp, #56] dst
 * [sp, #60] step3
 * [sp, #64] width
 * [sp, #68] height
 */
 lt:
    push    {r4, r5, r6, r7, r8, r9, r10, fp, lr}
    sub     sp, sp, #20
    ldr     r4, [sp, #56] /* r4 <- dst */
    ldr     r5, [sp, #60] /* r5 <- step3 */ 
    ldr     r6, [sp, #68] /* r6 <- height */
    ldr     r7, [sp, #64] /* r7 <- width */
    sub     r1, r1, r7, lsl #2
    sub     r3, r3, r7, lsl #2
    sub     r5, r5, r7, lsl #2

start_loop:
    sub     r6, r6, #1
    cmp     r6, #0
    beq     end_loop

    ldr     r7, [sp, #64]
    sub     r7, r7, #8    /* r8 <- width - width_step */
    add     r7, r4, r4

start_loop1:
    cmp     r4, r7
    bgt     end_loop1

    vldr    d16, [r2] /* d16 <- *src2 */
    vldr    d17, [r0] /* d17 <- *src1 */
    vcgt.s32        d16, d16, d17
    vmov.32 r9, d16[0]
    vmov.32 r10, d16[1]
    cmp     r9, #0
    movne   r9, #255
    moveq   r9, #0
    cmp     r10, #0
    movne   r10, #255
    moveq   r10, #0
    strb    r9, [r4]
    strb    r10, [r4, #4]

    add     r7, r7, #8
    add     r0, r0, #8
    add     r2, r2, #8
    add     r4, r4, #8
    b       start_loop1

end_loop1:
    add     r7, r7, #8

start_loop2:
    cmp     r4, r7
    bge     end_loop2

    ldr     r9, [r0]
    ldr     r10, [r2]
    cmp     r9, r10
    movne   r9, #255
    moveq   r9, #0
    strb    r9, [r4]

    add     r0, r0, #4
    add     r2, r2, #4
    add     r4, r4, #4

end_loop2:

    add     r0, r0, r1, lsl #2 /* src1 += step1 */
    add     r2, r2, r3, lsl #2 /* src2 += step2 */
    add     r4, r4, r5, lsl #2 /* dst += step3 */
    b       start_loop

end_loop:
    add     sp, sp, #20
    pop     {r4, r5, r6, r7, r8, r9, r10, fp, lr}
    bx      lr
