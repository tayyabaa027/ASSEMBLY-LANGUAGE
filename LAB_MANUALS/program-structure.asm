; =====================================================================
; PROGRAM INFORMATION TABLE
; =====================================================================
; Program Name  : Minimal 8086 Program
; Processor    : Intel 8086
; Emulator     : EMU8086
; Purpose      : Emulator familiarity, instruction tracing,
;                and clean program termination
; =====================================================================
;
; -------------------------------
; INPUT – PROCESS – OUTPUT TABLE
; -------------------------------
; Input         : None
; Process       : 1 Initialize DATA segment
;                 2 No computation / logic
;                 3 Call DOS interrupt for exit
; Output        : No visible output
;
; -------------------------------
; REGISTERS USED TABLE
; -------------------------------
; Register  | Full Form              | Usage
; ----------|------------------------|-------------------------------
; AX        | Accumulator Register   | Holds DATA segment address
; AH        | Accumulator High Byte  | Holds DOS function 4CH
; DS        | Data Segment Register  | Points to DATA segment
; CS        | Code Segment Register  | Used to fetch instructions
; IP        | Instruction Pointer    | Points to next instruction
;
; -------------------------------
; OUTPUT DESCRIPTION
; -------------------------------
; Screen Output : None
; Result        : Program terminates successfully
; Verification  : No runtime or compile-time error
;
; -------------------------------
; HOW TO RUN THE PROGRAM
; -------------------------------
; Step 1 : Open EMU8086
; Step 2 : Create new file and paste this code
; Step 3 : Click Compile (No errors should appear)
; Step 4 : Click Emulate
; Step 5 : Press F8 to single-step and observe registers
;
; =====================================================================

.MODEL SMALL                 ; SMALL memory model (one code + one data segment)

.STACK 100H                  ; Reserve 256 bytes for stack memory

.DATA                         ; DATA segment
                              ; No variables declared

.CODE                         ; CODE segment starts
MAIN PROC                    ; MAIN procedure (entry point)

    MOV AX, @DATA             ; AX = address of DATA segment
    MOV DS, AX                ; DS = AX (initialize DATA segment)

    MOV AH, 4CH               ; AH = 4CH (DOS terminate program function)
    INT 21H                   ; Call DOS interrupt 21H to exit program

MAIN ENDP                    ; End of MAIN procedure
END MAIN                     ; Program execution ends here
