; frame for my asm projects
; display formatting examples
;----------------------------

LOCALS @@

.MODEL small

.STACK 256

.DATA

;--------------------------------
.CODE
Strt:
	mov	ax,@data	; loads memory
	mov	ds,ax
Exit:
	mov	ax,04C00h	; exit interupt code
	int	21h		; system interupt
END Strt
