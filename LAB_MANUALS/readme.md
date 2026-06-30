# 1 - .MODEL SMALL — Why We Use It

`.MODEL SMALL` is a memory model directive used in MASM/TASM for 8086 assembly programs.

It tells the assembler that the program will use:

- One Code Segment (CS — Code Segment Register)
- One Data Segment (DS — Data Segment Register)
- Each segment can be up to 64KB (Kilobytes)

This simplifies memory organization and is suitable for beginner-level programs.

---

## What If We Do Not Use .MODEL?

In MASM/TASM, `.MODEL` automatically defines the segment structure.

If it is not used, you must manually declare segments such as:

DATA SEGMENT  
DATA ENDS  

CODE SEGMENT  
CODE ENDS  

This makes the program:

- Longer
- More complex
- Harder to manage for beginners

In EMU8086, `.MODEL SMALL` is preferred for clean and structured lab programs.

---

## Why Specifically SMALL?

We use SMALL because:

- Lab programs are short.
- Only one data segment is required.
- No complex memory management is needed.
- It is simple and safe for academic use.

It is the standard choice for 8086 lab tasks.

---

## Other Memory Models (Short Overview)

| Model   | Code Segments | Data Segments | When to Use |
|---------|--------------|---------------|-------------|
| TINY    | 1 (combined) | 1 (same as code) | Very small .COM programs (max 64KB total) |
| SMALL   | 1 | 1 | Simple academic or lab programs |
| MEDIUM  | Many | 1 | Large code, small data |
| COMPACT | 1 | Many | Small code, large data |
| LARGE   | Many | Many | Bigger applications |
| HUGE    | Many | Many | Very large arrays (more than 64KB) |

---

## Practical Rule

Use TINY for very small .COM programs.  
Use SMALL for most 8086 student lab programs.  
Use MEDIUM, LARGE, or HUGE only for complex or large-scale software.

# 2 - .STACK 100H — Why We Use It

`.STACK 100H` is a directive that allocates memory space for the **Stack Segment (SS — Stack Segment Register)** in an 8086 program.

`100H` is a hexadecimal value.  
100H = 256 in decimal.  
So this statement reserves **256 bytes of stack memory**.

---

## Why Is Stack Needed?

The stack is used for:

- Storing return addresses during procedure calls
- Saving register values (PUSH and POP instructions)
- Handling interrupts (INT instruction automatically uses stack)
- Temporary data storage

Without a properly allocated stack, these operations may overwrite memory or cause program crash.

---

## What If We Do Not Use .STACK?

If `.STACK` is not declared:

- MASM may not automatically create a proper stack segment.
- Stack behavior can become unpredictable.
- PUSH, POP, CALL, RET, and INT instructions may fail.

In structured programs (like SMALL model), `.STACK` should always be declared.

---

## Why Specifically 100H?

100H (256 bytes) is used because:

- It is sufficient for small academic programs.
- Lab programs usually do not use deep procedure nesting.
- It is a safe default value.
- It avoids wasting too much memory.

---

## Other Possible Stack Sizes

You can specify different sizes depending on program complexity:

| Stack Size | Decimal Value | When to Use |
|------------|--------------|-------------|
| 40H        | 64 bytes     | Very small programs, no procedures |
| 80H        | 128 bytes    | Light usage with few PUSH/POP |
| 100H       | 256 bytes    | Standard lab programs (recommended) |
| 200H       | 512 bytes    | Programs with procedures |
| 400H       | 1024 bytes   | Larger programs with nested calls |

---

## When to Use Which One?

- Use 100H → Normal academic/lab programs.
- Use smaller values → If program is extremely simple.
- Use larger values → If program contains:
  - Many procedures
  - Recursive calls
  - Heavy PUSH/POP usage
  - Multiple interrupts

---

## Practical Rule

For 8086 lab programs, use:

.STACK 100H

It is balanced, safe, and sufficient for most beginner-level applications.

# 3 - .DATA — Why We Use It

`.DATA` is a directive that marks the **start of the Data Segment** in an 8086 assembly program.

- Variables, constants, and messages used by the program are declared here.
- The assembler knows where to allocate memory for all program data.

---

## Why Is It Needed?

- Without `.DATA`, the program cannot store or access variables safely.
- All static data (strings, numbers, arrays) must be in a defined segment.
- Accessing undefined memory may cause crashes or unpredictable behavior.

---

## What If We Do Not Use .DATA?

