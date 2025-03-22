; frame for my asm projects
; display formatting examples
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA
	endl db 13,10,'$'
	string db 'Hello World, Goodbye dreams','$'
	string2 db 'tester test','$'

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax
	
	mov	ax,OFFSET string
	call	Print
	call	PrintEndl

	mov	bl,','
	call	PrintUntil
	call	PrintEndl

	mov	bx,20
	call	PrintLength
	call	PrintEndl

	mov	bx,OFFSET string2
	call	Copy
	call	Print
	call	PrintEndl

	call	Wipe
	call	Copy
	call	Print
	call	PrintEndl

Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt

; Replaces the whole string with end characters
; string adress is stored at ax
;--------------------------------
Wipe PROC
	push	ax		; saves ax and bx to stack to avoid changing it
	push	bx

	mov	bx,ax		; moves adress to bx
	mov	al,'$'		; moves end character to al

@@Repeat:
	cmp	[bx],al		; check if end of string
	je	@@Exit		; exit if end of string
	mov	[bx],al		; replace character with end of string
	inc	bx		; moves forward
	jmp	SHORT @@Repeat	; loops again

@@Exit:
	pop	bx		; restores ax and bx from stack
	pop	ax
	ret			; returns to the point where it was called from
Wipe ENDP

; Replaces string characters with characters from another string
; ax stores destination adress
; bx stores input adress
;--------------------------------
Copy PROC
	push	ax		; saves ax, bx and cx to stack to avoid changing it 
	push	bx
	push	cx

	mov	ch,'$'		; moves end character to ch

@@Repeat:
	cmp	[bx],ch		; checks for input string end
	je	@@Exit		; if input string ended exits

	mov	cl,[bx]		; saves curent character to cl

	xchg	bx,ax		; swaps destination and input adresses
	mov	[bx],cl		; writes current character to destination adress
	xchg	bx,ax		; swaps destination and input adresses

	inc	bx		; increase input adress
	inc	ax		; increase destination adress
	jmp	SHORT @@Repeat	; loops again
	
@@Exit:
	pop	cx		; restores ax, bx and cx from stack
	pop	bx
	pop	ax
	ret			; returns to the point where it was called from
Copy ENDP

; Prints string stored at ax
; '$' is used as an end charcter 
;------------------------
Print PROC
	push	ax	; saves ax and dx to stack to avoid changing it
	push	dx

	mov	dx,ax	; moves string adress to dx
	mov	ah,09h	; print string interupt code
	int	21h	; system interupt

	pop	dx	; restores ax and dx from stack
	pop	ax
	ret		; returns to the point where it was called from
Print ENDP

; Prints string stored at ax
; character stored at bl is used as an end character
;--------------------------------
PrintUntil PROC
	push	ax		; saves ax, bx, dx and si to stack to avoid changing it
	push	bx
	push	dx
	push	si

	mov	si,ax		; moves string address to si
	cld			; set directional flag to go forward
	mov	ah,2h		; print character from dl interupt code

@@Repeat:
	lodsb			; load value from adress at si to al and walk to set direction
	cmp	al,bl		; chech if character in al is exual to to bl
	je	@@Exit		; if equal jump to @@Exit
	mov	dl,al		; loads character from al to dl
	int	21h		; system interupt
	jmp	SHORT @@Repeat	; loops again

@@Exit:
	pop	si		; restores ax, bx, dx and si from stack
	pop	dx
	pop	bx
	pop	ax
	ret			; returns to the point where it was called from
PrintUntil ENDP

; Prints string stored at ax
; only prints specified amount of characters which is stored in bx
;--------------------------------
PrintLength PROC
	push	ax		; saves ax, bx, dx and si to stack to avoid changing it
	push	bx
	push	dx
	push	si

	mov	si,ax		; moves string adress to si
	cld			; set directional flag to go forward
	mov	ah,2h		; print character from di interupt code

@@Repeat:
	or	bx,bx		; checks the amount of characters left to print
	jz	@@Exit		; if zero jump to @@Exit
	lodsb			; load value from adress at si to al and walk to set direction
	mov	dl,al		; loads character from al to dl
	int	21h		; system interupt
	dec	bx		; decreases amount of characters to print
	jmp	SHORT @@Repeat	; loops again

@@Exit:
	pop	si		; restores ax, bx, dx and si from stack
	pop	dx
	pop	bx
	pop	ax
	ret			; returns to the point where it was called from
PrintLength ENDP

; Prints end line
;--------------------------------
PrintEndl PROC
	push	ax		; saves ax and dx to stack to avoid changing it
	push	dx

	mov	dx,OFFSET endl	; moves end line string adress to dx
	mov	ah,09h		; print string interupt code
	int	21h		;system interupt

	pop	dx		; restores ax and dx from stack
	pop	ax
	ret			; returns to the point where it was called from
PrintEndl ENDP

END Strt
