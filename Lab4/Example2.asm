  INCLUDE VICVPB-1.s
  AREA T0_INT, CODE, READONLY
  EXPORT __main
__main
	ENTRY
	LDR R1,=VPBDIV
	LDR R0,=0X02
	STR R0,[R1]
;	LDR R1,=MEMMAP; User Flash Mode. Interrupt vectors are
;	LDR R0,=0x01  ; not re-mapped and reside in Flash.
;	STR R0,[R1]
	LDR R1,=IO0DIR
	LDR R0,=0X00FF0000
	STR R0,[R1]
	STR R0,[R1]
	LDR R1,=VICVectCntl0 
	LDR R0,=0X24
	STR R0,[R1]
	LDR R1,=VICVectAddr0
	LDR R0,=IRQ_TIM0
	STR R0,[R1]
	LDR R1,=VICIntEnable
	LDR R0,=0X10
	STR R0,[R1]
	LDR R1,=T0PR
	LDR R0,=29
	STR R0,[R1]
	LDR R1,=T0TCR
	LDR R0,=1
	STR R0,[R1]
	LDR R1,=T0MR0
	LDR R0,=1000000
	STR R0,[R1]
	LDR R1,=T0MCR
	LDR R0,=3
	STR R0,[R1]
	LDR R2,=0XFF
S	B	S
IRQ_TIM0
	STMDB R13!,{R0-R1}
	LDR R1,=T0IR
	LDR R0,=1
	STR R0,[R1]
	LDR R1,=VICVectAddr
	LDR R0,=0
	STR R0,[R1]
	LDR R1,=IO0PIN
	SUB R2,R2,#1
	MOV R0,R2,LSL#16
	STR R0,[R1]
	LDMIA R13!,{R0-R1}
	SUBS PC,R14,#4
	END