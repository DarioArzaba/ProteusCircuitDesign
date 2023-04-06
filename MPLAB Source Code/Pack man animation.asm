
;CodeVisionAVR C Compiler V3.34 Evaluation
;(C) Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega328P
;Program type           : Application
;Clock frequency        : 1.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : long, width
;(s)scanf features      : long, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: Off
;Smart register allocation: Off

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega328P
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x08FF
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_0x3:
	.DB  0x3,0x3,0x3,0x2,0x2,0xC,0x0,0x8
	.DB  0x0,0x1,0x0,0x6
_0x25:
	.DB  0xE,0x1D,0x1E,0x1C,0x1E,0x1F,0xE
_0x26:
	.DB  0xE,0x1D,0x1F,0x1E,0x1F,0x1F,0xE
_0x27:
	.DB  0xE,0x17,0x1F,0xF,0x1F,0x1F,0xE
_0x28:
	.DB  0xE,0x17,0x1F,0x1F,0x1F,0x1F,0xE
_0x0:
	.DB  0x48,0x65,0x6C,0x6C,0x6F,0x0,0x4D,0x72
	.DB  0x2E,0x20,0x50,0x61,0x63,0x4D,0x61,0x6E
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x07
	.DW  _PacMan1
	.DW  _0x25*2

	.DW  0x07
	.DW  _PacMan2
	.DW  _0x26*2

	.DW  0x07
	.DW  _PacMan3
	.DW  _0x27*2

	.DW  0x07
	.DW  _PacMan4
	.DW  _0x28*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x300

	.CSEG
;#asm
   .equ __lcd_port=0x0B
   .equ __lcd_EN=3
   .equ __lcd_RS=2
   .equ __lcd_D4=4
   .equ __lcd_D5=5
   .equ __lcd_D6=6
   .equ __lcd_D7=7
; 0000 0009 #endasm
;
;#include <mega328p.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif
;#include <delay.h>
;#include <display.h>

	.CSEG
_SetupLCD:
; .FSTART _SetupLCD
	SBIW R28,12
	LDI  R24,12
	__GETWRN 22,23,0
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	RCALL __INITLOCB
	ST   -Y,R16
;	TableSetup -> Y+1
;	i -> R16
; 0000 000D     SBI __lcd_port-1,__lcd_EN
    SBI __lcd_port-1,__lcd_EN
    SBI __lcd_port-1,__lcd_RS
    SBI __lcd_port-1,__lcd_D4
    SBI __lcd_port-1,__lcd_D5
    SBI __lcd_port-1,__lcd_D6
    SBI __lcd_port-1,__lcd_D7
	LDI  R26,LOW(50)
	LDI  R27,0
	RCALL _delay_ms
	LDI  R16,LOW(0)
_0x5:
	CPI  R16,12
	BRSH _0x6
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	MOV  R30,R16
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RCALL _SendDataBitsLCD
	RCALL _PulseEn
	SUBI R16,-1
	RJMP _0x5
_0x6:
	LDI  R30,LOW(12)
	STS  _cursor,R30
	LDS  R26,_cursor
	RCALL _WriteComandLCD
	LDD  R16,Y+0
	ADIW R28,13
	RET
; .FEND
_PulseEn:
; .FSTART _PulseEn
    SBI __lcd_port,__lcd_EN  // EN=1;
    CBI __lcd_port,__lcd_EN // EN=0;
	RET
; .FEND
_SendDataBitsLCD:
; .FSTART _SendDataBitsLCD
	ST   -Y,R16
	MOV  R16,R26
;	dato -> R16
	SBRS R16,3
	RJMP _0x7
	SBI __lcd_port,__lcd_D7
	RJMP _0x8
_0x7:
	CBI __lcd_port,__lcd_D7
_0x8:
	SBRS R16,2
	RJMP _0x9
	SBI __lcd_port,__lcd_D6
	RJMP _0xA
_0x9:
	CBI __lcd_port,__lcd_D6
_0xA:
	SBRS R16,1
	RJMP _0xB
	SBI __lcd_port,__lcd_D5
	RJMP _0xC
_0xB:
	CBI __lcd_port,__lcd_D5
_0xC:
	SBRS R16,0
	RJMP _0xD
	SBI __lcd_port,__lcd_D4
	RJMP _0xE
_0xD:
	CBI __lcd_port,__lcd_D4
_0xE:
	RJMP _0x2060001
; .FEND
_WriteComandLCD:
; .FSTART _WriteComandLCD
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
;	Comando -> R17
;	tempComando -> R16
	CBI __lcd_port,__lcd_RS
	RJMP _0x2060003
