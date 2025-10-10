# Reads in two integers then calls a function to add the numbers
# then calls a function to subtract the numbers then calls a function 
# to multiply them then prints the output.
# Author: Marcus Spracklen
# Purpose: Week 6 Lab Hours
# Class: CS24


# I HAVEN'T GOTTEN NEGATIVE MULTIPLICATION WORKING YET

.text
main:
    din s0                  # read first number into s0
    din s1                  # read second number into s1

    mv a0, s0
    mv a1, s1
    jal ra, add_func        # call add_func
    mv t0, a0               # store the sum into t0

    la t1, sum              # load sum into t1
    sout t1                 # print t1

    dout t0                 # print the sum
    la t0, newline      
    sout t0                 # print newline

    mv a0, s0
    mv a1, s1
    jal ra, sub_func        # call sub func
    mv t1, a0               # store difference into t1

    la t0, difference       # load difference into t0
    sout t0                 # print t0

    dout t1                 # print the difference
    la t0, newline      
    sout t0                 # print newline

    mv a0, s0
    mv a1, s1
    jal ra, mul_func        # call the mul function
    mv t2, a0

    la t0, product          # load product into t0
    sout t0                 # print t0

    dout t2                 # print the product

    halt                    # end program

# -------------------------
# Functions
add_func:
    add a0, a0, a1          # a0 = a0 + a1
    ret

sub_func:
    sub a0, a0, a1          # a0 = a0 - a1
    ret 
    
mul_func:
    mv t0, a0               # t0 = x
    mv t1, a1               # t1 = y
    li a0, 0                # a0 = result = 0

    beq t0, x0, done        # if t0 == 0, answer will be zero done
    beq t1, x0, done        # if t1 == 0, answer will be zero done

#    addi t3, t3, 0         # make t3 0 for negative checker
#    bge t0, t3, neg_check  # if t0 <= t3 neg_check
#    bge t1, t3, neg_mul_2  # if t1 <= t3 neg_check 

loop:
    beq t1, x0, done        # if t1 == 0, done
    add a0, a0, t0          # result += x (adds x, y number of times)
    addi t1, t1, -1         # t1 -= t (loops y number of times so x is added that many times)
    j loop

#neg_check:
#    bge t1, t3, both_neg    # t1 <= t3 
#    neg t0, t3              # x0 - t0 strip t0 of negative sign
#    j neg_mul

#neg_mul:
#    beq t1, x0, done_2      # if t1 == 0, done
#    add a0, a0, t0          # result += x (adds x, y number of times)
#    addi t1, t1, -1         # t1 -= t (loops y number of times so x is added that many times)
#    j neg_mul

#neg_mul_2:
#    neg t1, t1              # strip t2 of its negative sign
#    j mul_stp_2

#mul_stp_2:
#    beq t1, x0, done_2      # if t1 == 0, done
#    add a0, a0, t0          # result += x (adds x, y number of times)
#    addi t1, t1, -1         # t1 -= t (loops y number of times so x is added that many times)
#    j mul_stp_2

#both_neg:
#    neg t0, t0              # x0 - t0 strip t0 of negative sign
#    neg t1, t1              # x0 - t1 strip t1 of negative sign
#    j loop

done:
    ret

#done_2:
#    neg a0, a0              # make t1 negative
#    ret
.data
newline:    .asciz "\n"
sum:        .asciz "The sum is: "
difference: .asciz "The difference is: "
product:    .asciz "The product is: "