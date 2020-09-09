; ============================================================================
; ----------------------------------------------------------------------------
; Object 17 - Knuckles in Special Stage
; ----------------------------------------------------------------------------

Obj17:
	bsr.w	sub_32CB2A
	moveq	#0,d0
	move.b	routine(a0),d0
	move.w	Obj17_Index(pc,d0.w),d1
	jmp	Obj17_Index(pc,d1.w)
; End of function Obj17

; ---------------------------------------------------------------------------
Obj17_Index:
	dc.w	sub_32CB3E - Obj17_Index	  ; 0
	dc.w	sub_32CBF8 - Obj17_Index	  ; 1
	dc.w	sub_32CDA8 - Obj17_Index	  ; 2
	dc.w	Obj17_Index - Obj17_Index	  ; 3
	dc.w	loc_32CDD2 - Obj17_Index	  ; 4

; =============== S U B	R O U T	I N E =======================================

sub_32CB2A:
	lea	(SS_Ctrl_Record_Buf_End).w,a1

	moveq	#(SS_Ctrl_Record_Buf_End-SS_Ctrl_Record_Buf)/2-2,d0
-	move.w	-4(a1),-(a1)
	dbf	d0,-

	move.w	(Ctrl_1_Logical).w,-(a1)
	rts
; End of function sub_32CB2A

; =============== S U B	R O U T	I N E =======================================

sub_32CB3E:
	move.b	#2,routine(a0)
	moveq	#0,d0
	move.l	d0,objoff_2A(a0)
	move.w	#$80,d1
	move.w	d1,objoff_2E(a0)
	move.w	d0,objoff_30(a0)
	add.w	(SS_Offset_X).w,d0
	move.w	d0,x_pos(a0)
	add.w	(SS_Offset_Y).w,d1
	move.w	d1,y_pos(a0)
	move.b	#$E,y_radius(a0)
	move.b	#7,x_radius(a0)
	move.l	#Obj09_MapUnc_Knuckles,mappings(a0)
	move.w	#$22E5,art_tile(a0)
	move.b	#4,render_flags(a0)
	move.b	#3,priority(a0)
	move.w	#$6E,objoff_34(a0)
	clr.b	(SS_Swap_Positions_Flag).w
	move.w	#$400,objoff_32(a0)
	move.b	#$40,angle(a0)
	move.b	#1,(Sonic_LastLoadedDPLC).w
	clr.b	objoff_37(a0)
	bclr	#6,status(a0)
	clr.b	collision_property(a0)
	clr.b	respawn_index(a0)
	move.l	#SpecialStageShadow_Sonic,a1
	move.b	#ObjID_SSShadow,(a1) ; load obj63 (shadow) at $FFFFB140
	move.w	x_pos(a0),x_pos(a1)
	move.w	y_pos(a0),y_pos(a1)
	add.w	#$18,y_pos(a1)
	move.l	#Obj63_MapUnc_34492,mappings(a1)
	move.w	#$623C,art_tile(a1)
	move.b	#4,render_flags(a1)
	move.b	#4,priority(a1)
	move.l	a0,objoff_38(a1)
	bra.w	loc_32CCC6
; End of function sub_32CB3E

; =============== S U B	R O U T	I N E =======================================

sub_32CBF8:
	tst.b	routine_secondary(a0)
	bne.s	loc_32CC30
	lea	(Ctrl_1_Held_Logical).w,a2
	bsr.w	sub_32D184
	bsr.w	sub_32D204
	bsr.w	sub_32D03E
	bsr.w	sub_32D244
	bsr.w	sub_32D27E
	bsr.w	sub_32CD3A
	bsr.w	sub_32D09A
	lea	(off_341E4).l,a1
	bsr.w	sub_32D0FA
	bsr.w	sub_32CFF6
	bra.w	loc_32CCC6
; ---------------------------------------------------------------------------

loc_32CC30:
	bsr.w	sub_32CC44
	bsr.w	sub_32D03E
	bsr.w	sub_32D244
	bsr.w	sub_32D27E
	bra.w	loc_32CCC6
; End of function sub_32CBF8

; =============== S U B	R O U T	I N E =======================================

sub_32CC44:
	moveq	#0,d0
	move.b	objoff_36(a0),d0
	add.b	#8,d0
	move.b	d0,objoff_36(a0)
	bne.s	loc_32CC60
	move.b	#0,routine_secondary(a0)
	move.b	#$1E,respawn_index(a0)

