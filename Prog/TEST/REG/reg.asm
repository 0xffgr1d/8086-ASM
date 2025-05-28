; debugging functions
; prints register values
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA
	endl db 13,10,'$'	; string to print
	regax db "ax",9,"$"
	regbx db "bx",9,"$"
	regcx db "cx",9,"$"
	regdx db "dx",9,"$"
	regsi db "si",9,"$"
	regdi db "di",9,"$"
	regflags db "flags",9,"$"
	regcs db "cs",9,"$"
	regds db "ds",9,"$"
	regss db "ss",9,"$"
	reges db "es",9,"$"
	regsp db "sp",9,"$"
	regbp db "bp",9,"$"

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax

	mov	dx,OFFSET endl	; loads memory adress of a string
	call	Print		; calls Print process

	call	PrintRegisters

Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

PrintRegisters PROC
	push	ax
	push	dx
	pushf

	push	bp
	push	sp
	push	es
	push	ss
	push	ds
	push	cs
	pushf
	push	di
	push	si
	push	dx
	push	cx
	push	bx
	push	ax

	pop	dx
	mov	cx,OFFSET regax
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regbx
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regcx
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regdx
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regsi
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regdi
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regflags
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regcs
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regds
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regss
	call	PrintReg

	pop	dx
	mov	cx,OFFSET reges
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regsp
	call	PrintReg

	pop	dx
	mov	cx,OFFSET regbp
	call	PrintReg

	popf
	pop	dx
	pop	ax
	ret
PrintRegisters ENDP

PrintReg PROC
	push	ax
	push	dx
	push	cx

	push	dx
	mov	dx,cx
	call	Print

	pop	bx
	call	PrintHex16

	mov	dx,OFFSET endl
	call	Print
	
	pop	cx
	pop	dx
	pop	ax
	ret
PrintReg ENDP

Print PROC
	push	ax	; save ax to stack to avoid changing it

	mov	ah,09h	; print string interupt code
	int	21h	; system interupt

	pop	ax	; restores ax from stack
	ret		; returns to the point where it was called from
Print ENDP


PrintHex16 PROC
	push	ax
	push	bx
	push	cx
	push	dx

	xor	cx,cx

@@load:
	mov	ax,15
	and	ax,bx
	push	ax
	sar	bx,4
	inc	cl
	cmp	cl,4
	jb	@@load

	mov	ah,02h
@@out:
	pop	dx
	cmp	dl,10
	jb	@@nonLetter
	add	dl,7
@@nonLetter:
	add	dl,'0'
	int	21h
	dec	cl
	or	cl,cl
	jnz	@@out
	
@@exit:
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
PrintHex16 ENDP 
END Strt


