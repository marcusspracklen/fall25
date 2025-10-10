# Program #2 finds a number of prime numbers n (using brute force division) that the user
# is prompted to enter
# Author: Marcus Spracklen
# Due 10/10/2025
# Class: CS24

# a0 = return value from function 
# a1 = current number being tested 
# a2 = divisor for checking for primes 
# a3 = remainder from division
# a4 = n
# a5 = prime found counter

.text
main:
    la t0, input_prompt     # load t0 with input prompt
    sout t0                 # print input prompt
    din a4                  # grab user input

    beq a4, zero, done      # if user enters 0, end program

    addi a1, zero, 2        # initialize a1 to 2 (first prime)
    addi a5, zero, 0        # prime counter

loop:
    jal ra, test_prime      # call test_prime function

    bne a0, zero, prime     # prime was found print the prime

    addi a1, a1, 1          # test the next number
    j loop

prime:
    dout a1                 # print the prime we just found
    la t0, newline
    sout t0                 # print newline

    addi a5, a5, 1          # add one to prime found counter
    addi a1, a1, 1          # test the next number

    bne a5, a4, loop        # check if we have found the number of primes equal to n (if not loop)

done:
    halt                    # end program

# -------------------------
# function: test_prime
# input: a1 = number to test
# output: returns a0 as 1 or 0 (true or false)
# uses: a2 (divisor), a3 (remainder)
#
# N.B.
# Here's a simple optimization I found, where the sqareroot of the number we are testing is the number     
# we need to count the divisor up to, the reasoning behind this is that if a number isn't prime then it either has a whole square root (which    
# is then its factors and we will count to) or a number less than and one greater than that value of square root. Since we only need to find one factor 
# we get to only look at numbers less than the square root, effectively halfing the number of integers we need to check.
# I have not included this however since in the assignment it states that brute force division is required and I was
# unsure if this optimization violated the parameters of the assignment. I still wanted to inlcude the code since it's a 
# nice optimization to have if there is any further use for this code, and I thought it was cool.
# mul t1, a2, a2            # square t1 = a2
# bgt t1, a1, is_prime      # if divisor^2 > number, its prime
# -------------------------
test_prime:
    addi a2, zero, 2          # make a2 = 2 (use for trial division by counting up and checking for whole numbers)
    blt a1, a2, not_prime     # if a1 < a2, a0 = 0 (for safety to avoid an infinite loop)

prime_check_loop:
    beq a2, a1, is_prime      # our divisor has reached the number being tested meaning without having a remainder of 0 meaning it's prime
    remu a3, a1, a2           # remainder = a1 % a2
    beq a3, zero, not_prime   # if divisible its not a prime

    addi a2, a2, 1            # divisor++
    j prime_check_loop

is_prime:
    addi a0, zero, 1          # prime found is true
    ret

not_prime:
    addi a0, zero, 0          # prime found false
    ret                       # no prime found

.data
input_prompt:    .asciz "Please enter the number of prime numbers you want found (please input a whole number greater than 0): "
newline:         .asciz "\n"
