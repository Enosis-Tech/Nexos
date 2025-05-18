IFNDEF __ISC_INC__
__ISC_INC__ = 1


MACRO int number

    if number == #10

        rst     #10

    else

        call    number * #10

    Endif

ENDM


ENDIF