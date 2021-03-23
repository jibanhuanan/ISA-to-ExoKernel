;None OS

;此处缓冲区， 		地址可以改变一下
CYLS		EQU		0x0ff0						;设置值启动区	
VideoMODE   EQU		0x0ff2      				;颜色信息、位数
ScreenX     EQU		0x0ff3      				;分辨率x
ScreenY     EQU		0x0ff6      				;分辨率y
VideoRAM    EQU		0x0ff8      				;图像缓冲区开始地址


;显卡显示的色彩有待显示，分辨率的大小是多大，需要更改
			ORG		0xC200						;程序装在装载地址
			MOV		AL , 0x13					;VGA显卡，这个色彩和分辨率的大小，看硬件具体信息
			MOV		AH , 0x00
            INT		0x10 		
            MOV		BYTE  [VideoMODE] , 8		;记录画面
            MOV		WORD  [ScreenX]   , 320		;分辨率大小，在此处更改
            MOV		WORD  [ScreenY]	  , 200
            MOV		DWORD [VideoRAM]  , 0xa0000
            

;调用BIOSsh上面的   键盘指示灯状态
			MOV		AH , 0x02					
			INT		0x16						;键盘BIOS
			MOV		[LEDS] , AL
		
;初始化中断

			MOV 	AL , 0xff
			OUT 	0x21 , AL
			NOP									;连续输入、输出指令建议NOP
			OUT		0xa1 , AL
			
			CLI   								;CPU级别中断

;CPU调用1MB以上的空间
			
			CALL	waitkbout
			MOV		AL , 0xd1
			OUT		0x64 , AL
			CALL	waitkbout
			MOV		AL , 0xdf
			OUT		0x60 , AL
			CALL	waitkbout
			
;切换到保护模式			

[INSTRSET "i486p"]

			LGDT	[GTR0]						;临时的GDT
			MOV		EAX , CR0
			AND 	EAX , 0x7fffffff  			;设bit 31位为0,禁止分页
			OR 		EAX , 0x00000001			;设bit0为1，切换到保护模式
			MOV		CR0 , EAX
			JMP		pipelineflush
			
pipelineflush:
			MOV		AX , 1 * 8					;可以读写的段32bit
			MOV		DS , AX
			MOV		ES , AX
			MOV		FS , AX
			MOV		GS , AX
			MOV		SS , AX
			
;磁盘数据转移,从7c00开始加载，但是减去MBR的512字节

			MOV		ESI , bootpack
			MOV		EDI , BOTPAK
			MOV		ECX , 512 * 1024 / 4
			CALL	memcpy
			
			MOV		ESI , 0x7c00
			MOV		EDI , DSKCAC
			MOV		ECX , 512 / 4
			CALL	memcpy
			
			MOV		ESI , DSKCAC0 + 512
			MOV		EDI , DSKCAC + 512
			MOV		ECX , 0		
			MOV		CL  , BYTE [CYLS]
			IMUL 	ECX , 512 * 18* 2 / 4		
			SUB 	ECX , 512 / 4		
			CALL 	memcpy	
			
;启动bootpack			
			MOV		EBX,BOTPAK
			MOV		ECX,[EBX+16]
			ADD		ECX,3			
			SHR		ECX,2			
			JZ		skip			
			MOV		ESI,[EBX+20]	
			ADD		ESI,EBX
			MOV		EDI,[EBX+12]	
			CALL	memcpy
skip:
			MOV		ESP,[EBX+12]	
			JMP		DWORD 2*8:0x0000001b 	
			
waitkbdout:
			IN		 AL,0x64
			AND		 AL,0x02
			JNZ		waitkbdout		 
			RET			
			
memcpy:
			MOV		EAX,[ESI]
			ADD		ESI,4
			MOV		[EDI],EAX
			ADD		EDI,4
			SUB		ECX,1
			JNZ		memcpy			
			RET


			ALIGNB	16
GDT0:
			RESB	8				
			DW		0xffff,0x0000,0x9200,0x00cf	
			DW		0xffff,0x0000,0x9a28,0x0047	
	
			DW		0
GDTR0:
			DW		8*3-1
			DD		GDT0

			ALIGNB	16
			
bootpack:			
			
			
			
			
			
			
			