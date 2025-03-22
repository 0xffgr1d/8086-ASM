; frame for my asm projects
; display formatting examples
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax
	
	mov	bx,8081h
	call	PrintInt8
	call	EndLine
	call	PrintInt16
	call	EndLine
	call	PrintSignedInt8
	call	EndLine
	call	PrintSignedInt16
	call	EndLine

Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

EndLine PROC
	push	ax
	push	dx

	mov	ah,02h
	mov	dl,10
	int	21h
	mov	dl,13
	int	21h

	pop	dx
	pop	ax
	ret
EndLine ENDP

PrintInt8 PROC
	push	ax
	push	bx
	push	cx
	push	dx

	xor	cx,cx
	jmp	@@Run
@@IsZero:
	mov	dl,'0'
	mov	ah,02h
	int	21h
	jmp	@@Exit
@@Run:
	or	bl,bl
	jz	@@IsZero

@@Load:
	xor	dx,dx
	mov	dl,bl
	xor	bx,bx
	jmp	@@Compare
@@Divide:
	sub	dl,10
	inc	bl
@@Compare:
	cmp	dx,10
	jnb	@@Divide
	push	dx
	inc	cl
	or	bx,bx
	jnz	@@Load

@@Out:
	pop	dx
	add	dl,'0'
	mov	ah,02h
	int	21h
	dec	cl
	or	cl,cl
	jnz	@@out

@@Exit:
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
PrintInt8 ENDP

PrintInt16 PROC
	push 	ax
	push	bx
	push	cx
	push	dx

	xor	cx,cx
	jmp	@@Run
@@IsZero:
	mov	dl,'0'
	mov	ah,02h
	int	21h
	jmp	@@Exit
@@Run:
	or	bx,bx
	jz	@@IsZero

@@Load:
	xor	dx,dx
	mov	dx,bx
	xor	bx,bx
	jmp	@@Compare
@@Divide:
	sub	dx,10
	inc	bx
@@Compare:
	cmp	dx,10
	jnb	@@Divide
	push	dx
	inc	cx
	or	bx,bx
	jnz	@@Load

@@Out:
	pop	dx
	add	dx,'0'
	mov	ah,02h
	int	21h
	dec	cl
	or	cl,cl
	jnz	@@Out

@@Exit:
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
PrintInt16 ENDP

PrintSignedInt8 PROC
	push	ax
	push	bx
	push	dx

	mov	dx,bx
	and	dl,80h
	jnz	@@Sign
	call	PrintInt8
	jmp	@@Exit
@@Sign:
	mov	dl,'-'
	mov	ah,02h
	int	21h
	mov	dx,bx
	and	dl,7Fh
	mov	bl,80h
	sub	bl,dl
	call	PrintInt8

@@Exit:
	pop	dx
	pop	bx
	pop	ax
	ret
PrintSignedInt8 ENDP

PrintSignedInt16 PROC
	push	ax
	push	bx
	push	dx

	mov	dx,bx
	and	dx,8000h
	jnz	@@Sign
	call	PrintInt16
	jmp	@@Exit
@@Sign:
	mov	dl,'-'
	mov	ah,02h
	int	21h
	mov	dx,bx
	and	dx,7FFFh
	mov	bx,8000h
	sub	bx,dx
	call	PrintInt16

@@Exit:
	pop	dx
	pop	bx
	pop	ax
	ret
PrintSignedInt16 ENDP

END Strt
