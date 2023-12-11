INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
	string byte "Hello", 0
	correct byte 2 
.code
main proc
		;set white text / black bkg
	mov eax, 15+(0*16)
	call SetTextColor
	mov eax,0
	mWriteString OFFSET	string
	mov bl, 0
	mov bh, 0
	mGotoxy bh,bl
FALL:
	mGotoxy 0,bl
	movzx ecx,bh
	mov esi,0
	CHECK:
		cmp correct,1
		je G
		cmp correct,0
		je R
		jmp NEUTRAL
	NEUTRAL:
		push eax
		mov eax, 15+(0*16)
		call SetTextColor
		pop eax
		jmp PRINT
	G:
		push eax
		mov eax, 2+(0*16)
		call SetTextColor
		pop eax
		jmp PRINT
	R:
		push eax
		mov eax, 4+(0*16)
		call SetTextColor
		pop eax
		jmp PRINT
	PRINT:
		cmp ecx,0
		jz REST
		push eax
		mov al, string[esi]
		call WriteChar
		pop eax
		inc esi
		loop PRINT
	REST:
		mov ecx,lengthof string - 1
		push eax
		movzx eax, bh
		sub ecx,eax
		mov eax, 15+(0*16)
		call SetTextColor
		pop eax
		mov edi,esi
	RESTPRINT:
		cmp edi, (lengthof string - 1)
		jae DONE
		push eax
		mov al, string[edi]
		call WriteChar
		pop eax
		inc edi
		loop RESTPRINT
		

TIME:
	
	mGotoxy bh,bl
		;falls one line
	inc bl
	
		;reads char
	push ebx
	call ReadKey
	pop ebx
	pushfd
		;clear screen before print next line
	call Clrscr
	popfd
	jnz READ
		;if no input
	push eax
		;for delay
	mov eax,1000 
		;moves cursor pos to last char input
	call Delay
	pop eax
	mov correct,2
	jz FALL

READ:
			;check input
		cmp al, string[esi]
		jnz WRONG
	RIGHT:
		mov correct,1
		jmp CONT
	WRONG:
		mov correct,0
		jmp NOCONT
	CONT:
		inc bh
	NOCONT:
		jmp FALL

DONE:
	

	invoke ExitProcess,0
main endp
end main