loc_32CC60:
	add.b	angle(a0),d0
	and.b	#$FC,render_flags(a0)
	sub.b	#$10,d0
	lsr.b	#5,d0
	add.w	d0,d0
	move.b	unk_32CCB6(pc,d0.w),mapping_frame(a0)
	move.b	byte_32CCB7(pc,d0.w),d0
	or.b	d0,render_flags(a0)
	move.b	objoff_36(a0),d0
	sub.b	#8,d0
	bne.s	return_32CCB4
	move.b	d0,collision_property(a0)
	cmp.l	#MainCharacter,a0
	bne.s	loc_32CC9E
	tst.w	(Ring_count).w
	beq.s	return_32CCB4
	bra.s	loc_32CCA4
; ---------------------------------------------------------------------------

loc_32CC9E:
	tst.w	(Ring_count_2P).w
	beq.s	return_32CCB4

loc_32CCA4:
	jsr	(SSSingleObjLoad).l
	bne.s	return_32CCB4
	move.l	a0,objoff_38(a1)
	move.b	#ObjID_SSShadow,(a1) ; load obj5B

return_32CCB4:
	rts
; End of function sub_32CC44

; ---------------------------------------------------------------------------
unk_32CCB6:	dc.b   4
byte_32CCB7:	dc.b	1,   0,	  0,   4,   0,	$C,   0,   4,	2,   0;	0
		dc.b	2,   4,	  3,  $C,   1	  ; 10
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_32CB3E

loc_32CCC6:
	move.b	respawn_index(a0),d0
	beq.s	LoadObj17_DPLC
	subq.b	#1,d0
	move.b	d0,respawn_index(a0)
	and.b	#1,d0
	beq.s	LoadObj17_DPLC
	rts
; ---------------------------------------------------------------------------

LoadObj17_DPLC:
	jsr	(DisplaySprite).l
	move.l	#$FF0000,d6
	lea	(Sonic_LastLoadedDPLC).w,a4
	move.w	#$5CA0,d4
	moveq	#0,d1

loc_32CCF0:
	moveq	#0,d0
	move.b	mapping_frame(a0),d0
	cmp.b	(a4),d0
	beq.s	return_32CD38
	move.b	d0,(a4)
	add.w	d1,d0
	add.w	d0,d0
	lea	(Obj09_MapRUnc_Knuckles).l,a2
	add.w	(a2,d0.w),a2
	move.w	(a2)+,d5
	subq.w	#1,d5
	bmi.s	return_32CD38

loc_32CD10:
	moveq	#0,d1
	move.w	(a2)+,d1
	move.w	d1,d3
	lsr.w	#8,d3
	and.w	#$F0,d3
	add.w	#$10,d3
	and.w	#$FFF,d1
	lsl.l	#5,d1
	add.l	d6,d1
	move.w	d4,d2
	add.w	d3,d4
	add.w	d3,d4
	jsr	(QueueDMATransfer).l
	dbf	d5,loc_32CD10

return_32CD38:
	rts

; =============== S U B	R O U T	I N E =======================================


sub_32CD3A:
	lea	(Ctrl_1_Press_Logical).w,a2

