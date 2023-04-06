
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
_0x22:
	.DB  0xE3,0x3
_0x0:
	.DB  0x20,0x50,0x65,0x6F,0x70,0x6C,0x65,0x20
	.DB  0x43,0x6F,0x75,0x6E,0x74,0x65,0x72,0x0
	.DB  0x25,0x30,0x30,0x33,0x69,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  _num
	.DW  _0x22*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

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
	LD   R16,Y+
	RET
; .FEND
_WriteComandLCD:
; .FSTART _WriteComandLCD
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
;	Comando -> R17
;	tempComando -> R16
	CBI __lcd_port,__lcd_RS
	RJMP _0x20A0003
; .FEND
_CharLCD:
; .FSTART _CharLCD
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
;	dato -> R17
;	tempdato -> R16
	SBI __lcd_port,__lcd_RS
_0x20A0003:
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
	RCALL SUBOPT_0x0
;	Mensaje -> R17,R18
;	i -> R16
_0x10:
	RCALL SUBOPT_0x1
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
	RJMP _0x20A0002
; .FEND
;	Mensaje -> R19,R20
;	tiempo -> R17,R18
;	i -> R16
_StringLCDVar:
; .FSTART _StringLCDVar
	RCALL SUBOPT_0x0
;	Mensaje -> R17,R18
;	i -> R16
_0x16:
	RCALL SUBOPT_0x1
	LD   R26,Z
	RCALL _CharLCD
	__GETW2R 17,18
	CLR  R30
	ADD  R26,R16
	ADC  R27,R30
	LD   R30,X
	CPI  R30,0
	BRNE _0x16
	RCALL __LOADLOCR3
	RJMP _0x20A0002
; .FEND
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
	RJMP _0x3B
_0x1B:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x1C
	MOV  R26,R17
	SUBI R26,-LOW(192)
	RJMP _0x3B
_0x1C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x1D
	MOV  R26,R17
	SUBI R26,-LOW(148)
	RJMP _0x3B
_0x1D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x1A
	MOV  R26,R17
	SUBI R26,-LOW(212)
_0x3B:
	RCALL _WriteComandLCD
_0x1A:
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x20A0002:
	ADIW R28,3
	RET
; .FEND
;	NoCaracter -> R19
;	datos -> R17,R18
;	i -> R16
;#include <stdio.h>
;#include <stdlib.h>
;
;unsigned int num = 995;

	.DSEG
