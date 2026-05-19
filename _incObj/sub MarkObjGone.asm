; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to despawn an object off-screen, assuming x_pos is d0
; ---------------------------------------------------------------------------
; loc_163D2:
MarkObjGone:
	tst.w	(Two_player_mode).w	; is it two player mode?
	beq.s	+			; if not, branch
	bra.w	DisplaySprite
+
	out_of_range.s	+
	bra.w	DisplaySprite

+	lea	(Object_Respawn_Table).w,a2
	moveq	#0,d0
	move.b	respawn_index(a0),d0
	beq.s	+
	bclr	#7,Obj_respawn_data-Object_Respawn_Table(a2,d0.w)
+
	bra.w	DeleteObject
; End of function MarkObjGone

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to despawn an object off-screen, with d0 being defined beforehand
; ---------------------------------------------------------------------------
; loc_1640A:
MarkObjGone2:
	tst.w	(Two_player_mode).w
	beq.s	+
	bra.w	DisplaySprite
+
	andi.w	#$FF80,d0
	sub.w	(Camera_X_pos_coarse).w,d0
	cmpi.w	#$80+roundToNextMultiple(screen_width,$80)+$80,d0	; This gives an object $80 pixels of room offscreen before being unloaded
	bhi.w	+
	bra.w	DisplaySprite
+
	lea	(Object_Respawn_Table).w,a2
	moveq	#0,d0
	move.b	respawn_index(a0),d0
	beq.s	+
	bclr	#7,Obj_respawn_data-Object_Respawn_Table(a2,d0.w)
+
	bra.w	DeleteObject
; End of function MarkObjGone2

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to despawn an object off-screen, and not displaying if it
; *is* (usually reserved for debug objects or invisible triggers)
; ---------------------------------------------------------------------------
; loc_1643E:
MarkObjGone3:
	tst.w	(Two_player_mode).w
	beq.s	+
	rts
+
	out_of_range.s	+
	rts
+
	lea	(Object_Respawn_Table).w,a2
	moveq	#0,d0
	move.b	respawn_index(a0),d0
	beq.s	+
	bclr	#7,Obj_respawn_data-Object_Respawn_Table(a2,d0.w)
+
	bra.w	DeleteObject
; End of function MarkObjGone3

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines to despawn an object off-screen for both players
; ---------------------------------------------------------------------------
; loc_16472:
MarkObjGone_P1:
	tst.w	(Two_player_mode).w
	bne.s	MarkObjGone_P2
	out_of_range.s	+
	bra.w	DisplaySprite
+
	lea	(Object_Respawn_Table).w,a2
	moveq	#0,d0
	move.b	respawn_index(a0),d0
	beq.s	+
	bclr	#7,Obj_respawn_data-Object_Respawn_Table(a2,d0.w)
+
	bra.w	DeleteObject
; End of function MarkObjGone_P1

; ---------------------------------------------------------------------------
; input: a0 = the object
; loc_164A6:
MarkObjGone_P2:
	move.w	x_pos(a0),d0
	andi.w	#$FF00,d0
	move.w	d0,d1
	sub.w	(Camera_X_pos_coarse).w,d0
	cmpi.w	#$300,d0
	bhi.w	+
	bra.w	DisplaySprite
+
	sub.w	(Camera_X_pos_coarse_P2).w,d1
	cmpi.w	#$300,d1
	bhi.w	+
	bra.w	DisplaySprite
+
	lea	(Object_Respawn_Table).w,a2
	moveq	#0,d0
	move.b	respawn_index(a0),d0
	beq.s	DeleteObject
	bclr	#7,Obj_respawn_data-Object_Respawn_Table(a2,d0.w)
	; continue into DeleteObject
; End of function MarkObjGone_P2