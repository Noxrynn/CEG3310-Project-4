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
