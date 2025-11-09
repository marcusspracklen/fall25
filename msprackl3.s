# Program #3 finds the greatest common denominator of two numbers
# using Euclid's GCD algorithm
# Author: Marcus Spracklen
# Due 11/06/2025 (extended to 11/09/2025)
# Class: CS24

.text

main: 
    la a0, greeting     # load greeting
    sout a0             # print greeting

    la a0, prompt_m     # load prompt for input M
    sout a0             # print the prompt
    din a0              # grab the user input for M
    mv s0, a0           # move M into a saved register s0

    la a0, prompt_n     # load prompt for input N
    sout a0             # print prompt 
    din a1              # grab user input for N
    mv s1, a1           # move N into saved register s1

    mv a0, s0           # a0 == s0(M)
    mv a1, s1           # a1 == s1(N)

    jal ra, gcd         # call the gcd function

    mv t0, a0           # move the result of the function into temp register t0 to avoid it being messed with

    la a0, result       # load result label
    sout a0             # print result label

    mv a0, t0           # move result back into a0 to prepare for printing it

    dout a0             # print the result

    la a0, newline      # load newline
    sout a0             # print newline

    halt                # end program

#--------------------------------------------------------
# Function: gcd (M, N)
# Recusive implmentation of Euclid's algorithm
#   GCD(M, N) = M if N == 0
#   GCD(M, N) = GCD(N, M % N) (if N > 0)
#--------------------------------------------------------
gcd:
    addi sp, sp, -8     # allocate 8 bytes (our stack frame)
    sw ra, 4(sp)        # save return address

    beq a1, zero, base_case     # if N == 0 -> base_case (either is called when N is initially zero or when done with recusion)

    rem t0, a0, a1      # t0 = M % N this will be the new value of N for next call
    mv a0, a1           # a0 = N this will be the new M value for the next call/recursion 
    mv a1, t0           # a1 = M % N 
    jal ra, gcd         # recurse
    j done

base_case:
    nop                 # return M or our result if recursion has occured

done:
    lw ra, 4(sp)        # restore return address
    addi sp, sp, 8      # deallocate our stack frame
    jr ra               # return to caller

.data
greeting:   .string "Euclid's GCD alogorithm\n"
prompt_m:   .string "Enter first integer (M): "
prompt_n:   .string "Enter second integer (N): "
result:     .string "The GCD is: "
newline:    .string "\n"