;char Cadena[17];
;void main(void)
; 0000 0014 {

	.CSEG
_main:
; .FSTART _main
; 0000 0015     CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0016     CLKPR=0x04;
	LDI  R30,LOW(4)
	STS  97,R30
; 0000 0017     SetupLCD();
	RCALL _SetupLCD
; 0000 0018     StringLCD(" People Counter");
	__POINTW2FN _0x0,0
	RCALL _StringLCD
; 0000 0019     PORTC.0=1;
	SBI  0x8,0
; 0000 001A     PORTC.1=1;
	SBI  0x8,1
; 0000 001B     PORTC.2=1;
	SBI  0x8,2
; 0000 001C     sprintf(Cadena,"%003i",num);
	RCALL SUBOPT_0x2
; 0000 001D     MoveCursor(6,1);
; 0000 001E     StringLCDVar(Cadena);
; 0000 001F 
; 0000 0020     while (1)
_0x29:
; 0000 0021     {
; 0000 0022 
; 0000 0023         if (PINC.0==0)
	SBIC 0x6,0
	RJMP _0x2C
; 0000 0024         {
; 0000 0025             //Clear Counter
; 0000 0026             num = 0;
	LDI  R30,LOW(0)
	STS  _num,R30
	STS  _num+1,R30
; 0000 0027             sprintf(Cadena,"%003i",num);
	RCALL SUBOPT_0x2
; 0000 0028             MoveCursor(6,1);
; 0000 0029             StringLCDVar(Cadena);
; 0000 002A             delay_ms(30); // Delay for bounce when PRESSING
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 002B             while (PINC.0==0); //Ignore everything until first RELEASE
_0x2D:
	SBIS 0x6,0
	RJMP _0x2D
; 0000 002C             delay_ms(10); // Delay for bounce at RELEASE
	LDI  R26,LOW(10)
	LDI  R27,0
	RCALL _delay_ms
; 0000 002D         }
; 0000 002E 
; 0000 002F         if (PINC.1==0)
_0x2C:
	SBIC 0x6,1
	RJMP _0x30
; 0000 0030         {
; 0000 0031             //If not at 0 minus one
; 0000 0032             if (num > 0)
	RCALL SUBOPT_0x3
	RCALL __CPW02
	BRSH _0x31
; 0000 0033             {
; 0000 0034                 num--;
	RCALL SUBOPT_0x4
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 0035                 sprintf(Cadena,"%003i",num);
	RCALL SUBOPT_0x2
; 0000 0036                 MoveCursor(6,1);
; 0000 0037                 StringLCDVar(Cadena);
; 0000 0038             }
; 0000 0039             delay_ms(30); // Delay for bounce when PRESSING
_0x31:
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 003A             while (PINC.1==0); //Ignore everything until first RELEASE
_0x32:
	SBIS 0x6,1
	RJMP _0x32
; 0000 003B             delay_ms(10); // Delay for bounce at RELEASE
	LDI  R26,LOW(10)
	LDI  R27,0
	RCALL _delay_ms
; 0000 003C         }
; 0000 003D 
; 0000 003E 
; 0000 003F         if (PINC.2==0)
_0x30:
	SBIC 0x6,2
	RJMP _0x35
; 0000 0040         {
; 0000 0041             //If not at 999 add one
; 0000 0042             if (num < 999)
	RCALL SUBOPT_0x3
	CPI  R26,LOW(0x3E7)
	LDI  R30,HIGH(0x3E7)
	CPC  R27,R30
	BRSH _0x36
; 0000 0043             {
; 0000 0044                 num++;
	RCALL SUBOPT_0x4
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 0045                 sprintf(Cadena,"%003i",num);
	RCALL SUBOPT_0x2
; 0000 0046                 MoveCursor(6,1);
; 0000 0047                 StringLCDVar(Cadena);
; 0000 0048             }
; 0000 0049             delay_ms(30); // Delay for bounce when PRESSING
_0x36:
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 004A             while (PINC.2==0); //Ignore everything until first RELEASE
_0x37:
	SBIS 0x6,2
	RJMP _0x37
; 0000 004B             delay_ms(10); // Delay for bounce at RELEASE
	LDI  R26,LOW(10)
	LDI  R27,0
	RCALL _delay_ms
; 0000 004C         }
; 0000 004D 
; 0000 004E 
; 0000 004F     }
_0x35:
	RJMP _0x29
; 0000 0050 }
_0x3A:
	RJMP _0x3A
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
_put_buff_G100:
; .FSTART _put_buff_G100
	RCALL __SAVELOCR5
	MOVW R18,R26
	LDD  R20,Y+5
	ADIW R26,2
	RCALL __GETW1P
	SBIW R30,0
	BREQ _0x2000016
	MOVW R26,R18
	ADIW R26,4
	RCALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000018
	__CPWRN 16,17,2
	BRLO _0x2000019
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1RNS 18,4
_0x2000018:
	MOVW R26,R18
	ADIW R26,2
	RCALL SUBOPT_0x5
	SBIW R30,1
	ST   Z,R20
_0x2000019:
	MOVW R26,R18
	RCALL __GETW1P
	TST  R31
	BRMI _0x200001A
	RCALL SUBOPT_0x5
_0x200001A:
	RJMP _0x200001B
_0x2000016:
	MOVW R26,R18
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x200001B:
	RCALL __LOADLOCR5
	ADIW R28,6
	RET
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,11
	RCALL __SAVELOCR6
	LDI  R16,0
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x200001C:
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	ADIW R30,1
	STD  Y+23,R30
	STD  Y+23+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x200001E
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x2000022
	CPI  R19,37
	BRNE _0x2000023
	LDI  R16,LOW(1)
	RJMP _0x2000024
_0x2000023:
	RCALL SUBOPT_0x6
_0x2000024:
	RJMP _0x2000021
_0x2000022:
	CPI  R30,LOW(0x1)
	BRNE _0x2000025
	CPI  R19,37
	BRNE _0x2000026
	RCALL SUBOPT_0x6
	RJMP _0x20000DB
_0x2000026:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0x2000027
	LDI  R17,LOW(1)
	RJMP _0x2000021
_0x2000027:
	CPI  R19,43
	BRNE _0x2000028
	LDI  R21,LOW(43)
	RJMP _0x2000021
_0x2000028:
	CPI  R19,32
	BRNE _0x2000029
	LDI  R21,LOW(32)
	RJMP _0x2000021
_0x2000029:
	RJMP _0x200002A
_0x2000025:
	CPI  R30,LOW(0x2)
	BRNE _0x200002B
_0x200002A:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0x200002C
	ORI  R17,LOW(128)
	RJMP _0x2000021
_0x200002C:
	RJMP _0x200002D
_0x200002B:
	CPI  R30,LOW(0x3)
	BRNE _0x200002E
