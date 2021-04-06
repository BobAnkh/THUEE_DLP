.text
j MAIN
j INTERRUPT
j EXCEPTION
MAIN:
li $t1, 0x00000014
jr $t1
STOREDATA:
move $s4, $zero
# 数码管表
addi $t0, $zero, 0x003f
sw $t0, 0($s4)
addi $t0, $zero, 0x0006
sw $t0, 4($s4)
addi $t0, $zero, 0x005b
sw $t0, 8($s4)
addi $t0, $zero, 0x004b
sw $t0, 12($s4)
addi $t0, $zero, 0x0066
sw $t0, 16($s4)
addi $t0, $zero, 0x006d
sw $t0, 20($s4)
addi $t0, $zero, 0x007d
sw $t0, 24($s4)
addi $t0, $zero, 0x0007
sw $t0, 28($s4)
addi $t0, $zero, 0x007f
sw $t0, 32($s4)
addi $t0, $zero, 0x006f
sw $t0, 36($s4)
addi $t0, $zero, 0x0077
sw $t0, 40($s4)
addi $t0, $zero, 0x007c
sw $t0, 44($s4)
addi $t0, $zero, 0x0039
sw $t0, 48($s4)
addi $t0, $zero, 0x005e
sw $t0, 52($s4)
addi $t0, $zero, 0x0079
sw $t0, 56($s4)
addi $t0, $zero, 0x0071
sw $t0, 60($s4)
# 内存中的数开始加载
addi $t0, $zero, 0x3dd6
sw $t0, 64($s4)
addi $t0, $zero, 0x3fc9
sw $t0, 68($s4)
addi $t0, $zero, 0x78c5
sw $t0, 72($s4)
addi $t0, $zero, 0x50c0
sw $t0, 76($s4)
addi $t0, $zero, 0x18e7
sw $t0, 80($s4)
addi $t0, $zero, 0x6e
sw $t0, 84($s4)
addi $t0, $zero, 0x5ab4
sw $t0, 88($s4)
addi $t0, $zero, 0x5bb
sw $t0, 92($s4)
addi $t0, $zero, 0x49a0
sw $t0, 96($s4)
addi $t0, $zero, 0x3282
sw $t0, 100($s4)
addi $t0, $zero, 0x43f1
sw $t0, 104($s4)
addi $t0, $zero, 0x779
sw $t0, 108($s4)
addi $t0, $zero, 0x11f4
sw $t0, 112($s4)
addi $t0, $zero, 0x1757
sw $t0, 116($s4)
addi $t0, $zero, 0x6f1a
sw $t0, 120($s4)
addi $t0, $zero, 0x584b
sw $t0, 124($s4)
addi $t0, $zero, 0x4fd2
sw $t0, 128($s4)
addi $t0, $zero, 0x3989
sw $t0, 132($s4)
addi $t0, $zero, 0x73a5
sw $t0, 136($s4)
addi $t0, $zero, 0x4d19
sw $t0, 140($s4)
addi $t0, $zero, 0x15d
sw $t0, 144($s4)
addi $t0, $zero, 0x2ab6
sw $t0, 148($s4)
addi $t0, $zero, 0x4b83
sw $t0, 152($s4)
addi $t0, $zero, 0x2f7
sw $t0, 156($s4)
addi $t0, $zero, 0x3f59
sw $t0, 160($s4)
addi $t0, $zero, 0x5adb
sw $t0, 164($s4)
addi $t0, $zero, 0x1093
sw $t0, 168($s4)
addi $t0, $zero, 0x547c
sw $t0, 172($s4)
addi $t0, $zero, 0x5925
sw $t0, 176($s4)
addi $t0, $zero, 0x1a25
sw $t0, 180($s4)
addi $t0, $zero, 0x3c3b
sw $t0, 184($s4)
addi $t0, $zero, 0x75ed
sw $t0, 188($s4)
addi $t0, $zero, 0x7fd3
sw $t0, 192($s4)
addi $t0, $zero, 0x604e
sw $t0, 196($s4)
addi $t0, $zero, 0x7d0c
sw $t0, 200($s4)
addi $t0, $zero, 0x8aa
sw $t0, 204($s4)
addi $t0, $zero, 0x5802
sw $t0, 208($s4)
addi $t0, $zero, 0x7e4a
sw $t0, 212($s4)
addi $t0, $zero, 0x6b2f
sw $t0, 216($s4)
addi $t0, $zero, 0x4dd1
sw $t0, 220($s4)
addi $t0, $zero, 0x4b83
sw $t0, 224($s4)
addi $t0, $zero, 0x7ef
sw $t0, 228($s4)
addi $t0, $zero, 0x5d0f
sw $t0, 232($s4)
addi $t0, $zero, 0x6b21
sw $t0, 236($s4)
addi $t0, $zero, 0x5896
sw $t0, 240($s4)
addi $t0, $zero, 0x78b6
sw $t0, 244($s4)
addi $t0, $zero, 0x1db8
sw $t0, 248($s4)
addi $t0, $zero, 0x6330
sw $t0, 252($s4)
addi $t0, $zero, 0x40bf
sw $t0, 256($s4)
addi $t0, $zero, 0x1e14
sw $t0, 260($s4)
addi $t0, $zero, 0x4368
sw $t0, 264($s4)
addi $t0, $zero, 0x1e5a
sw $t0, 268($s4)
addi $t0, $zero, 0x5f6
sw $t0, 272($s4)
addi $t0, $zero, 0x5977
sw $t0, 276($s4)
addi $t0, $zero, 0xe13
sw $t0, 280($s4)
addi $t0, $zero, 0x7d25
sw $t0, 284($s4)
addi $t0, $zero, 0x4d8e
sw $t0, 288($s4)
addi $t0, $zero, 0x418d
sw $t0, 292($s4)
addi $t0, $zero, 0x7384
sw $t0, 296($s4)
addi $t0, $zero, 0x70b8
sw $t0, 300($s4)
addi $t0, $zero, 0x16c6
sw $t0, 304($s4)
addi $t0, $zero, 0x7fc1
sw $t0, 308($s4)
addi $t0, $zero, 0x6848
sw $t0, 312($s4)
addi $t0, $zero, 0x5c2
sw $t0, 316($s4)
addi $t0, $zero, 0x72cf
sw $t0, 320($s4)
addi $t0, $zero, 0x200a
sw $t0, 324($s4)
addi $t0, $zero, 0x4740
sw $t0, 328($s4)
addi $t0, $zero, 0x1fad
sw $t0, 332($s4)
addi $t0, $zero, 0xe83
sw $t0, 336($s4)
addi $t0, $zero, 0x4261
sw $t0, 340($s4)
addi $t0, $zero, 0x366c
sw $t0, 344($s4)
addi $t0, $zero, 0x6643
sw $t0, 348($s4)
addi $t0, $zero, 0x127f
sw $t0, 352($s4)
addi $t0, $zero, 0x31f4
sw $t0, 356($s4)
addi $t0, $zero, 0x582d
sw $t0, 360($s4)
addi $t0, $zero, 0x6ffd
sw $t0, 364($s4)
addi $t0, $zero, 0x5687
sw $t0, 368($s4)
addi $t0, $zero, 0x1b5f
sw $t0, 372($s4)
addi $t0, $zero, 0x5abb
sw $t0, 376($s4)
addi $t0, $zero, 0x7553
sw $t0, 380($s4)
addi $t0, $zero, 0x6861
sw $t0, 384($s4)
addi $t0, $zero, 0x6e1d
sw $t0, 388($s4)
addi $t0, $zero, 0x35bd
sw $t0, 392($s4)
addi $t0, $zero, 0x7bbc
sw $t0, 396($s4)
addi $t0, $zero, 0x5d62
sw $t0, 400($s4)
addi $t0, $zero, 0x7580
sw $t0, 404($s4)
addi $t0, $zero, 0x5250
sw $t0, 408($s4)
addi $t0, $zero, 0x11c1
sw $t0, 412($s4)
addi $t0, $zero, 0x3865
sw $t0, 416($s4)
addi $t0, $zero, 0x64fa
sw $t0, 420($s4)
addi $t0, $zero, 0x1dab
sw $t0, 424($s4)
addi $t0, $zero, 0x7945
sw $t0, 428($s4)
addi $t0, $zero, 0x5620
sw $t0, 432($s4)
addi $t0, $zero, 0x1c08
sw $t0, 436($s4)
addi $t0, $zero, 0x31cd
sw $t0, 440($s4)
addi $t0, $zero, 0x14b8
sw $t0, 444($s4)
addi $t0, $zero, 0x5d99
sw $t0, 448($s4)
addi $t0, $zero, 0x6c9d
sw $t0, 452($s4)
addi $t0, $zero, 0x27aa
sw $t0, 456($s4)
addi $t0, $zero, 0x72a1
sw $t0, 460($s4)
addi $t0, $zero, 0x533f
sw $t0, 464($s4)
addi $t0, $zero, 0x6cc2
sw $t0, 468($s4)
addi $t0, $zero, 0xe41
sw $t0, 472($s4)
addi $t0, $zero, 0x6c6a
sw $t0, 476($s4)
addi $t0, $zero, 0x2981
sw $t0, 480($s4)
addi $t0, $zero, 0x5783
sw $t0, 484($s4)
addi $t0, $zero, 0x748d
sw $t0, 488($s4)
addi $t0, $zero, 0x3e81
sw $t0, 492($s4)
addi $t0, $zero, 0x5c13
sw $t0, 496($s4)
addi $t0, $zero, 0x478e
sw $t0, 500($s4)
addi $t0, $zero, 0x67f4
sw $t0, 504($s4)
addi $t0, $zero, 0x6bf4
sw $t0, 508($s4)
addi $t0, $zero, 0x2c17
sw $t0, 512($s4)
addi $t0, $zero, 0x2126
sw $t0, 516($s4)
addi $t0, $zero, 0x5004
sw $t0, 520($s4)
addi $t0, $zero, 0x7fa6
sw $t0, 524($s4)
addi $t0, $zero, 0x3d2a
sw $t0, 528($s4)
addi $t0, $zero, 0x143f
sw $t0, 532($s4)
addi $t0, $zero, 0x2b3e
sw $t0, 536($s4)
addi $t0, $zero, 0x4a73
sw $t0, 540($s4)
addi $t0, $zero, 0x7ef4
sw $t0, 544($s4)
addi $t0, $zero, 0x141f
sw $t0, 548($s4)
addi $t0, $zero, 0x50a3
sw $t0, 552($s4)
addi $t0, $zero, 0x75a4
sw $t0, 556($s4)
addi $t0, $zero, 0x3a25
sw $t0, 560($s4)
addi $t0, $zero, 0xf93
sw $t0, 564($s4)
addi $t0, $zero, 0x591d
sw $t0, 568($s4)
addi $t0, $zero, 0x2578
sw $t0, 572($s4)
#内存中的数结束加载
PREPARE:
li $s4, 0x40000008		#s4是定时器TCON地址
addi $t0, $zero, 0
sw $t0, 0($s4)			#确认关闭定时器
addi $s5, $s4, -4		#s5是定时器TL地址
addi $t0, $zero, -101
sw $t0, 0($s5)		
addi $s5, $s4, -8		#s5是定时器TH地址
addi $t0, $zero, -101
sw $t0, 0($s5)			#每1us中断一次
addi $sp, $zero,0x0400	#设置栈顶地址
li $s5, 0x40000014  	#s5是系统计时器地址
lw $s6, 0($s5)			#将起始时刻时钟值读出

