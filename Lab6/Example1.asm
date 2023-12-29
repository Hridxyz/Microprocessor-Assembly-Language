IO0DIR EQU 0XE0028008
IO0SET EQU 0XE0028004
IO0CLR EQU 0XE002800C
  ;INCLUDE V
  AREA CHANG, CODE , READONLY
	EXPORT __main
__main
	ENTRY
		LDR R1,=IO0DIR 		;load the adress of the IO0DIR reg to R1
		LDR R0,=0XF0FF0000 	;pins P0.16 to P0.23 and P0.28-P0.31 as output pins
		STR R0,[R1] 		;This configures P0.16 to P0.23 as output pins
		LDR R2,=IO0SET		;Load the address of the IO0CLR reg to R2
		LDR R3,=IO0CLR		
S		STR R0,[R3]			;Turn off display
		LDR R1,=0X806F0000	;To display 0 on rightmost segment
		STR R1,[R2]
		BL DELAY
		STR R0,[R3]			;Turn off display
		LDR R1,=0X407D0000	;To display 1 on third segment
		STR R1,[R2]
		BL DELAY
		STR R0,[R3]			;Turn off display
		LDR R1,=0X206F0000	;To display 2 on second segment
		STR R1,[R2]
		BL DELAY
		STR R0,[R3]			;Turn off display
		LDR R1,=0X107D0000	;To display 3 on leftmost segment
		STR R1,[R2]
		BL DELAY
		B	S
DELAY
		LDR R5,=0X2FF	;Delay program to retain the bit for some time
delay	SUBS R5,R5,#1
		BNE delay
		BX LR
		END
			