
LOCALS @@

.MODEL small

.STACK 256

.DATA
args		DB 80h DUP(0)
links		DB 80h DUP(0)
arg1		DB 80h DUP('$')
handle1		DW 0
arg2		DB 80h DUP('$')
handle2		DW 0
endl		DB 13,10,"$"

.DATA?
readBuf		DB 10 DUP(?)
hexBuf		DB 30 DUP(?)

.CODE
Strt:	
	mov	ax,@data
	mov	ds,ax

	mov	dx,OFFSET args
	call	LoadArgs
	mov	bx,OFFSET links
	call	LinkArgs
	mov	ax,OFFSET arg1
	mov	si,0
	call	MoveArg
	mov	ax,OFFSET arg2
	mov	si,1
	call	MoveArg

	mov	dx,OFFSET arg1
	mov	ax,3D00h
	int	21h
	jc	Exit
	mov	[handle1],ax

	mov	dx,OFFSET arg2
	mov	ax,3D01h
	int	21h
	jc	Exit
	mov	[handle2],ax

@@Loop:
	mov	ax,3F00h
	mov	bx,[handle1]
	mov	cx,10
	mov	dx,OFFSET readBuf
	int	21h
	jc	Exit
	
	or	ax,ax
	jz	Exit
	mov	si,ax

	call	HexConverter

	mov	dx,OFFSET hexBuf
	mov	cx,0
@@Multiply:
	or	ax,ax
	jz	@@Done
	add	cx,3
	dec	ax
	jmp	@@Multiply
@@Done:
	mov	ax,4000h
	mov	bx,[handle2]
	int	21h

	jmp	@@Loop

Exit:

	mov	bx,[handle1]
	or	bx,bx
	jz	@@FileClosed1
	mov	ah,3Eh
	int	21h
@@FileClosed1:

	mov	bx,[handle2]
	or	bx,bx
	jz	@@FileClosed2
	mov	ah,3Eh
	int	21h
@@FileClosed2:

	mov	ah,4Ch
	int	21h

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

LinkArgs PROC
	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di

	push	bx
	mov	bx,dx
	mov	di,[bx]
	and	di,7Fh
	pop	bx
	inc	dx

	or	di,di
	jz	@@Exit

	xor	ax,ax
	xor	si,si

@@AfterSpace:
	cmp	si,di
	jae	@@Exit

	push	bx
	mov	bx,dx
	mov	cx,[bx]
	and	cx,0FFh
	inc	dx
	inc	si
	pop	bx

	push	ax
	mov	ax,' '
	cmp	cx,ax
	pop	ax
	je	@@AfterSpace

	cmp	si,di
	jae	@@Exit
	mov	[bx],si
	inc	bx
@@AfterSymbol:
	inc	ax
	cmp	si,di
	jae	@@Save

	push	bx
	mov	bx,dx
	mov	cx,[bx]
	and	cx,0FFh
	inc	dx
	inc	si
	pop	bx

	push	ax
	mov	ax,' '
	cmp	cx,ax
	pop	ax
	je	@@Save
	jmp	@@AfterSymbol

@@Save:
	mov	[bx],ax
	inc	bx
	xor	ax,ax
	jmp	@@AfterSpace

@@Exit:
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
LinkArgs ENDP

MoveArg PROC
	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di

	and	si,3Fh

@@Pointer:
	or	si,si
	jz	@@Done
	dec	si
	inc	bx
	inc	bx
	jmp	@@Pointer
@@Done:

	mov	cx,[bx]
	and	cx,7Fh
	inc	bx
	add	dx,cx
	mov	di,[bx]
	and	di,7Fh
	xor	si,si
	or	cx,cx
	jz	@@Exit

@@Repeat:
	cmp	si,di
	jae	@@Exit
	push	bx
	mov	bx,dx
	mov	ch,[bx]
	mov	bx,ax
	mov	[bx],ch
	pop	bx
	inc	si
	inc	ax
	inc	dx
	jmp	@@Repeat

	push	bx
	mov	bx,ax
	mov	ah,'$'
	mov	[bx],ah
	pop	bx

@@Exit:
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
MoveArg ENDP

HexConverter PROC
	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di

	xor	di,di
	mov	bx,OFFSET hexBuf

@@Loop:
	cmp	di,si
	jae	@@Exit
	push	bx
	mov	bx,OFFSET readBuf
	add	bx,di
	mov	cl,[bx]
	pop	bx
	mov	ch," "
	mov	[bx],ch
	inc	bx

	mov	ch,cl
	and	ch,00F0h
	sar	ch,4
	cmp	ch,10
	jb	@@NonLetter1
	add	ch,7
@@NonLetter1:
	add	ch,"0"
	mov	[bx],ch
	inc	bx

	mov	ch,cl
	and	ch,0Fh
	cmp	ch,10
	jb	@@NonLetter2
	add	ch,7
@@NonLetter2:
	add	ch,"0"
	mov	[bx],ch
	inc	bx

	inc	di
	jmp	@@Loop

@@Exit:
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
HexConverter ENDP

Print PROC
	push	ax

	mov	ah,09h
	int	21h

	pop	ax
	ret
Print	ENDP

END Strt