- The assembler will not know where to place variables.
- You may have to manually allocate memory using labels and offsets.
- Program becomes more complex and error-prone.
- EMU8086 and MASM require `.DATA` for proper structured programs.

---

## Other Options / Segments

Besides `.DATA`, 8086 programs can use:

| Segment Directive | Purpose |
|------------------|---------|
| .CODE             | Start of code segment (instructions) |
| .STACK            | Stack memory for procedure calls and interrupts |
| .CONST            | Read-only constants (optional) |
| SEGMENT <name>    | Manual segment definition for advanced programs |

---

## When to Use Which One?

- `.DATA` → Always use for program variables and messages (standard for SMALL model programs)
- `.CONST` → When you have read-only data that should not be modified
- `.CODE` → Always required for instructions
- `.STACK` → Required for procedure calls, interrupts, and PUSH/POP operations

---

## Practical Rule

For beginner 8086 lab programs:

- Declare `.DATA` before all variable definitions.
- Keep it simple: use `.DATA` for strings, numbers, and messages.
- Follow it with `.CODE` for the main program logic.

# 4 - MSG1 DB 0DH,0AH,'THE SUM OF $' — Explanation

`MSG1 DB 0DH,0AH,'THE SUM OF $'` is a declaration of a **string message** in the 8086 assembly program.

- `DB` stands for **Define Byte**. It allocates memory for each element (character or value).
- `0DH` is **Carriage Return (CR)** — moves cursor to the beginning of the line.
- `0AH` is **Line Feed (LF)** — moves cursor to the next line.
- `$` is the **string terminator** required by DOS function `09H` to know where the string ends.

This line will display:
THE SUM OF
on a **new line** when printed using DOS interrupt 21H, function 09H.

---

## Why Use 0DH and 0AH?

- `0DH` + `0AH` combination moves the cursor to the next line and starts from the left margin.
- Without these, the string would continue on the **same line** after previous output.

---

## Why Write All in a Single Line?

- Using one `DB` with multiple bytes is **compact** and keeps related data together.
- Easier to manage and reference in code using **LEA DX, MSG1**.
- All characters are stored **sequentially** in memory.

---

## What If We Don’t Use This Statement?

- If not declared, the program cannot display the message.
- Attempting to display an undefined string will show **garbage characters** or crash.
- DOS function `09H` requires a string ending with `$`.

---

## Other Options / Variations

| Option | Description | When to Use |
|--------|------------|-------------|
| Multiple DB statements | Declare each part separately | When you want to modify parts dynamically |
| DW (Define Word) | 16-bit storage | Rarely used for characters, useful for numeric constants |
| DUP operator | Repeat values, e.g., 0DH,0AH DUP(1) | For repeated characters like new lines |
| Inline CR + LF in separate line | `MSG1 DB 0DH,0AH` then `DB 'TEXT$'` | Useful for clarity in long messages |

---

## Practical Rule

- Use `DB 0DH,0AH,'MESSAGE$'` for simple strings that need a **line break**.
- Always terminate string with `$` when using DOS function 09H.
- Keep related data in **single DB line** unless program logic requires separate declaration.

# 5 - MSG2 and MSG3 — Explanation

`MSG2 DB ' AND $'` and `MSG3 DB ' IS $'` are declarations of additional string messages in the 8086 assembly program.

- `DB` stands for **Define Byte** — allocates memory for each character.
- `$` is the **string terminator** required by DOS function 09H to indicate the end of the string.
- `MSG2` will display the text ` AND ` after the first digit.
- `MSG3` will display the text ` IS ` before the sum result.

These messages are used to format the output like:

    THE SUM OF 2 AND 7 IS 9

---

## Why Use Separate MSG Variables?

- Keeps the message modular and easier to modify.
- Each part of the message can be printed separately using DOS function 09H.
- Makes program logic clearer by separating prompt, digits, and sum text.

---

## What If We Don’t Use These Statements?

- Without `MSG2` and `MSG3`, the program cannot display the complete formatted output.
- Output may appear incomplete or messy.

---

## Practical Rule

- Declare each message string separately with `DB` and terminate with `$`.
- Use DOS function 09H with `LEA DX, MSGx` to print each part sequentially.

# 6 - .CODE — Why We Use It

`.CODE` is a directive that marks the **beginning of the Code Segment** in an 8086 assembly program.

- All executable instructions are written after `.CODE`.
- The assembler knows that the following lines are **program logic**, not data.
- The Code Segment is usually pointed to by the **CS (Code Segment Register)** during execution.

---

## Why Is It Needed?