MAINSORTFUNC:
li $s0, 64	    		# 数据基地址 
li $s1, 128				# 数据数量
move $a0, $s0			# $a0 = $s0 
move $a1, $s1			# $a1 = $s1
jal BUBSORT				# 跳转到 BUBSORT 并保存下一条指令位置到 $ra

BEFOREEND:
lw $t0, 0($s5)			#将结束时刻时钟值读出
sub $v0, $t0, $s6		#v0是时钟周期数地址
# 将内存中的128个数全部读出来检查
addi $t1, $zero, 128	# 数据个数
addi $t2, $zero, 64		# 数据基地址
CHECK:
beq $t1, $zero, ENDCHECK
addi $t1, $t1, -1
lw $t3, 0($t2)
addi $t2, $t2, 4
j CHECK
ENDCHECK:
addi $t0, $zero, 3
sw $t0, 0($s4)			#使能中断定时器
li $s5, 0x40000010		#s5是七段数码管地址
addi $s6, $zero, 0

Loop:
beq $zero, $zero, Loop	# 结束

SWAP:
sll $t0, $a1, 2			# $t0 = $a1 << 2
add $t0, $t0, $a0		# $t0 = $t0 + $a0
lw $t1, 0($t0)			# t1 = v[k]
lw $t2, 4($t0)			# t2 = v[k+1]
sw $t2, 0($t0)			# v[k] = t2
sw t1, 4($t0)			# v[k+1] = t1
move $v0, $zero			# $v0 = $zero
jr $ra				    # 跳转到 $ra