_0x200002D:
	CPI  R19,48
	BRLO _0x2000030
	CPI  R19,58
	BRLO _0x2000031
_0x2000030:
	RJMP _0x200002F
_0x2000031:
	LDI  R26,LOW(10)
	MUL  R20,R26
	MOV  R20,R0
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x2000021
_0x200002F:
	CPI  R19,108
	BRNE _0x2000032
	ORI  R17,LOW(2)
	LDI  R16,LOW(5)
	RJMP _0x2000021
_0x2000032:
	RJMP _0x2000033
_0x200002E:
	CPI  R30,LOW(0x5)
	BREQ PC+2
	RJMP _0x2000021
_0x2000033:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x2000038
	RCALL SUBOPT_0x7
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x8
	RJMP _0x2000039
_0x2000038:
	CPI  R30,LOW(0x73)
	BRNE _0x200003B
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x9
	RCALL _strlen
	MOV  R16,R30
	RJMP _0x200003C
_0x200003B:
	CPI  R30,LOW(0x70)
	BRNE _0x200003E
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x9
	RCALL _strlenf
	MOV  R16,R30
	ORI  R17,LOW(8)
_0x200003C:
	ANDI R17,LOW(127)
	LDI  R30,LOW(0)
	STD  Y+16,R30
	LDI  R18,LOW(0)
	RJMP _0x200003F
_0x200003E:
	CPI  R30,LOW(0x64)
	BREQ _0x2000042
	CPI  R30,LOW(0x69)
	BRNE _0x2000043
_0x2000042:
	ORI  R17,LOW(4)
	RJMP _0x2000044
_0x2000043:
	CPI  R30,LOW(0x75)
	BRNE _0x2000045
_0x2000044:
	LDI  R30,LOW(10)
	STD  Y+16,R30
	SBRS R17,1
	RJMP _0x2000046
	__GETD1N 0x3B9ACA00
	RCALL SUBOPT_0xA
	LDI  R16,LOW(10)
	RJMP _0x2000047
_0x2000046:
	__GETD1N 0x2710
	RCALL SUBOPT_0xA
	LDI  R16,LOW(5)
	RJMP _0x2000047
_0x2000045:
	CPI  R30,LOW(0x58)
	BRNE _0x2000049
	ORI  R17,LOW(8)
	RJMP _0x200004A
_0x2000049:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x200007D
_0x200004A:
	LDI  R30,LOW(16)
	STD  Y+16,R30
	SBRS R17,1
	RJMP _0x200004C
	__GETD1N 0x10000000
	RCALL SUBOPT_0xA
	LDI  R16,LOW(8)
	RJMP _0x2000047
_0x200004C:
	__GETD1N 0x1000
	RCALL SUBOPT_0xA
	LDI  R16,LOW(4)
_0x2000047:
	SBRS R17,1
	RJMP _0x200004D
	RCALL SUBOPT_0x7
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	RCALL __GETD1P
	RJMP _0x20000DC
_0x200004D:
	SBRS R17,2
	RJMP _0x200004F
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0xB
	RCALL __CWD1
	RJMP _0x20000DC
_0x200004F:
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0xB
	CLR  R22
	CLR  R23
_0x20000DC:
	__PUTD1S 12
	SBRS R17,2
	RJMP _0x2000051
	LDD  R26,Y+15
	TST  R26
	BRPL _0x2000052
	__GETD1S 12
	RCALL __ANEGD1
	RCALL SUBOPT_0xC
	LDI  R21,LOW(45)
_0x2000052:
	CPI  R21,0
	BREQ _0x2000053
	SUBI R16,-LOW(1)
	RJMP _0x2000054
_0x2000053:
	ANDI R17,LOW(251)
_0x2000054:
_0x2000051:
_0x200003F:
	SBRC R17,0
	RJMP _0x2000055
_0x2000056:
	CP   R16,R20
	BRSH _0x2000058
	SBRS R17,7
	RJMP _0x2000059
	SBRS R17,2
	RJMP _0x200005A
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0x200005B
_0x200005A:
	LDI  R19,LOW(48)
_0x200005B:
	RJMP _0x200005C
_0x2000059:
	LDI  R19,LOW(32)
_0x200005C:
	RCALL SUBOPT_0x6
	SUBI R20,LOW(1)
	RJMP _0x2000056
_0x2000058:
_0x2000055:
	MOV  R18,R16
	LDD  R30,Y+16
	CPI  R30,0
	BRNE _0x200005D
