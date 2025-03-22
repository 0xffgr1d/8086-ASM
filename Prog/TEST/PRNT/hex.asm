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

	mov	bx,2169h
	call	PrintHex8
	call	EndLine
	call	PrintHex16
	call	EndLine
Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

EndLine PROC
	push	ax
	push	dx

	mov 	ah,02h
	mov	dl,10
	int	21h
	mov	dl,13
	int	21h

	pop	dx
	pop	ax
	ret
EndLine ENDP

PrintHex8 PROC
	push	ax
	push	bx
	push	cx
	push	dx

	xor	cx,cx

@@load:
	mov	ax,15
	and	al,bl
	push	ax
	sar	bl,4
	inc	cl
	cmp	cl,2
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
PrintHex8 ENDP

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