BUBSORT:
# 保护现场
addi $sp, $sp, -12	    # $sp = $sp - 12
sw $ra, 0($sp)			# $ra入栈
sw $s0, 4($sp)			# $s0入栈
sw $s1, 8($sp)			# $s1入栈

move $s2, $a0			# $s2 = $a0 是v[]
move $s3, $a1			# $s3 = $a1 是n
# i = 0
li $s0, 0				# $s0 = 0 
FOR1:
slt $t0, $s0, $s3       # i<n
beq $t0, $zero, FOREND1	# if $t0 == $zero then FOREND
# j = i - 1
addi $s1, $s0, -1		# $s1 = $s0 - 1
FOR2:
sge $t1, $s1, $zero     # j>=0
beq $t1, $zero, FOREND2	# if $t1 == $zero then FOREND2
sll $t2, $s1, 2			# $t2 = $s1 << 2
add $t2, $s2, $t2		# $t2 = $s2 + $t2 是v[j]
lw $t3, 0($t2)			# v[j]
lw $t4, 4($t2)			# v[j+1]
sgt $t2, $t3, $t4	    # v[j] > v[j+1]
and $t1, $t1, $t2       # j>=0 && v[j] > v[j+1]
beq $t1, $zero, FOREND2	# if $t1 == $zero then FOREND2
move $a0, $s2			# $a0 = $s2
move $a1, $s1			# $a1 = $s1
jal SWAP				# 跳转到 SWAP 并保存下一条指令位置到 $ra
addi $s1, $s1, -1		# $s1 = $s1 - 1
j FOR2					# 跳转到 FOR2

