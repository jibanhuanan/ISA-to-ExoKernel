;Boot_Loader
;Origin adress
Org 0x7c00
		
		JMP START
		
		DB        0x90
        DB        "NoneOS_IPL" 		; 启动区的名称，不限定(8字节)
        DW        512            	; 每个扇区(sector)的大小,必须为512字节
        DB        1                	; 簇(cluster)的大小,必须为1个扇区
        DW        1                	; FAT的起始位置
        DB        2                	; FAT的个数,必须为2
        DW        224               ; 根目录的大小,一般设为244项
        DW        2880            	; 该磁盘的的大小,必须为2880扇区
        DB        0xf0            	; 磁盘的种类,必须为0xfd
        DW        9                	; FAT的长度,必须为9扇区 
        DW        18                ; 一个磁道(track)有几个扇区,必须为18 
        DW        2                	; 磁头数,必须为2 
        DD        0                	; 不使用分区,必须为0 
        DD        2880            	; 重写一次磁盘大小
        DB        0,0,0x29        	; 固定
        DD        0xffffffff        ; (可能是)卷标号码
        DB        "None_OS    "    		; 磁盘名称(11字节)
        DB        "FAT12   "        ; 磁盘格式名称(8字节)
        RESB      18                	; 先腾出18字节

;Initialize Display
LOGO：			DB '---------None OS---------'
MessageMBRin: 	DB 'Go to the MBR'
MessageMBRout:	DB 'out from MBR'
MessageAddr:	DB 'Memory Address is ----'
MessageCS:		DB 'Cs:????'
MessageDS:		DB 'Ds:????'
MessageES:		DB 'Es:????'
MessageSS:		DB 'Ss:????'

;START
START:
		CALL MBR
		CALL LOADER
		JMP C200H
;Initialize Reg 
MBR:
MOV 	AX , 7c0H
MOV 	DS , AX		;寄存器显示数据

MOV		SI , MessageMBRin;data
CALL	Display	
CALL	NextText;换行

MOV 	AX , 0x8000 ;Load地址
MOV 	ES , AX		;为程序进入加载的地址
RET

LOADER:
		

;Initialize Display
LOGO：			DB '---------None OS---------' , '!'
MessageMBRin: 	DB 'Go to the MBR'             , '!'
MessageMBRout:	DB 'out from MBR'              , '!'
MessageAddr:	DB 'Memory Address is ----'    , '!'
MessageCS:		DB 'Cs:????'                   , '!'
                  , '!'

Display:
		MOV 	AL , [SI]
		CMP		AL , '!'
		JE		RET
		INT		10H
		INC 	SI
		JMP		Display

NextText：
		DB		0X0a
		DB		0
		DB		7dfeh-$
		DB		0x55 , 0xaa
		




































