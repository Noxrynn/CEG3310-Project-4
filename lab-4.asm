MAIN
        ;Initialize pointers
        LD   R6, STACK_BASE
        AND  R5, R5, #0

        ;Push arraySize 
        LD   R0, ARRAY_SIZE
        ADD  R6, R6, #-1
        STR  R0, R6, #0

        ;Push the ADDRESS of the array
        LEA  R0, ARRAY
        ADD  R6, R6, #-1
        STR  R0, R6, #0

        ;Call sumOfSquares(array, arraySize)
        JSR  SUM_OF_SQUARES

        ;Remove the two arguments from the stack
        ADD  R6, R6, #2

        ;Push the final result so it remains on the stack at HALT
        ADD  R6, R6, #-1
        STR  R0, R6, #0

        HALT

SUM_OF_SQUARES
        ; ----- Function prologue -----
        ; Save the return address and previous frame pointer
        ADD  R6, R6, #-1
        STR  R7, R6, #0

        ADD  R6, R6, #-1
        STR  R5, R6, #0

        ; Establish this function's frame pointer
        ADD  R5, R6, #0

        ; Allocate and initialize sum = 0
        ADD  R6, R6, #-1
        AND  R0, R0, #0
        STR  R0, R6, #0

        ; Allocate and initialize counter = 0
        ADD  R6, R6, #-1
        AND  R0, R0, #0
        STR  R0, R6, #0


SUM_LOOP
        ; Check whether counter < arraySize
        LDR  R0, R5, #-2       ; R0 = counter
        LDR  R1, R5, #3        ; R1 = arraySize

        ; Calculate counter - arraySize
        NOT  R2, R1, #0
        ADD  R2, R2, #1
        ADD  R2, R0, R2

        ; If counter >= arraySize, exit the loop
        BRzp SUM_DONE

        ; Read array[counter]
        LDR  R1, R5, #2        ; R1 = array's base address
        LDR  R2, R5, #-2       ; R2 = counter
        ADD  R1, R1, R2        ; Address of array[counter]
        LDR  R0, R1, #0        ; R0 = array[counter]

        ; Push the current element as square's argument
        ADD  R6, R6, #-1
        STR  R0, R6, #0

        ; Call square(array[counter])
        JSR  SQUARE

        ; Remove the argument pushed for square
        ADD  R6, R6, #1

        ; Add square's result to the running sum
        LDR  R1, R5, #-1       ; R1 = current sum
        ADD  R1, R1, R0        ; sum = sum + square result
        STR  R1, R5, #-1

        ; Increment counter
        LDR  R0, R5, #-2
        ADD  R0, R0, #1
        STR  R0, R5, #-2

        ; Repeat the loop
        BRnzp SUM_LOOP

SUM_DONE
        ; Return the sum in R0
        LDR  R0, R5, #-1

        ; ----- Function epilogue -----
        ; Discard local variables and return to the caller
        ADD  R6, R5, #0        ; Reset SP to the frame
        LDR  R5, R6, #0        ; Restore previous FP
        ADD  R6, R6, #1
        LDR  R7, R6, #0        ; Restore return address
        ADD  R6, R6, #1        ; Remove saved return address

        RET