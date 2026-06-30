; ------------------------------------------------------------
; Program: HELLO WORLD using 8086 Video Memory
; About  : This program displays the text "HELLO WORLD"
;          by writing directly into VGA text video memory.
; Output : HELLO WORLD appears at the top-left corner of
;          the screen in light gray on black background.
; Run    : Open in Emu8086 ? Assemble ? Run (.COM program)
; ------------------------------------------------------------

org 100h                  ; ORG = Origin ? starting offset 0100h for DOS .COM programs

mov ax, 0B800h            ; AX = Accumulator Register ? load VGA (Video Graphics Array)
                          ; text-mode video memory segment address B800h into AX

mov ds, ax                ; DS = Data Segment Register ? points memory access to video memory

; NOTE:
; In VGA text mode:
; - Even memory offset = ASCII character
; - Odd  memory offset = color attribute
; - Each character occupies 2 bytes

mov [0], 'H'              ; Store ASCII character 'H' at video memory offset 0000h
mov [1], 07h              ; Store color attribute 07h (light gray foreground, black background)

mov [2], 'E'              ; Store ASCII character 'E' next to 'H'
mov [3], 07h              ; Apply same color attribute

mov [4], 'L'              ; Store ASCII character 'L'
mov [5], 07h              ; Apply color to 'L'

mov [6], 'L'              ; Store ASCII character 'L'
mov [7], 07h              ; Apply color to 'L'

mov [8], 'O'              ; Store ASCII character 'O'
mov [9], 07h              ; Apply color to 'O'

mov [10], ' '             ; Store ASCII space between HELLO and WORLD
mov [11], 07h             ; Apply color to space

mov [12], 'W'             ; Store ASCII character 'W'
mov [13], 07h             ; Apply color to 'W'

mov [14], 'O'             ; Store ASCII character 'O'
mov [15], 07h             ; Apply color to 'O'

mov [16], 'R'             ; Store ASCII character 'R'
mov [17], 07h             ; Apply color to 'R'

mov [18], 'L'             ; Store ASCII character 'L'
mov [19], 07h             ; Apply color to 'L'

mov [20], 'D'             ; Store ASCII character 'D'
mov [21], 07h             ; Apply color to 'D'

mov ah, 0                 ; AH = High byte of AX ? BIOS keyboard function 00h
                          ; prepares system to wait for a key press

int 16h                   ; INT = Interrupt ? BIOS interrupt 16h
                          ; pauses execution until user presses any key

ret                       ; RET = Return ? terminates program and returns control to DOS


;-----------------------------------------------------------------------------------
; Summary:
; This Emu8086 program demonstrates how to display text on the screen
; by directly writing ASCII characters and color attributes into
; VGA text-mode video memory at segment address B800h.
;-----------------------------------------------------------------------------------
