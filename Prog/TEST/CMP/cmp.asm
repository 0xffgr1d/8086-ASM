; cmp and conditional jump
; project to understand conditional jumps
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA
	JEStr db "JE triggered, ax==bx",10,13,"$"
	JZStr db "JZ triggered, ax==bx",10,13,"$"
	JNEStr db "JNE triggered, ax!=bx",10,13,"$"
	JNZStr db "JNZ triggered, ax!=bx",10,13,"$"

	JAStr db "JA triggered, ax>bx",10,13,"$"
	JNBEStr db "JNBE triggered, ax>bx",10,13,"$"
	JAEStr db "JAE triggered, ax>=bx",10,13,"$"
	JNBStr db "JNB triggered, ax>=bx",10,13,"$"
	JBStr db "JB triggered, ax<bx",10,13,"$"
	JNAEStr db "JNAE triggered, ax<bx",10,13,"$"
	JBEStr db "JBE triggered, ax<=bx",10,13,"$"
	JNAStr db "JNA triggered, ax<=bx",10,13,"$"

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax

	mov	ax,0000h
	mov	bx,0001h
	cmp	ax,bx

	; equality
	je	@@JECall	; jump if ax==bx
	jmp	@@JEEnd
@@JECall:
	call JECall
@@JEEnd:;
	jz	@@JZCall	; jump if ax==bx
	jmp	@@JZEnd
@@JZCall:
	call	JZCall
@@JZEnd:;
	jne	@@JNECall	; jump if ax!=bx
	jmp	@@JNEEnd
@@JNECall:
	call	JNECall
@@JNEEnd:;	
	jnz	@@JNZCall	; jump if ax!=bx
	jmp	@@JNZEnd
@@JNZCall:
	call	JNZCall
@@JNZEnd:;

	; unsigned comparison
	ja	@@JACall	; jump if ax>bx
	jmp	@@JAEnd
@@JACall:
	call	JACall
@@JAEnd:;
	jnbe	@@JNBECall	; jump if ax>bx
	jmp	@@JNBEEnd
@@JNBECall:
	call	JNBECALL
@@JNBEEnd:;
	jae	@@JAECall	; jump if ax>=bx
	jmp	@@JAEEnd
@@JAECall:
	call	JAECall
@@JAEEnd:;
	jnb	@@JNBCall	; jump if ax>=bx
	jmp	@@JNBEnd
@@JNBCall:
	call	JNBCall
@@JNBEnd:;
	jb	@@JBCall	; jump if ax<bx
	jmp	@@JBEnd
@@JBCall:
	call	JBCall
@@JBEnd:;
	jnae	@@JNAECall	; jump if ax<bx
	jmp	@@JNAEEnd
@@JNAECall:
	call	JNAECall
@@JNAEEnd:;
	jbe	@@JBECall	; jump if ax<=bx
	jmp	@@JBEEnd
@@JBECall:
	call	JBECall
@@JBEEnd:;
	jna	@@JNACall	; jump if ax<=bx
	jmp	@@JNAEnd
@@JNACall:
	call	JNACall
@@JNAEnd:;

	;jc
	;jg / jnle
	;jge / jnl
	;jl / jnge
	;jle / jng
	;jnc
	;jno
	;jnp / jpo
	;jns
	;jo
	;jp / jpe
	;js
	;jcxz

Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

JECall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JEStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JECall endp

JZCall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JZStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JZCall ENDP

JNECall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JNEStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JNECall ENDP

JNZCall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JNZStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JNZCall ENDP

JACall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JAStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JACall ENDP

JNBECall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JNBEStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JNBECall ENDP

JAECall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JAEStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JAECall ENDP

JNBCall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JNBStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JNBCall ENDP

JBCall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JBStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JBCall ENDP

JNAECall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JNAEStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JNAECall ENDP

JBECall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JBEStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JBECall ENDP

JNACall PROC
	pushf
	push	ax
	push	dx

	mov	ah,09
	mov	dx,OFFSET JNAStr
	int	21h

	pop	dx
	pop	ax
	popf
	ret
JNACall ENDP

END Strt