- Without `.CODE`, the assembler would not differentiate between **data** and **instructions**.
- Mixing instructions with data can cause **program crashes or undefined behavior**.
- It is mandatory in structured programs (like SMALL memory model) to define where code starts.

---

## What If We Don’t Use .CODE?

- You would have to manually define a segment like:

CODE SEGMENT
; instructions here
CODE ENDS


- This increases complexity and reduces readability.
- EMU8086 and MASM rely on `.CODE` to properly organize memory and execution flow.

---

## Other Options / Variations

| Directive | Purpose |
|-----------|---------|
| `.CODE`   | Start of main program instructions |
| SEGMENT <name> | Manual code segment declaration for advanced programs |
| `.PROC`  | Defines a procedure inside code segment (must be inside `.CODE`) |

---

## When to Use Which One?

- Use `.CODE` → For all instructions in SMALL, TINY, or similar models.
- Use SEGMENT / PROC → When defining multiple code segments or procedures in complex programs.

---

## Practical Rule

- Always declare `.CODE` after `.DATA` and `.STACK`.
- Keep all executable instructions inside `.CODE`.
- Follow `.CODE` with `MAIN PROC` or procedure declarations to start program logic.

# 7 - MAIN PROC / MAIN ENDP / END MAIN — Explanation

`MAIN PROC` and `MAIN ENDP` define a **procedure** in 8086 assembly, and `END MAIN` marks the **program's entry point** for the linker.

---

## Why We Use These Statements

- `PROC` (Procedure) → Marks the **start of a block of instructions** that can be executed as a unit.
- `ENDP` (End Procedure) → Marks the **end of that procedure**.
- `END` → Tells the assembler/linker **where the program starts execution**.

---

## Why Naming It MAIN

- `MAIN` is a **conventional name** for the primary procedure where program execution begins.
- It is **not mandatory**; you can name it anything.
- The name after `END` must match the entry procedure to indicate the program start point.

---

## What If We Don’t Use These Statements?

- Without `PROC` / `ENDP`:
  - Instructions are still valid if written directly, but **structure is lost**.
  - Harder to read, maintain, and expand with multiple procedures.
- Without `END MAIN`:
  - The assembler/linker may not know the program's **entry point**.
  - Program may fail to execute in EMU8086 or DOS.

---

## Other Options / Variations

| Statement | Purpose |
|-----------|---------|
| PROC / ENDP | Define named procedures (blocks of instructions) |
| LABEL only | Use labels without PROC/ENDP for very small programs |
| END <entry_point> | Specify where program execution starts |
| Multiple PROC blocks | For complex programs with multiple procedures |

---

## Practical Rule

- For small lab programs: use `MAIN PROC ... MAIN ENDP` and `END MAIN`.
- For larger programs: define **additional procedures** with PROC/ENDP and call them from MAIN.
- Naming is flexible, but **END must match the starting procedure**.

## Can we create multiple procedures in a single file or use multiple files, and how do we connect or call procedures from one another?

## Multiple Procedures 

In 8086 assembly, you **can create multiple procedures** in a single file or across multiple files. Procedures allow you to organize code into reusable blocks.

---

## Multiple Procedures in a Single File

- You can define several procedures using `PROC` and `ENDP`:


PROC1 PROC
; Instructions for PROC1
PROC1 ENDP

PROC2 PROC
; Instructions for PROC2
PROC2 ENDP


- Call one procedure from another using the **CALL instruction**:


CALL PROC1 ; Executes PROC1
CALL PROC2 ; Executes PROC2


- Control automatically returns to the next instruction after the CALL when the procedure ends.

---

## Multiple Procedures Across Multiple Files

- Each file can contain procedures.
- To combine files:
  - Use **EXTRN / PUBLIC** directives.
    - `PUBLIC` → Makes a procedure available to other files.
    - `EXTRN` → Declares an external procedure from another file.
- The linker resolves calls between files at assembly/link time.

---

## How to Connect Procedures

1. **Within Same File**
   - Define procedures using `PROC` / `ENDP`.
   - Call with `CALL ProcedureName`.
2. **Across Different Files**
   - Mark procedure as `PUBLIC` in file where it is defined.
   - Declare with `EXTRN` in file where it is called.
   - Use `CALL ProcedureName` as usual.

---

## Practical Rule

- Use multiple procedures to **organize code** and avoid repetition.
- Start with a **MAIN procedure** that calls other procedures.
- For large programs, you can split into multiple files for **modularity**.
- Always ensure procedure names match between `CALL`, `PUBLIC`, and `EXTRN`.