
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
	mov	al,8
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
	push	cx

	xor	cx,cx
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
	mov	dx,bx
	xor	bx,bx
	jmp	@@compare
@@divide:
	sub	dx,10
	inc	bx
@@compare:
	cmp	dx,9
	ja	@@divide
	push	dx
	inc	cl
	or	bx,bx
	jnz	@@load

@@out:
	pop	dx
	add	dx,'0'
	mov	ah,02h
	int	21h
	dec	cl
	or	cl,cl
	jnz	@@out

@@exit:
	pop	cx
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
