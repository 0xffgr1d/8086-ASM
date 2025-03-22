; prints a string
; prints every character until 0
; ------------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA
	string db 'test',0	; string to print

; ---------------------------------------
.CODE
Strt:
	mov	ax,@data		; loads memory
	mov	ds,ax

	mov	si,OFFSET string	; loads memory adress of a string
	call	PrintString		; calls PrintString process

Exit:
	mov	ax,04C00h		; exit interupt code
	int	21h			; system interupt

; ---------------------------------------
PrintString PROC
	push	ax			; save ax and dx to stack to avoid changing them
	push	dx

	cld				; set direction flag to go forward
	mov	ah,2h			; print character from dl interupt code

@@Repeat:
	lodsb				; load value from adress stored at si to al and walk to set direction
	or	al,al			; checks if al is equal to 0
	jz	@@Exit			; if al is equal to 0 jumps to @@Exit
	mov	dl,al			; loads character from al to dl
	int	21h			; system interupt
	jmp	SHORT	@@Repeat	; loops again

@@Exit:
	pop	dx			; restores dx and ax from stack
	pop	ax
	ret				; returns to the point it was called from
PrintString ENDP

END Strt