FOREND2:
# i++
addi $s0, $s0, 1			# $s0 = $s0 + 1
j FOR1					# 跳转到 FOR1
FOREND1:
# 恢复现场
lw $s1, 8($sp)			# 还原$s1
lw $s0, 4($sp)			# 还原$s0
lw $ra, 0($sp)			# 还原$ra
addi $sp, $sp, 12		# $sp = $sp + 12
move $v0, $zero			# $v0 = $zero
jr $ra					# 跳转到 $ra

INTERRUPT:
addi $t5,$zero,0x0001
sw $t5,0($s4)			#定时器中断禁止
li	$t9,0x000f
move $s7, $v0
and	$t5,$s7,$t9			#只取执行时钟周期数的低16位
srl	$s7,$s7,4
and	$t6,$s7,$t9
srl	$s7,$s7,4
and	$t7,$s7,$t9
srl	$s7,$s7,4
and	$t8,$s7,$t9

addi $s7, $zero, 0x0000	#七段数码管表的基地址
and $s6, $s6, $t9

beq $s6, $zero, INT1
addi $t9, $zero, 0x0004
beq $s6, $t9, INT2
addi $t9, $zero, 0x0008
beq $s6, $t9, INT3
addi $t9, $zero, 0x000c
beq $s6, $t9, INT4

INT1:
sll $t5, $t5, 2
add $t5, $t5, $s7
lw $t9, 0($t5)
addi $t9, $t9, 0x0800
j SCAN
INT2:
sll $t6, $t6, 2
add $t6, $t6, $s7
lw $t9, 0($t6)
addi $t9, $t9, 0x0400
j SCAN
INT3:
sll $t7, $t7, 2
add $t7, $t7, $s7
lw $t9, 0($t7)
addi $t9, $t9, 0x0200
j SCAN
INT4:
sll $t8, $t8, 2
add $t8, $t8, $s7
lw $t9, 0($t8)
addi $t9, $t9, 0x0100
j SCAN

SCAN:
sw $t9, 0($s5)
addi $s6, $s6, 0x0004 
addi $t9, $zero, 0x0003
sw $t9, 0($s4)			#使能定时器中断
jr $k0

EXCEPTION:
Loop2:
beq $zero, $zero, Loop2