; .FEND
_CharLCD:
; .FSTART _CharLCD
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
;	dato -> R17
;	tempdato -> R16
	SBI __lcd_port,__lcd_RS
_0x2060003:
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	MOV  R16,R30
	SWAP R16
	ANDI R16,0xF
	MOV  R26,R16
	RCALL _SendDataBitsLCD
	RCALL _PulseEn
	MOV  R30,R17
	ANDI R30,LOW(0xF)
	MOV  R16,R30
	MOV  R26,R16
	RCALL _SendDataBitsLCD
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	RCALL _PulseEn
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
_StringLCD:
; .FSTART _StringLCD
	RCALL __SAVELOCR3
	__PUTW2R 17,18
;	Mensaje -> R17,R18
;	i -> R16
	LDI  R16,LOW(0)
_0x10:
	MOV  R30,R16
	SUBI R16,-1
	LDI  R31,0
	ADD  R30,R17
	ADC  R31,R18
	LPM  R26,Z
	RCALL _CharLCD
	MOV  R30,R16
	LDI  R31,0
	ADD  R30,R17
	ADC  R31,R18
	LPM  R30,Z
	CPI  R30,0
	BRNE _0x10
	RCALL __LOADLOCR3
	RJMP _0x2060002
; .FEND
;	Mensaje -> R19,R20
;	tiempo -> R17,R18
;	i -> R16
;	Mensaje -> R17,R18
;	i -> R16
_MoveCursor:
; .FSTART _MoveCursor
	ST   -Y,R17
	ST   -Y,R16
	MOV  R16,R26
	LDD  R17,Y+2
;	x -> R17
;	y -> R16
	MOV  R30,R16
	LDI  R31,0
	SBIW R30,0
	BRNE _0x1B
	MOV  R26,R17
	SUBI R26,-LOW(128)
	RJMP _0x49
_0x1B:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x1C
	MOV  R26,R17
	SUBI R26,-LOW(192)
	RJMP _0x49
_0x1C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x1D
	MOV  R26,R17
	SUBI R26,-LOW(148)
	RJMP _0x49
_0x1D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x1A
	MOV  R26,R17
	SUBI R26,-LOW(212)
_0x49:
	RCALL _WriteComandLCD
_0x1A:
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x2060002:
	ADIW R28,3
	RET
; .FEND
_CreateChar:
; .FSTART _CreateChar
	RCALL __SAVELOCR4
	__PUTW2R 17,18
	LDD  R19,Y+4
;	NoCaracter -> R19
;	datos -> R17,R18
;	i -> R16
	MOV  R30,R19
	LSL  R30
	LSL  R30
	LSL  R30
	SUBI R30,-LOW(64)
	MOV  R26,R30
	RCALL _WriteComandLCD
	LDI  R16,LOW(0)
_0x20:
	CPI  R16,8
	BRSH _0x21
	__GETW2R 17,18
	CLR  R30
	ADD  R26,R16
	ADC  R27,R30
	LD   R26,X
	RCALL _CharLCD
	SUBI R16,-1
	RJMP _0x20
_0x21:
	LDI  R26,LOW(128)
	RCALL _WriteComandLCD
	RCALL __LOADLOCR4
	ADIW R28,5
	RET
