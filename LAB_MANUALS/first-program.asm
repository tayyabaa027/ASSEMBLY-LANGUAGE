; ------------------------------------------------------------
; Program: Minimal 8086 Video Memory Demo
; About  : This program writes a single character directly
;          to the screen using VGA text video memory.
; Output : The letter 'H' appears at the top-left corner
;          of the screen in light gray color on black background.
; Run    : Load this file in an 8086 emulator (e.g., emu8086),
;          assemble and run it as a .COM program.
; ------------------------------------------------------------

org 100h                  ; ORG = Origin ? program starts at offset 100h in memory (DOS .COM rule)

mov ax, 0B800h            ; AX = Accumulator Register ? load VGA (Video Graphics Array)
                          ; video memory segment address B800h into AX

mov ds, ax                ; DS = Data Segment Register ? points data access to video memory

mov [0], 'H'              ; Write ASCII (American Standard Code for Information Interchange)
                          ; character 'H' at video memory offset 0000h (row 0, column 0)

mov [1], 07h              ; Write color attribute byte
                          ; 07h ? foreground: light gray, background: black

mov ah, 0                 ; AH = High byte of AX ? function 00h
                          ; BIOS (Basic Input Output System) keyboard service

int 16h                   ; INT = Interrupt ? BIOS interrupt 16h
                          ; waits until a key is pressed

ret                       ; RET = Return ? returns control to DOS and ends program


;-----------------------------------------------------------------------------------
;This Emu8086 program demonstrates direct screen output by writing ASCII characters and 
;color attributes into VGA video memory (B800h) 
;without using DOS print functions.
;-----------------------------------------------------------------------------------