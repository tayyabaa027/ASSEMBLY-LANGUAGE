; =====================================================================
; PROGRAM INFORMATION
; =====================================================================
; Program Name  : Sum of Two Decimal Digits
; Processor     : Intel 8086 Microprocessor
; Emulator      : EMU8086 (8086 Assembler and Microprocessor Emulator)
; Interrupt     : INT 21H (Interrupt 21H – DOS Service Handler)
; =====================================================================
; Objective     : 
;                 1. Display question mark "?"
;                 2. Accept two decimal digits from keyboard
;                 3. Convert ASCII to numeric values
;                 4. Add the digits (sum < 10)
;                 5. Display formatted result message with sum
; =====================================================================
;
; -------------------------------
; INPUT – PROCESS – OUTPUT
; -------------------------------
; Input   : Two decimal digits entered from keyboard (e.g., 2 and 7)
;
; Process : 
;           • Display prompt "?"
;           • Read first digit using DOS function 01H
;           • Read second digit using DOS function 01H
;           • Convert ASCII → Numeric (Subtract 30H)
;           • Perform addition using ADD instruction
;           • Convert Numeric → ASCII (Add 30H)
;           • Display complete formatted message
;
; Output  : THE SUM OF 2 AND 7 IS 9
;
; -------------------------------
; REGISTERS USED
; -------------------------------
; AX | Accumulator Register (16-bit) | Main arithmetic & data transfer register
; AH | Accumulator High Byte (8-bit) | Stores DOS function number
; AL | Accumulator Low Byte (8-bit)  | Stores input digit & sum result
; BX | Base Register (16-bit)        | General storage register
; BL | Base Low Byte (8-bit)         | Stores first digit
; BH | Base High Byte (8-bit)        | Stores second digit
; DX | Data Register (16-bit)        | Holds address of string
; DL | Data Low Byte (8-bit)         | Holds character for output display
; DS | Data Segment Register         | Points to DATA memory segment
;
; -------------------------------
; ASCII VALUES USED
; -------------------------------
; '0' = 30H (48 Decimal)
; ASCII → Numeric : SUB 30H
; Numeric → ASCII : ADD 30H
;
; -------------------------------
; DOS FUNCTIONS USED (INT 21H)
; -------------------------------
; AH = 01H → Input Single Character (Returned in AL)
; AH = 02H → Display Single Character (Character in DL)
; AH = 09H → Display String (Address in DX, string ends with $)
; AH = 4CH → Terminate Program and Return Control to DOS
;
; -------------------------------
; HOW TO RUN
; -------------------------------
; Compile → Emulate → Type two digits (sum must be < 10)
; Example Input  : 27
; Example Output : THE SUM OF 2 AND 7 IS 9
; =====================================================================

.MODEL SMALL                  ; MODEL = Memory Model directive
                              ; SMALL = One CODE segment + One DATA segment (max 64KB each)

.STACK 100H                   ; STACK segment allocation
                              ; 100H = 256 bytes (Hexadecimal 100H = 256 Decimal)

.DATA                         ; Beginning of DATA segment

MSG1 DB 0DH,0AH,'THE SUM OF $' ; DB = Define Byte
                               ; 0DH = 0D Hex = 13 Decimal = Carriage Return (CR)
                               ; 0AH = 0A Hex = 10 Decimal = Line Feed (LF)
                               ; $ = String terminator required by DOS function 09H

MSG2 DB ' AND $'              ; Second string message
MSG3 DB ' IS $'               ; Third string message

.CODE                         ; Beginning of CODE segment

MAIN PROC                     ; PROC = Procedure start
                              ; MAIN is entry point of program

    MOV AX,@DATA              ; MOV = Move instruction
                              ; AX = Accumulator Register (16-bit)
                              ; @DATA = Address of DATA segment
                              ; Load DATA segment address into AX

    MOV DS,AX                 ; DS = Data Segment Register
                              ; Initialize DS with DATA segment address
                              ; Required before accessing variables

; -------------------------
; Display "?"
; -------------------------

    MOV DL,'?'                ; DL = Data Low Register (8-bit)
                              ; Store ASCII value of '?' in DL

    MOV AH,02H                ; AH = Accumulator High (upper 8-bit of AX)
                              ; 02H = DOS Function to Display Single Character

    INT 21H                   ; INT = Interrupt instruction
                              ; 21H = DOS interrupt handler
                              ; Executes function selected in AH

; -------------------------
; Input first digit
; -------------------------

    MOV AH,01H                ; 01H = DOS Function to Take Character Input
                              ; Input character returned in AL

    INT 21H                   ; Executes keyboard input
                              ; AL = Accumulator Low now contains input ASCII

    MOV BL,AL                 ; BL = Base Register Low (8-bit)
                              ; Store first input digit in BL

; -------------------------
; Input second digit
; -------------------------

    MOV AH,01H                ; Again select input function

    INT 21H                   ; Second digit stored in AL

    MOV BH,AL                 ; BH = Base Register High (upper 8-bit of BX)
                              ; Store second digit in BH

; -------------------------
; Convert ASCII to Number
; -------------------------

    SUB BL,30H                ; SUB = Subtract instruction
                              ; 30H = ASCII value of '0'
                              ; Convert ASCII digit to numeric value

    SUB BH,30H                ; Convert second digit from ASCII to number

; -------------------------
; Addition Operation
; -------------------------

    MOV AL,BL                 ; Move first numeric value into AL

    ADD AL,BH                 ; ADD = Add instruction
                              ; AL = AL + BH → sum stored in AL

    ADD AL,30H                ; Convert numeric sum back to ASCII
                              ; Required for proper character display

; -------------------------
; Display Message Part 1
; -------------------------

    LEA DX,MSG1               ; LEA = Load Effective Address
                              ; DX = Data Register (16-bit)
                              ; Load address of MSG1 into DX

    MOV AH,09H                ; 09H = DOS Function to Display String
                              ; String must end with '$'

    INT 21H                   ; Display MSG1

; -------------------------
; Display First Digit
; -------------------------

    MOV DL,BL                 ; Move numeric value of first digit to DL

    ADD DL,30H                ; Convert number back to ASCII for printing

    MOV AH,02H                ; Select character display function

    INT 21H                   ; Display first digit

; -------------------------
; Display MSG2
; -------------------------

    LEA DX,MSG2               ; Load address of MSG2

    MOV AH,09H                ; Select string display function

    INT 21H                   ; Display MSG2

; -------------------------
; Display Second Digit
; -------------------------

    MOV DL,BH                 ; Move numeric second digit to DL

    ADD DL,30H                ; Convert to ASCII

    MOV AH,02H                ; Select display character function

    INT 21H                   ; Display second digit

; -------------------------
; Display MSG3
; -------------------------

    LEA DX,MSG3               ; Load address of MSG3

    MOV AH,09H                ; Select string display function

    INT 21H                   ; Display MSG3

; -------------------------
; Display Sum
; -------------------------

    MOV DL,AL                 ; AL already contains ASCII sum

    MOV AH,02H                ; Select display character function

    INT 21H                   ; Display sum digit

; -------------------------
; Program Termination
; -------------------------

    MOV AH,4CH                ; 4CH = DOS Terminate Program Function
                              ; Return control to Operating System

    INT 21H                   ; Execute program termination

MAIN ENDP                     ; End of MAIN procedure
END MAIN                      ; End of program, linker entry point