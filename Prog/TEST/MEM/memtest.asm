; frame for my asm projects
; display formatting examples
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA

memSize		dw 0, 16
memPtr		dw 0, 0

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax

	mov	ah,48h
	mov	bx,OFFSET memSize
	int	21h
	jc	AllocErr
	mov	[memPtr], ax

	call	Endl

	rol	[memSize], 1	
	push	memPtr
	pop	es

	mov	ah,4Ah
	mov	bx,OFFSET memSize
	int	21h
	jc	ResizeErr

	call	Endl

	mov	ah,49h
	int	21h
	jc	FreeErr

AllocErr:
ResizeErr:
FreeErr:
Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

PrintHex16 PROC
        push    ax
        push    bx
        push    cx
        push    dx

        xor     cx,cx

@@load:
        mov     ax,15
        and     ax,bx
        push    ax
        sar     bx,4
        inc     cl
        cmp     cl,4
        jb      @@load

        mov     ah,02h
@@out:
        pop     dx
        cmp     dl,10
        jb      @@nonLetter
        add     dl,7
@@nonLetter:
        add     dl,'0'
        int     21h
        dec     cl
        or      cl,cl
        jnz     @@out

@@exit:
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
PrintHex16 ENDP

Endl PROC
	push	ax
	push	dx

	mov	ah,2h
	mov	dl,10
	int	21h
	mov	dl,13
	int	21h

	pop	dx
	pop	ax
	ret
Endl ENDP

END Strt
