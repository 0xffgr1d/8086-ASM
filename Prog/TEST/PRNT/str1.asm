; prints a string
; prints every character until '$'
; --------------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA
	hello db 'hello',13,10,'$'	; string to print

;--------------------------------
.CODE
Strt:
	mov 	ax,@data	; loads memory
	mov	ds,ax

	mov	dx,OFFSET hello	; loads memory adress of a string
	call	Print		; calls Print process

Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

;------------------------
Print PROC
	push	ax	; save ax to stack to avoid changing it

	mov	ah,09h	; print string interupt code
	int	21h	; system interupt

	pop	ax	; restores ax from stack
	ret		; returns to the point where it was called from
Print ENDP

END Strt
