section .text
    global atoi ; calls the function globally (for later use)

atoi:
    ; using EAX to accumlate the results
    xor eax, eax
    ; ECX will be used as an index (i) to walk through the string
    xor ecx, ecx

; start of a loop that determines our digits
.nextDigit:
    ; loading the next character out and zeroing our extra bits
    ; RDI holds the base pointer to the string
    ; RCX acts as an offset (i)
    movzx edx, byte [rdi + rcx]
    ;  used as a test for EOF character => \'0'
    test dl, dl ; a bitwise comparison for zero
    jz .done

    ; Converts ASCII digit to integer value
    sub edx, '0'    ; takes our value and subs it by 0x30 ('0')
    ; Multiply the current result by 10
    ; This shifts the value over to the left by 1 decimal place
    imul eax, eax, 10
    ; Add the new digit value to eax
    ; equivalent to: result += digit
    add eax, edx

    ; Increment the string index (move to the next character)
    inc rcx
    ; Go back to the start of the loop for the next character
    jmp .nextDigit

; return to calling if end of string is reached
.done:
    ret