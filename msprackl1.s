# Program #1 Repeatedly inputs integers, 
# stops when an input is zero and prints 
# the sum of the numbers and the max
# Author: Marcus Spracklen
# Due: 09/25/25
# Class: CS24

.text
main:
        addi x7, zero, 0     # zero sum counter

        la t0, input_promt   # load address into t0
        sout t0              # print t0

        din x5               # grab input

        beq x5, zero, done_2 # if x5 == zero then done_2

        mv x8, x5            # make the first input the current max 
        add x7, x5, x7       # add together the input value with the sum of all previous values

loop:
        la t0, input_promt  # load adress of a string into t0

        sout t0             # display the string whose adress is in t0
        la t0, buffer

        din x5              # input string to buffer

        beq x5, zero, done  # if x5 == zero then done

        add x7, x5, x7      # add together the input value with the sum of all previous values

        bge x8, x5, min     # if x5 >= x8 then make it new max
        mv x8, x5           # store the new max value in x8
min:
        j loop
done:
        la t0, sum_val      # load address to t0
        sout t0             # print t0

        dout x7             # print out x7 (sum of inputs)

        la t1, newline      # load address of newline
        sout t1             # print newline

        la t0, max_val      # load address to t0
        sout t0             # print t0

        dout x8             # print out x8 (max value of inputs)

        halt                # end program

done_2:

        la t0, no_input     # load address to t0
        sout t0             # print t0

        halt                # end program

.data
input_promt:         .asciz "Please input an integer!: "
sum_val:             .asciz "The sum of all inputs is: "
max_val:             .asciz "The max value was: "
newline:             .asciz "\n"
no_input:            .asciz "No input"
buffer:              .zero 128       #128 byte input buffer