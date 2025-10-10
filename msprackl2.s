# Program #2 finds a number of prime numbers n that the user
# is prompted to enter
# Author: Marcus Spracklen
# Due 10/10/2025
# Class: CS24


# a0 = n
# a1 = current number being tested 
# a2 = divisor for checking for primes 
# a3 = remainder from division


.text
main:
    la t0, input_prompt      # load t0 with input prompt
    sout t0                 # print input prompt
    din a0                  # grab user input

    addi a1, zero, 2        # intitilize a1 to 2 (first prime)

loop:
    beq a0, zero, done      # checks to see if the loop is complete (when a0 == 0)

    jal ra, test_prime      # call test_prime function

    bne a4, zero, prime     # prime was found print the prime

    addi a1, a1, 1          # test the next number
    j loop

prime:
    dout a1                 # print the prime we just found
    addi a1, a1, 1          # test the next number
    la t0, newline
    sout t0                 # print newline
    j loop

done:
    halt                    # end program

# -------------------------
# function: test_prime
# input: a1 = number to test
# output: returns a4 as 1 or 0 (true or false)
# uses: a2 (divisor), a3 (remainder)
# -------------------------
test_prime:
    addi a2, zero, 2          # make a2 = 2 (use for trial division by counting up and checking for whole numbers)

prime_check_loop:
    mul t1, a2, a2            # sqaure t1
    bgt t1, a1, is_prime      # if divisor^2 > number, its prime

    remu a3, a1, a2           # remainder = a1 % a2
    beq a3, zero, not_prime   # if divisible its not a prime

    addi a2, a2, 1            # divisor++
    j prime_check_loop

is_prime:
    addi a0, a0, -1           # take away 1 from n
    addi a4, zero, 1          # prime found is true
    ret

not_prime:
    addi a4, zero, 0          # prime found false
    ret                       # no prime found

.data
input_prompt:    .asciz "Please enter the number of prime numbers you want found (please input a whole number greater than 0): "
newline:         .asciz "\n"