_0x200005E:
	CPI  R18,0
	BREQ _0x2000060
	SBRS R17,3
	RJMP _0x2000061
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R19,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000062
_0x2000061:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R19,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000062:
	RCALL SUBOPT_0x6
	CPI  R20,0
	BREQ _0x2000063
	SUBI R20,LOW(1)
_0x2000063:
	SUBI R18,LOW(1)
	RJMP _0x200005E
_0x2000060:
	RJMP _0x2000064
_0x200005D:
_0x2000066:
	RCALL SUBOPT_0xD
	RCALL __DIVD21U
	MOV  R19,R30
	CPI  R19,10
	BRLO _0x2000068
	SBRS R17,3
	RJMP _0x2000069
	SUBI R19,-LOW(55)
	RJMP _0x200006A
_0x2000069:
	SUBI R19,-LOW(87)
_0x200006A:
	RJMP _0x200006B
_0x2000068:
	SUBI R19,-LOW(48)
_0x200006B:
	SBRC R17,4
	RJMP _0x200006D
	CPI  R19,49
	BRSH _0x200006F
	RCALL SUBOPT_0xE
	__CPD2N 0x1
	BRNE _0x200006E
_0x200006F:
	RJMP _0x2000071
_0x200006E:
	CP   R20,R18
	BRLO _0x2000073
	SBRS R17,0
	RJMP _0x2000074
_0x2000073:
	RJMP _0x2000072
_0x2000074:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0x2000075
	LDI  R19,LOW(48)
_0x2000071:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0x2000076
	ANDI R17,LOW(251)
	ST   -Y,R21
	RCALL SUBOPT_0x8
	CPI  R20,0
	BREQ _0x2000077
	SUBI R20,LOW(1)
_0x2000077:
_0x2000076:
_0x2000075:
_0x200006D:
	RCALL SUBOPT_0x6
	CPI  R20,0
	BREQ _0x2000078
	SUBI R20,LOW(1)
_0x2000078:
_0x2000072:
	SUBI R18,LOW(1)
	RCALL SUBOPT_0xD
	RCALL __MODD21U
	RCALL SUBOPT_0xC
	LDD  R30,Y+16
	RCALL SUBOPT_0xE
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __DIVD21U
	RCALL SUBOPT_0xA
	__GETD1S 8
	RCALL __CPD10
	BREQ _0x2000067
	RJMP _0x2000066
_0x2000067:
_0x2000064:
	SBRS R17,0
	RJMP _0x2000079
_0x200007A:
	CPI  R20,0
	BREQ _0x200007C
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x8
	RJMP _0x200007A
_0x200007C:
_0x2000079:
_0x200007D:
_0x2000039:
_0x20000DB:
	LDI  R16,LOW(0)
_0x2000021:
	RJMP _0x200001C
_0x200001E:
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	LD   R30,X+
	LD   R31,X+
	RCALL __LOADLOCR6
	ADIW R28,25
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	RCALL __SAVELOCR6
	MOVW R30,R28
	RCALL __ADDW1R15
	__GETWRZ 20,21,14
	MOV  R0,R20
	OR   R0,R21
	BRNE _0x200007E
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20A0001
_0x200007E:
	MOVW R26,R28
	ADIW R26,8
	RCALL __ADDW2R15
	MOVW R16,R26
	__PUTWSR 20,21,8
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	MOVW R26,R28
	ADIW R26,12
	RCALL __ADDW2R15
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,12
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20A0001:
	RCALL __LOADLOCR6
	ADIW R28,12
	POP  R15
	RET
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG

	.DSEG
_cursor:
	.BYTE 0x1
_num:
	.BYTE 0x2
_Cadena:
	.BYTE 0x11
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	RCALL __SAVELOCR3
	__PUTW2R 17,18
	LDI  R16,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1:
	MOV  R30,R16
	SUBI R16,-1
	LDI  R31,0
	ADD  R30,R17
	ADC  R31,R18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:70 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(_Cadena)
	LDI  R31,HIGH(_Cadena)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,16
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_num
	LDS  R31,_num+1
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _sprintf
	ADIW R28,8
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _MoveCursor
	LDI  R26,LOW(_Cadena)
	LDI  R27,HIGH(_Cadena)
	RJMP _StringLCDVar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	LDS  R26,_num
	LDS  R27,_num+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(_num)
	LDI  R27,HIGH(_num)
	LD   R30,X+
	LD   R31,X+
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x6:
	ST   -Y,R19
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x7:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	SBIW R30,4
	STD  Y+21,R30
	STD  Y+21+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x8:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x9:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xA:
	__PUTD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	RCALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xD:
	__GETD1S 8
	__GETD2S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	__GETD2S 8
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
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

__ADDW1R15:
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	RET

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	MOVW R20,R0
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
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
