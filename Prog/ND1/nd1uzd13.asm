
LOCALS @@

.MODEL small

.STACK 100h

StdOut = 1

.DATA
msgText		DB "iveskite: $"
msgEcho		DB 13,10,"ivedete: $"

inputBuf	DB 255
		DB 0
		DB 255 DUP(?)

.CODE
Strt:
	mov	ax,@data
	mov	ds,ax

	mov	dx,OFFSET msgText
	call	Print

	mov	ah,0Ah
	mov	dx,OFFSET inputBuf
	int	21h

	mov	dx,OFFSET msgEcho
	call	Print

	xor	cx,cx
	mov	cl,[inputBuf+1]
	lea	si,[inputBuf+2]
	call	LoadBuf
	call	PrintBuf

	mov	ah,4Ch
	int	21h

LoadBuf PROC
	push	ax
	push	dx
	xor	bx,bx

@@loop:
	lodsb
	xor	ah,ah
	sub	al,'0'
	push	ax
	mov	al,10
	mul	bx
	mov	bx,ax
	pop	ax
	add	bx,ax
	loop	@@loop

	pop	dx
	pop	ax
	ret
LoadBuf ENDP

PrintBuf PROC
	push	ax
	push	dx

	jmp	@@run
@@isZero:
	mov	dl,'0'
	mov	ah,02h
	int	21h
	jmp	@@exit
@@run:
	or	bx,bx
	jz	@@isZero

@@load:
	mov	ax,15
	and	ax,bx
	push	ax
	inc	cl
	sar	bx,4
	or	bx,bx
	jnz	@@load

@@out:
	pop	dx
	cmp 	dl,10
	jb	@@nonLetter
	add	dx,7
@@nonLetter:
	add	dx,'0'
	mov	ah,02h
	int	21h
	dec	cl
	or	cl,cl
	jnz	@@out

@@exit:
	pop	dx
	pop	ax
	ret
PrintBuf ENDP

Print PROC
	push	ax

	mov	ah,09h
	int	21h

	pop	ax
	ret
Print ENDP

end Strt