; .FEND
;#include <stdio.h>
;#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR)) // ADV Voltage Ref
;
;unsigned int read_adc(unsigned char adc_input) {
; 0000 0011 unsigned int read_adc(unsigned char adc_input) {
_read_adc:
; .FSTART _read_adc
; 0000 0012     // Used to Read the Conversion Result
; 0000 0013     ADMUX=adc_input | ADC_VREF_TYPE;
	ST   -Y,R16
	MOV  R16,R26
;	adc_input -> R16
	MOV  R30,R16
	ORI  R30,0x40
	STS  124,R30
; 0000 0014     delay_us(10); // ADC Input Voltage Stabilization Delay
	__DELAY_USB 3
; 0000 0015     ADCSRA|=(1<<ADSC); // Start Conversion
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 0016     while ((ADCSRA & (1<<ADIF))==0); // Wait for Conversion to finish
_0x22:
	LDS  R30,122
	ANDI R30,LOW(0x10)
	BREQ _0x22
; 0000 0017     ADCSRA|=(1<<ADIF);
	LDS  R30,122
	ORI  R30,0x10
	STS  122,R30
; 0000 0018     return ADCW;
	LDS  R30,120
	LDS  R31,120+1
_0x2060001:
	LD   R16,Y+
	RET
; 0000 0019 }
; .FEND
;
;void delayPacMan() {
; 0000 001B void delayPacMan() {
_delayPacMan:
; .FSTART _delayPacMan
; 0000 001C     delay_ms(read_adc(0)/4);
	LDI  R26,LOW(0)
	RCALL _read_adc
	RCALL __LSRW2
	MOVW R26,R30
	RCALL _delay_ms
; 0000 001D }
	RET
; .FEND
;
;void message()
; 0000 0020 {
_message:
; .FSTART _message
; 0000 0021    MoveCursor(5,0);
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _MoveCursor
; 0000 0022    StringLCD("Hello");
	__POINTW2FN _0x0,0
	RCALL _StringLCD
; 0000 0023    MoveCursor(3,1);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _MoveCursor
; 0000 0024    StringLCD("Mr. PacMan");
	__POINTW2FN _0x0,6
	RCALL _StringLCD
; 0000 0025 }
	RET
; .FEND
;
;unsigned char PacMan1[8]={0x0E,0x1D,0x1E,0x1C,0x1E,0x1F,0x0E,0x00}; // Open Right

	.DSEG
;unsigned char PacMan2[8]={0x0E,0x1D,0x1F,0x1E,0x1F,0x1F,0x0E,0x00}; // Closed Right
;unsigned char PacMan3[8]={0x0E,0x17,0x1F,0x0F,0x1F,0x1F,0x0E,0x00}; // Open Left
;unsigned char PacMan4[8]={0x0E,0x17,0x1F,0x1F,0x1F,0x1F,0x0E,0x00}; // Closed Left
;signed char i = 0;
;signed char G = 0;
;signed char T = 0;
;void main(void)
; 0000 002F {

	.CSEG
_main:
; .FSTART _main
; 0000 0030     CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0031     CLKPR=0x04;
	LDI  R30,LOW(4)
	STS  97,R30
; 0000 0032 
; 0000 0033     ADMUX=ADC_VREF_TYPE; // ADC Voltage Reference: AVCC pin
	LDI  R30,LOW(64)
	STS  124,R30
; 0000 0034     // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On, ADC4: Off, ADC5: On
; 0000 0035     DIDR0=(0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (1<<ADC0D);
	LDI  R30,LOW(1)
	STS  126,R30
; 0000 0036     // ADC Auto Trigger Source: ADC Stopped
; 0000 0037     ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
	LDI  R30,LOW(131)
	STS  122,R30
; 0000 0038     ADCSRB=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 0039 
; 0000 003A     SetupLCD();
	RCALL _SetupLCD
; 0000 003B 
; 0000 003C     CreateChar(0,PacMan1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(_PacMan1)
	LDI  R27,HIGH(_PacMan1)
	RCALL _CreateChar
; 0000 003D     CreateChar(1,PacMan2);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(_PacMan2)
	LDI  R27,HIGH(_PacMan2)
	RCALL _CreateChar
; 0000 003E     CreateChar(2,PacMan3);
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(_PacMan3)
	LDI  R27,HIGH(_PacMan3)
	RCALL _CreateChar
; 0000 003F     CreateChar(3,PacMan4);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(_PacMan4)
	LDI  R27,HIGH(_PacMan4)
	RCALL _CreateChar
; 0000 0040 
; 0000 0041     PORTC.1=1;
	SBI  0x8,1
; 0000 0042 
; 0000 0043     while (1)
_0x2B:
; 0000 0044     {
; 0000 0045         message();
	RCALL _message
; 0000 0046         if (PINC.1==0&T==0) {T=1;}
	LDI  R26,0
	SBIC 0x6,1
	LDI  R26,1
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x0
	BREQ _0x2E
	LDI  R30,LOW(1)
	STS  _T,R30
; 0000 0047         if (PINC.1==1&T==0) {T=3; G=15;}
_0x2E:
	LDI  R26,0
	SBIC 0x6,1
	LDI  R26,1
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x0
	BREQ _0x2F
	LDI  R30,LOW(3)
	STS  _T,R30
	LDI  R30,LOW(15)
	STS  _G,R30
; 0000 0048         if (T==1){
_0x2F:
	LDS  R26,_T
	CPI  R26,LOW(0x1)
	BRNE _0x30
; 0000 0049             for (i=G;i<16;i++)
	RCALL SUBOPT_0x1
_0x32:
	LDS  R26,_i
	CPI  R26,LOW(0x10)
	BRGE _0x33
; 0000 004A             {
; 0000 004B                 G++;
	RCALL SUBOPT_0x2
; 0000 004C                 if (PINC.1==1) {T=3; G--; G--; break;} // If right up (1) toggle go to (3)
	SBIS 0x6,1
	RJMP _0x34
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x3
	RJMP _0x33
; 0000 004D                 MoveCursor(i,0);
_0x34:
	RCALL SUBOPT_0x4
; 0000 004E                 CharLCD(0);
	LDI  R26,LOW(0)
	RCALL _CharLCD
; 0000 004F                 delayPacMan();
	RCALL _delayPacMan
; 0000 0050                 MoveCursor(i,0);
	RCALL SUBOPT_0x4
; 0000 0051                 CharLCD(1);
	LDI  R26,LOW(1)
	RCALL _CharLCD
; 0000 0052                 delayPacMan();
	RCALL _delayPacMan
; 0000 0053                 MoveCursor(i,0);
	RCALL SUBOPT_0x4
; 0000 0054                 CharLCD(' ');
	LDI  R26,LOW(32)
	RCALL _CharLCD
; 0000 0055             }
	RCALL SUBOPT_0x5
	RJMP _0x32
_0x33:
; 0000 0056             if (T==1) {T=2;} // If right up (1) end same go to (2)
	LDS  R26,_T
	CPI  R26,LOW(0x1)
	BRNE _0x35
	LDI  R30,LOW(2)
	STS  _T,R30
; 0000 0057         }
_0x35:
; 0000 0058         if (T==2){
_0x30:
	LDS  R26,_T
	CPI  R26,LOW(0x2)
	BRNE _0x36
; 0000 0059             for (i=G;i>=0;i--)
	RCALL SUBOPT_0x1
_0x38:
	LDS  R26,_i
	CPI  R26,0
	BRLT _0x39
; 0000 005A             {
; 0000 005B                 G--;
	RCALL SUBOPT_0x6
; 0000 005C                 if (PINC.1==1) {T=4; G++; G++; break;} // If left down (2) toggle go to right down (4)
	SBIS 0x6,1
	RJMP _0x3A
	LDI  R30,LOW(4)
	STS  _T,R30
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x2
	RJMP _0x39
; 0000 005D                 MoveCursor(i,1);
_0x3A:
	RCALL SUBOPT_0x7
; 0000 005E                 CharLCD(2);
	LDI  R26,LOW(2)
	RCALL _CharLCD
; 0000 005F                 delayPacMan();
	RCALL _delayPacMan
; 0000 0060                 MoveCursor(i,1);
	RCALL SUBOPT_0x7
; 0000 0061                 CharLCD(3);
	LDI  R26,LOW(3)
	RCALL _CharLCD
; 0000 0062                 delayPacMan();
	RCALL _delayPacMan
; 0000 0063                 MoveCursor(i,1);
	RCALL SUBOPT_0x7
; 0000 0064                 CharLCD(' ');
	LDI  R26,LOW(32)
	RCALL _CharLCD
; 0000 0065 
; 0000 0066             }
	RCALL SUBOPT_0x8
	RJMP _0x38
_0x39:
; 0000 0067             if (T==2) {T=0;} // If left down (2) end then go to end
	LDS  R26,_T
	CPI  R26,LOW(0x2)
	BRNE _0x3B
	LDI  R30,LOW(0)
	STS  _T,R30
; 0000 0068         }
_0x3B:
; 0000 0069         if (T==3){
_0x36:
	LDS  R26,_T
	CPI  R26,LOW(0x3)
	BRNE _0x3C
; 0000 006A             for (i=G;i>=0;i--)
	RCALL SUBOPT_0x1
_0x3E:
	LDS  R26,_i
	CPI  R26,0
	BRLT _0x3F
; 0000 006B             {
; 0000 006C                 G--;
	RCALL SUBOPT_0x6
; 0000 006D                 if (PINC.1==0) {T=1; G++; G++; break;} // If left up (3) toggle go to (1)
	SBIC 0x6,1
	RJMP _0x40
	LDI  R30,LOW(1)
	STS  _T,R30
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x2
	RJMP _0x3F
; 0000 006E                 MoveCursor(i,0);
_0x40:
	RCALL SUBOPT_0x4
; 0000 006F                 CharLCD(2);
	LDI  R26,LOW(2)
	RCALL _CharLCD
; 0000 0070                 delayPacMan();
	RCALL _delayPacMan
; 0000 0071                 MoveCursor(i,0);
	RCALL SUBOPT_0x4
; 0000 0072                 CharLCD(3);
	LDI  R26,LOW(3)
	RCALL _CharLCD
; 0000 0073                 delayPacMan();
	RCALL _delayPacMan
; 0000 0074                 MoveCursor(i,0);
	RCALL SUBOPT_0x4
; 0000 0075                 CharLCD(' ');
	LDI  R26,LOW(32)
	RCALL _CharLCD
; 0000 0076             }
	RCALL SUBOPT_0x8
	RJMP _0x3E
_0x3F:
; 0000 0077             if (T==3) {T=4;} // If left up (3) end same go to (4)
	LDS  R26,_T
	CPI  R26,LOW(0x3)
	BRNE _0x41
	LDI  R30,LOW(4)
	STS  _T,R30
; 0000 0078         }
_0x41:
; 0000 0079         if (T==4){
_0x3C:
	LDS  R26,_T
	CPI  R26,LOW(0x4)
	BRNE _0x42
; 0000 007A             for (i=G;i<16;i++)
	RCALL SUBOPT_0x1
_0x44:
	LDS  R26,_i
	CPI  R26,LOW(0x10)
	BRGE _0x45
; 0000 007B             {
; 0000 007C                 G++;
	RCALL SUBOPT_0x2
; 0000 007D                 if (PINC.1==0) {T=2; G--; G--; break;} // If right down (4) toggle go to left down (2)
	SBIC 0x6,1
	RJMP _0x46
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x3
	RJMP _0x45
; 0000 007E                 MoveCursor(i,1);
_0x46:
	RCALL SUBOPT_0x7
; 0000 007F                 CharLCD(0);
	LDI  R26,LOW(0)
	RCALL _CharLCD
; 0000 0080                 delayPacMan();
	RCALL _delayPacMan
; 0000 0081                 MoveCursor(i,1);
	RCALL SUBOPT_0x7
; 0000 0082                 CharLCD(1);
	LDI  R26,LOW(1)
	RCALL _CharLCD
; 0000 0083                 delayPacMan();
	RCALL _delayPacMan
; 0000 0084                 MoveCursor(i,1);
	RCALL SUBOPT_0x7
; 0000 0085                 CharLCD(' ');
	LDI  R26,LOW(32)
	RCALL _CharLCD
; 0000 0086             }
	RCALL SUBOPT_0x5
	RJMP _0x44
_0x45:
; 0000 0087             if (T==4) {T=0;} // // If right down (4) end then go to end
	LDS  R26,_T
	CPI  R26,LOW(0x4)
	BRNE _0x47
	LDI  R30,LOW(0)
	STS  _T,R30
; 0000 0088         }
_0x47:
; 0000 0089 
; 0000 008A         //if (PINC.1==0&&S==0) {G=0;}
; 0000 008B         //if (PINC.1==0&&S==0) {G=15;}
; 0000 008C         //if (PINC.1==1&&S==0) {G=0;}
; 0000 008D         //if (PINC.1==1&&S==0) {G=15;}
; 0000 008E 
; 0000 008F     }
_0x42:
	RJMP _0x2B
; 0000 0090 }
_0x48:
	RJMP _0x48
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_cursor:
	.BYTE 0x1
_PacMan1:
	.BYTE 0x8
_PacMan2:
	.BYTE 0x8
_PacMan3:
	.BYTE 0x8
_PacMan4:
	.BYTE 0x8
_i:
	.BYTE 0x1
_G:
	.BYTE 0x1
_T:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x0:
	RCALL __EQB12
	MOV  R0,R30
	LDS  R26,_T
	LDI  R30,LOW(0)
	RCALL __EQB12
	AND  R30,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	LDS  R30,_G
	STS  _i,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x2:
	LDS  R30,_G
	SUBI R30,-LOW(1)
	STS  _G,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3:
	STS  _T,R30
	LDS  R30,_G
	SUBI R30,LOW(1)
	STS  _G,R30
	SUBI R30,LOW(1)
	STS  _G,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x4:
	LDS  R30,_i
	ST   -Y,R30
	LDI  R26,LOW(0)
	RJMP _MoveCursor

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	LDS  R30,_i
	SUBI R30,-LOW(1)
	STS  _i,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	LDS  R30,_G
	SUBI R30,LOW(1)
	STS  _G,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x7:
	LDS  R30,_i
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _MoveCursor

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8:
	LDS  R30,_i
	SUBI R30,LOW(1)
	STS  _i,R30
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	PUSH R26
	PUSH R27
	MOVW R26,R22
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	POP  R27
	POP  R26
	RET

__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xFA
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
