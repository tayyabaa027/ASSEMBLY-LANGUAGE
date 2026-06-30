; =====================================================================
; PROGRAM INFORMATION 
; =====================================================================
; Program Name  : Single Character Input and Display
; Processor    : Intel 8086 Microprocessor
; Emulator     : EMU8086 (8086 Assembler and Microprocessor Emulator)
; Objective    : Practice MOV instruction by transferring character
;                from input register to output register
; =====================================================================
;
; -------------------------------
; INPUT – PROCESS – OUTPUT 
; -------------------------------
; Input   : One character entered from keyboard
; Process : Read character → store in register → display character
; Output  : Same character displayed on same line at next position
;
; -------------------------------
; REGISTERS USED 
; -------------------------------
; AX | Accumulator Register      | General purpose
; AH | Accumulator High Byte     | DOS function selection
; AL | Accumulator Low Byte      | Stores input character
; DX | Data Register             | Address holder for string
; DL | Data Low Register         | Stores character for output
; DS | Data Segment Register     | Points to data segment
;
; -------------------------------
; HOW TO RUN
; -------------------------------
; Compile → Emulate → Type a character → Press Enter
; =====================================================================

.MODEL SMALL                  ; SMALL memory model (one code, one data)

.STACK 100H                   ; Allocate stack of 256 bytes (100H)

.DATA                          ; Start of DATA segment
MSG DB 'ENTER A CHARACTER: $'  ; Message string ending with '$'

.CODE                          ; Start of CODE segment
MAIN PROC                     ; MAIN procedure begins (entry point)

    MOV AX, @DATA              ; Move DATA segment address into AX
    MOV DS, AX                 ; Move AX value into DS (initialize data segment)

    MOV AH, 09H                ; AH = 09H (DOS function to display string)
    LEA DX, MSG                ; Load Effective Address of MSG into DX
    INT 21H                    ; Call DOS interrupt to display message

    MOV AH, 01H                ; AH = 01H (DOS function to input character)
    INT 21H                    ; Read character from keyboard into AL

    MOV DL, AL                 ; Move input character from AL to DL
    MOV AH, 02H                ; AH = 02H (DOS function to display character)
    INT 21H                    ; Display character on screen

    MOV AH, 4CH                ; AH = 4CH (DOS function to terminate program)
    INT 21H                    ; Terminate program execution

MAIN ENDP                     ; End of MAIN procedure
END MAIN                      ; End of program