loc_32CD3E:					  ; ...
		move.b	(a2),d0
		and.b	#$70,d0
		beq.w	return_32CDA6
		move.w	#$780,d2
		moveq	#0,d0
		move.b	angle(a0),d0
		add.b	#-$80,d0
		jsr	(CalcSine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,x_vel(a0)
		muls.w	d2,d0
		asr.l	#7,d0
		add.w	d0,y_vel(a0)
		bset	#2,status(a0)
		move.b	#4,routine(a0)
		move.b	#3,anim(a0)
		moveq	#0,d0
		move.b	d0,anim_frame_duration(a0)
		move.b	d0,anim_frame(a0)
		move.b	d0,collision_property(a0)
		tst.b	(SS_2p_Flag).w
		bne.s	loc_32CD98
		tst.w	(Player_mode).w
		bne.s	loc_32CD9C

loc_32CD98:					  ; ...
		not.b	(SS_Swap_Positions_Flag).w

loc_32CD9C:					  ; ...
		move.w	#SndID_Jump,d0
		jsr	(PlaySound).l

return_32CDA6:					  ; ...
		rts
; End of function sub_32CD3A


; =============== S U B	R O U T	I N E =======================================


sub_32CDA8:					  ; ...
		lea	(Ctrl_1_Logical).w,a2
		bsr.w	sub_32CE2C
		bsr.w	sub_32CE00
		bsr.w	sub_32CE4E
		bsr.w	sub_32CFAE
		bsr.w	sub_32D03E
		bsr.w	sub_32D27E
		lea	(off_341E4).l,a1
		bsr.w	sub_32D0FA
		bra.w	loc_32CCC6
; End of function sub_32CDA8

; ---------------------------------------------------------------------------

loc_32CDD2:					  ; ...
		lea	(Ctrl_1_Logical).w,a2
		bsr.w	sub_32CE2C
		bsr.w	sub_32CE00
		bsr.w	sub_32CE4E
		bsr.w	sub_32CFAE
		bsr.w	sub_32D03E
		bsr.w	sub_32D27E
		bsr.w	sub_32D09A
		lea	(off_341E4).l,a1
		bsr.w	sub_32D0FA
		bra.w	loc_32CCC6

; =============== S U B	R O U T	I N E =======================================


sub_32CE00:					  ; ...
		move.l	ss_x_pos(a0),d2
		move.l	ss_y_pos(a0),d3
		move.w	x_vel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	y_vel(a0),d0
		add.w	#$A8,y_vel(a0)
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d2,ss_x_pos(a0)
		move.l	d3,ss_y_pos(a0)
		rts
; End of function sub_32CE00


; =============== S U B	R O U T	I N E =======================================


sub_32CE2C:					  ; ...
		move.b	(a2),d0
		btst	#2,d0
		bne.s	loc_32CE3E
		btst	#3,d0
		bne.w	loc_32CE46
		rts
; ---------------------------------------------------------------------------

loc_32CE3E:					  ; ...
		sub.w	#$40,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CE46:					  ; ...
		add.w	#$40,x_vel(a0)
		rts
; End of function sub_32CE2C


; =============== S U B	R O U T	I N E =======================================


sub_32CE4E:					  ; ...
		moveq	#0,d2
		moveq	#0,d3
		move.w	ss_y_pos(a0),d2
		bmi.s	loc_32CEAE
		move.w	ss_x_pos(a0),d3
		bmi.s	loc_32CE8A
		cmp.w	d2,d3
		bcs.s	loc_32CE7A
		bne.s	loc_32CE70
		tst.w	d3
		bne.s	loc_32CE70
		move.b	#$40,angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CE70:					  ; ...
		lsl.l	#5,d2
		divu.w	d3,d2
		move.b	d2,angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CE7A:					  ; ...
		lsl.l	#5,d3
		divu.w	d2,d3
		sub.w	#$40,d3
		neg.w	d3

loc_32CE84:
		move.b	d3,angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CE8A:					  ; ...
		neg.w	d3
		cmp.w	d2,d3
		bcc.s	loc_32CE9E
		lsl.l	#5,d3
		divu.w	d2,d3
		add.w	#$40,d3
		move.b	d3,angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CE9E:					  ; ...
		lsl.l	#5,d2
		divu.w	d3,d2
		sub.w	#$80,d2
		neg.w	d2
		move.b	d2,angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CEAE:					  ; ...
		neg.w	d2
		move.w	ss_x_pos(a0),d3
		bpl.s	loc_32CEDA
		neg.w	d3
		cmp.w	d2,d3
		bcs.s	loc_32CECA
		lsl.l	#5,d2
		divu.w	d3,d2
		add.w	#$80,d2

loc_32CEC4:
		move.b	d2,angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CECA:					  ; ...
		lsl.l	#5,d3
		divu.w	d2,d3
		sub.w	#$C0,d3
		neg.w	d3

loc_32CED4:
		move.b	d3,angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CEDA:					  ; ...
		cmp.w	d2,d3
		bcc.s	loc_32CEEC
		lsl.l	#5,d3
		divu.w	d2,d3
		add.w	#$C0,d3
		move.b	d3,angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_32CEEC:					  ; ...
		lsl.l	#5,d2
		divu.w	d3,d2
		sub.w	#$100,d2
		neg.w	d2
		move.b	d2,angle(a0)
		rts
; End of function sub_32CE4E


; =============== S U B	R O U T	I N E =======================================


sub_32CEFC:					  ; ...
		moveq	#0,d6
		moveq	#0,d0
		move.w	ss_x_pos(a1),d0
		bpl.s	loc_32CF0A
		st	d6
		neg.w	d0

loc_32CF0A:					  ; ...
		lsl.l	#7,d0
		divu.w	ss_z_pos(a1),d0
		move.b	byte_32CF2C(pc,d0.w),d0
		tst.b	d6
		bne.s	loc_32CF1E
		sub.b	#$80,d0
		neg.b	d0

loc_32CF1E:					  ; ...
		tst.w	ss_y_pos(a1)
		bpl.s	loc_32CF26
		neg.b	d0

loc_32CF26:					  ; ...
		move.b	d0,angle(a0)
		rts
; End of function sub_32CEFC

; ---------------------------------------------------------------------------
byte_32CF2C:	dc.b  $40, $40,	$40, $40, $41, $41, $41, $42, $42, $42;	0
		dc.b  $43, $43,	$43, $44, $44, $44, $45, $45, $45, $46;	10
		dc.b  $46, $46,	$47, $47, $47, $48, $48, $48, $48, $49;	20
		dc.b  $49, $49,	$4A, $4A, $4A, $4B, $4B, $4B, $4C, $4C;	30
		dc.b  $4C, $4D,	$4D, $4D, $4E, $4E, $4E, $4F, $4F, $50;	40
		dc.b  $50, $50,	$51, $51, $51, $52, $52, $52, $53, $53;	50
		dc.b  $53, $54,	$54, $54, $55, $55, $56, $56, $56, $57;	60
		dc.b  $57, $57,	$58, $58, $59, $59, $59, $5A, $5A, $5B;	70
		dc.b  $5B, $5B,	$5C, $5C, $5D, $5D, $5E, $5E, $5E, $5F;	80
		dc.b  $5F, $60,	$60, $61, $61, $62, $62, $63, $63, $64;	90
		dc.b  $64, $65,	$65, $66, $66, $67, $67, $68, $68, $69;	100
		dc.b  $6A, $6A,	$6B, $6C, $6C, $6D, $6E, $6E, $6F, $70;	110
		dc.b  $71, $72,	$73, $74, $75, $77, $78, $7A,-$80,   0;	120

; =============== S U B	R O U T	I N E =======================================


sub_32CFAE:					  ; ...
		move.w	ss_y_pos(a0),d0
		ble.s	return_32CFF4
		muls.w	d0,d0
		move.w	ss_x_pos(a0),d1
		muls.w	d1,d1
		add.w	d1,d0
		move.w	ss_z_pos(a0),d1
		mulu.w	d1,d1
		cmp.l	d1,d0
		bcs.s	return_32CFF4
		move.b	#2,routine(a0)
		bclr	#2,status(a0)
		moveq	#0,d0
		move.w	d0,x_vel(a0)
		move.w	d0,y_vel(a0)
		move.w	d0,inertia(a0)
		move.b	d0,ss_slide_timer(a0)
		bset	#6,status(a0)
		bsr.w	sub_32D244
		bsr.w	sub_32D27E

return_32CFF4:					  ; ...
		rts
; End of function sub_32CFAE


; =============== S U B	R O U T	I N E =======================================


sub_32CFF6:					  ; ...
		tst.b	collision_property(a0)
		beq.s	return_32D03C
		clr.b	collision_property(a0)
		tst.b	ss_dplc_timer(a0)
		bne.s	return_32D03C
		clr.b	inertia(a0)
		cmp.l	#MainCharacter,a0
		bne.s	loc_32D01E
		st	(SS_Swap_Positions_Flag).w
		tst.w	(Ring_count).w
		beq.s	loc_32D032
		bra.s	loc_32D028
; ---------------------------------------------------------------------------

loc_32D01E:					  ; ...
		clr.b	(SS_Swap_Positions_Flag).w
		tst.w	(Ring_count_2P).w
		beq.s	loc_32D032

loc_32D028:					  ; ...
		move.w	#SndID_RingSpill,d0
		jsr	(PlaySound).l

loc_32D032:					  ; ...
		move.b	#2,routine_secondary(a0)
		clr.b	ss_hurt_timer(a0)

return_32D03C:					  ; ...
		rts
; End of function sub_32CFF6


; =============== S U B	R O U T	I N E =======================================


sub_32D03E:					  ; ...
		tst.w	(Player_mode).w
		bne.s	return_32D088
		move.w	ss_z_pos(a0),d0
		cmp.l	#MainCharacter,a0
		bne.s	loc_32D058
		tst.b	(SS_Swap_Positions_Flag).w
		beq.s	loc_32D068
		bra.s	loc_32D05E
; ---------------------------------------------------------------------------

loc_32D058:					  ; ...
		tst.b	(SS_Swap_Positions_Flag).w
		bne.s	loc_32D068

loc_32D05E:					  ; ...
		cmp.w	#$80,d0
		beq.s	return_32D088
		addq.w	#1,d0
		bra.s	loc_32D070
; ---------------------------------------------------------------------------

loc_32D068:					  ; ...
		cmp.w	#$6E,d0
		beq.s	return_32D088
		subq.w	#1,d0

loc_32D070:					  ; ...
		move.w	d0,ss_z_pos(a0)
		cmp.w	#$77,d0
		bcc.s	loc_32D082
		move.b	#3,priority(a0)
		rts
; ---------------------------------------------------------------------------

loc_32D082:					  ; ...
		move.b	#2,priority(a0)

return_32D088:					  ; ...
		rts
; End of function sub_32D03E

; ---------------------------------------------------------------------------
byte_32D08A:	dc.b	1			  ; 0
byte_32D08B:	dc.b	1,   0,	  0,   1,   0,	 2,   0,   1,	2,   0;	0
		dc.b	2,   1,	  3,   2,   1	  ; 10

; =============== S U B	R O U T	I N E =======================================


sub_32D09A:					  ; ...
		btst	#2,status(a0)
		beq.s	loc_32D0B0
		move.b	#3,anim(a0)
		and.b	#$FC,status(a0)
		rts
; ---------------------------------------------------------------------------

loc_32D0B0:					  ; ...
		moveq	#0,d0
		move.b	angle(a0),d0
		sub.b	#$10,d0
		lsr.b	#5,d0
		move.b	d0,d1
		add.w	d0,d0
		move.b	byte_32D08A(pc,d0.w),d2
		cmp.b	anim(a0),d2
		bne.s	loc_32D0D0
		cmp.b	ss_last_angle_index(a0),d1
		beq.s	return_32D0F8

loc_32D0D0:					  ; ...
		move.b	d1,ss_last_angle_index(a0)
		move.b	d2,anim(a0)
		move.b	byte_32D08B(pc,d0.w),d0
		and.b	#$FC,status(a0)
		or.b	d0,status(a0)
		cmp.b	#1,d1
		beq.s	loc_32D0F2
		cmp.b	#5,d1
		bne.s	return_32D0F8

loc_32D0F2:					  ; ...
		move.w	#$400,ss_init_flip_timer(a0)

return_32D0F8:					  ; ...
		rts
; End of function sub_32D09A


; =============== S U B	R O U T	I N E =======================================


sub_32D0FA:					  ; ...
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	loc_32D116
		move.b	#0,anim_frame(a0)
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame_duration(a0)

loc_32D116:					  ; ...
		subq.b	#1,anim_frame_duration(a0)
		bpl.s	return_32D182
		add.w	d0,d0
		add.w	(a1,d0.w),a1
		move.b	(SS_player_anim_frame_timer).w,d0
		lsr.b	#1,d0
		move.b	d0,anim_frame_duration(a0)
		cmp.b	#0,anim(a0)
		bne.s	loc_32D14E
		sub.b	#1,ss_flip_timer(a0)
		bgt.s	loc_32D14E
		bchg	#0,status(a0)
		bchg	#0,render_flags(a0)
		move.b	ss_init_flip_timer(a0),ss_flip_timer(a0)

loc_32D14E:					  ; ...
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		bpl.s	loc_32D164
		move.b	#0,anim_frame(a0)

loc_32D160:
		move.b	1(a1),d0

loc_32D164:					  ; ...
		and.b	#$7F,d0
		move.b	d0,mapping_frame(a0)
		move.b	status(a0),d1
		and.b	#3,d1
		and.b	#%11111100,render_flags(a0)
		or.b	d1,render_flags(a0)
		addq.b	#1,anim_frame(a0)

return_32D182:					  ; ...
		rts
; End of function sub_32D0FA


; =============== S U B	R O U T	I N E =======================================


sub_32D184:					  ; ...
		move.w	inertia(a0),d2
		move.b	(a2),d0
		btst	#2,d0
		bne.s	loc_32D1D6
		btst	#3,d0
		bne.w	loc_32D1E6
		bset	#6,status(a0)
		bne.s	loc_32D1A6
		move.b	#$1E,ss_slide_timer(a0)

loc_32D1A6:					  ; ...
		move.b	angle(a0),d0
		bmi.s	loc_32D1BE
		sub.b	#$38,d0
		cmp.b	#$10,d0
		bcc.s	loc_32D1BE
		move.w	d2,d1
		asr.w	#3,d1
		sub.w	d1,d2
		bra.s	loc_32D1C4
; ---------------------------------------------------------------------------

loc_32D1BE:					  ; ...
		move.w	d2,d1
		asr.w	#3,d1
		sub.w	d1,d2

loc_32D1C4:					  ; ...
		move.w	d2,inertia(a0)
		move.b	ss_slide_timer(a0),d0
		beq.s	return_32D1D4
		subq.b	#1,d0
		move.b	d0,ss_slide_timer(a0)

return_32D1D4:					  ; ...
		rts
; ---------------------------------------------------------------------------

loc_32D1D6:					  ; ...
		add.w	#$60,d2
		cmp.w	#$600,d2
		ble.s	loc_32D1F4
		move.w	#$600,d2
		bra.s	loc_32D1F4
; ---------------------------------------------------------------------------

loc_32D1E6:					  ; ...
		sub.w	#$60,d2
		cmp.w	#-$600,d2
		bge.s	loc_32D1F4
		move.w	#-$600,d2

loc_32D1F4:					  ; ...
		move.w	d2,inertia(a0)
		bclr	#6,status(a0)
		clr.b	ss_slide_timer(a0)
		rts
; End of function sub_32D184


; =============== S U B	R O U T	I N E =======================================


sub_32D204:					  ; ...
		tst.b	ss_slide_timer(a0)
		bne.s	loc_32D21E
		move.b	angle(a0),d0
		jsr	(CalcSine).l
		muls.w	#$50,d1
		asr.l	#8,d1
		add.w	d1,inertia(a0)

loc_32D21E:					  ; ...
		move.b	angle(a0),d0
		bpl.s	return_32D242
		add.b	#4,d0
		cmp.b	#$88,d0
		bcs.s	return_32D242
		move.w	inertia(a0),d0
		bpl.s	loc_32D236
		neg.w	d0

loc_32D236:					  ; ...
		cmp.w	#$100,d0
		bcc.s	return_32D242
		move.b	#8,routine(a0)

return_32D242:					  ; ...
		rts
; End of function sub_32D204


; =============== S U B	R O U T	I N E =======================================


sub_32D244:					  ; ...
		moveq	#0,d0
		moveq	#0,d1
		move.w	inertia(a0),d2
		bpl.s	loc_32D258
		neg.w	d2
		lsr.w	#8,d2
		sub.b	d2,angle(a0)
		bra.s	loc_32D25E
; ---------------------------------------------------------------------------

loc_32D258:					  ; ...
		lsr.w	#8,d2
		add.b	d2,angle(a0)

loc_32D25E:					  ; ...
		move.b	angle(a0),d0
		jsr	(CalcSine).l
		muls.w	ss_z_pos(a0),d1
		asr.l	#8,d1
		move.w	d1,ss_x_pos(a0)
		muls.w	ss_z_pos(a0),d0
		asr.l	#8,d0
		move.w	d0,ss_y_pos(a0)
		rts
; End of function sub_32D244


; =============== S U B	R O U T	I N E =======================================


sub_32D27E:					  ; ...
		move.w	ss_x_pos(a0),d0
		muls.w	#$CC,d0
		asr.l	#8,d0
		add.w	(SS_Offset_X).w,d0
		move.w	d0,8(a0)
		move.w	ss_y_pos(a0),d0
		add.w	(SS_Offset_Y).w,d0
		move.w	d0,$C(a0)
		rts				  ; End	of Special Stage Knuckles object
; End of function sub_32D27E


; ----------------------------------------------------------------------------
; sprite mappings - uses ArtNem_SpecialKnuckles
; ----------------------------------------------------------------------------
Obj09_MapUnc_Knuckles:	BINCLUDE "mappings/sprite/obj09_Knuckles.bin"

; ----------------------------------------------------------------------------
; dynamic pattern loading cues of some sort (?)
; ----------------------------------------------------------------------------
Obj09_MapRUnc_Knuckles:	BINCLUDE "mappings/spriteDPLC/obj09_Knuckles.bin"