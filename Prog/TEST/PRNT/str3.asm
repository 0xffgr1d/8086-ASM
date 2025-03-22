; frame for my asm projects
; display formatting examples
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA
	string db 6,"hello world!"
	longString db 12,0,"hello world!"

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax

	mov	bx,OFFSET string
	call	PrintString
	mov	bx,OFFSET longString
	call	PrintLongString

Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

PrintString PROC
	push	ax
	push	bx
	push	cx
	push	dx
	push	si

	mov	si,bx
	mov	cx,[bx]
	and	cx,00FFh
	cld
	mov	ah,2h
	lodsb

@@Repeat:
	or	cx,cx
	jz	@@Exit
	lodsb
	mov	dl,al
	int	21h
	dec	cx
	jmp	@@Repeat

@@Exit:
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
PrintString ENDP

PrintLongString PROC
	push	ax
	push	bx
	push	cx
	push	dx
	push	si

	mov	si,bx
	mov	cx,[bx]
	cld
	mov	ah,2h
	lodsb
	lodsb

@@Repeat:
	or	cx,cx
	jz	@@Exit
	lodsb
	mov	dl,al
	int	21h
	dec	cx
	jmp	@@Repeat

@@Exit:
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
PrintLongString ENDP

END Strt
