; frame for my asm projects
; display formatting examples
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA
	args db 80h dup(0)
	links db 80h dup(0)
	arg0 db 80h dup("$")
	arg1 db 80h dup("$")
	endl db 13,10,"$"

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax

	mov	dx,OFFSET args
	call	LoadArgs
	mov	bx,OFFSET links
	call	LinkArgs
	mov	ax,OFFSET arg0
	mov	si,0
	call	MoveArg
	mov	ax,OFFSET arg1
	mov	si,1
	call	MoveArg

	mov	dx,OFFSET arg0
	call	Print
	mov	dx,OFFSET endl
	call	Print
	mov	dx,OFFSET arg1
	call	Print
	mov	dx,OFFSET endl
	call	Print

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

Print PROC
	push	ax

	mov	ah,09h
	int	21h

	pop	ax
	ret
Print ENDP

END Strt
