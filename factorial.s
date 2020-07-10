.text

mystring: .asciz "Assignment 4: factorial\n"

formatstr: .asciz "%ld"
formatstr2: .asciz "%ld\n"

.global main

inout:
            pushq %rbp              # push the base pointer
            movq %rsp, %rbp         # copy stack pointer to %rbp

            subq $8, %rsp           # reserve stack space for variable
            leaq -8(%rbp), %rsi     # load address of stack var in rsi
            movq $formatstr, %rdi   # load argument of scanf
            
            movq $0, %rax           # no vector registers in use of scanf
            call scanf

            movq -8(%rbp), %rsi     # move a return value into rsi
            movq $0, %rax           
            call factorial
            movq %rax, -8(%rbp)    

            movq $0, %rax           # no vector registers in use
            movq -8(%rbp), %rsi     # move a return value into rsi

            movq %rbp, %rsp         # clear local variables from stack
            popq %rbp               # restore the base pointer

            ret                     # return from the subroutine

factorial:
            pushq %rbp              # push the base pointer
            movq %rsp, %rbp         # copy stack pointer to %rbp

            cmpq $1, %rsi           # check if the number in %rdi is equal to 1
            je ifcode               # if rdi = 1, jump to ifcode ifcode and return 1
            jmp elsecode            # if rdi rdi != 1, jump to elsecode

ifcode:
            movq $1, %rax           # return 1
            jmp factendcode         # end subroutine

elsecode:
            pushq %rsi              # save number value
            subq $1, %rsi           # reduce number value by 1
            call factorial          # call factorial subroutine recursively

            popq %rsi               
            mulq %rsi               # multiply number with previous number

            jmp factendcode         # end subroutine

factendcode:
            movq %rbp, %rsp         # clear local variables from stack
            popq %rbp               # restore the base pointer

            ret                     # return from the subroutine

main:
            movq %rsp, %rbp         # copy stack pointer to %rbp

            mov $0, %rax
            movq $mystring, %rdi    # load address of a string 
            call printf             # print mystring

            call inout              # call inout subroutine

            mov $0, %rax            # no vector registers in use of printf
            movq $formatstr2, %rdi  # load address of string
            call printf             # print formatstr2

end:
            mov     $0 , %rdi       # load program exit code
            call    exit            # exit the program
