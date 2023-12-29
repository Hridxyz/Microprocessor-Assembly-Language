  INCLUDE VICVPB-1.s
  AREA SERIAL, CODE, READONLY
  EXPORT __main
__main
	ENTRY
	LDR R1,=VPBDIV
	LDR R0,=2
	STR R0,[R1]
	LDR R1,=PINSEL0
	LDR R0,=0X05
	STR R0,[R1]
	LDR R1,=U0LCR
	LDR R0,=0X83
	STR R0,[R1]
	LDR R1,=U0DLL
	LDR R0,=195
	STR R0,[R1]
	LDR R1,=U0DLM
	LDR R0,=0
	STR R0,[R1]
	LDR R1,=U0LCR
	LDR R0,=0X03
	STR R0,[R1]
	LDR R1,=U0IER
	LDR R0,=0X03
	STR R0,[R1]
	LDR R1,=VICVectCntl0
	LDR R0,=0X26
	STR R0,[R1]
	LDR R1,=VICVectAddr0
	LDR R0,=IRQ_UART0
	STR R0,[R1]
	LDR R1,=VICIntEnable
	LDR R0,=0X40
	STR R0,[R1]
S	B	S
IRQ_UART0
	STMDB R13!,{R0-R1}
	LDR R1,=U0IIR
UP1	LDR R0,[R1]
	AND R2,R0,#0X4
	CMP R2,#0X4
	BNE UP1
	LDR R1,=U0RBR
	LDRB R0,[R1]
	LDR R2,=U0THR
	STRB R0,[R2]
	LDR R1,=VICVectAddr
	LDR R0,=0
	STR R0,[R1]
	LDMIA R13!,{R0-R1}
	SUBS PC,R14,#4
	END