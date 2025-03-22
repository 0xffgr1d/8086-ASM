; project to load command line arguments from es to ds
; loads command line arguments and prints them
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA
	args db 80h dup(0)

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax

	mov	dx,OFFSET args
	call	LoadArgs

	mov	bx,OFFSET args
	call	PrintString

Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

LoadArgs PROC
	push	ax
	push	bx
	push	cx
	push	dx
	push	si

	mov	si,0
	mov	ax,80h

@@Repeat:
	cmp	si,ax
	jae	@@Exit
	mov	bx,80h
	add	bx,si
	mov	cl,[es:bx]
	mov	bx,dx
	add	bx,si
	mov	[bx],cl
	inc	si
	jmp	@@Repeat

@@Exit:
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
LoadArgs ENDP

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

END Strt
