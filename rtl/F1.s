init:
    addi s1, zero, 0x1      /* trigger destination set as 1 */
    addi s2, zero, 0xff     /* light destination set as 0xff */
    addi s3, zero, 0x8      /* regular delay set as 0x3 */
    addi a3, zero, 0x7f     /* the initial value of lfsr */

rst:
    nop
    nop
    addi a0, zero, 0x0      /* a0 is output */
    addi a4, zero, 0x0      /* a4 is increment of light */
    addi t0, zero, 0x0      /* t0 is trigger */

mainloop:
    nop
    nop
    beq  t0, s1, light_up   /* trigger? */ 
    srli t1, a3, 2          /* LFSR */     
    nop
    nop
    nop
    andi t1, t1, 0x1
    nop
    nop
    nop                     
    srli t2, a3, 6  
    nop
    nop
    nop                        
    andi t2, t2, 0x1
    nop
    nop
    nop                     
    xor t1, t1, t2         /* Generate new last bit */                
    nop
    nop
    nop
    andi t2, a3, 0x3f         
    nop
    nop
    nop
    slli t2, t2, 1          /* Shift old bits */                
    nop
    nop
    nop
    add t1, t1, t2          /* Add two segments */                
    nop
    nop
    nop
    andi a3, t1, 0x7f       /* Return results */              
    jal  ra, mainloop       /* Loop */

light_up:
    nop
    nop
    jal  ra, lightdelay     /* add const delay */
    nop
    nop
    nop 
    slli t1, a0, 0x1        /* shift left temp bits */
    nop
    nop
    addi a0, t1, 0x1        /* add 1 to shifted temp bits */
    nop
    nop
    bne  a0, s2, light_up   /* loop only if not all lights are on */

final_random:
    nop
    nop
    beq  a4, a3, rst
    nop
    nop
    addi a4, a4, 0x1        /* inc delay */
    jal  ra, final_random   /* run until delay counted down */

lightdelay: 
    nop
    nop
    addi  a1, a1, 0x1       /* inc count */
    nop
    nop
    nop
    bne   a1, s3, lightdelay/* run until delay counted down */
    nop
    nop
    addi  a1, zero, 0x0     /* reset count */
    RET
