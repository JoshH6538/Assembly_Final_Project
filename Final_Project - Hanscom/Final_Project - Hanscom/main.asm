INCLUDE Irvine32.inc
.data
	string byte "The quick brown fox jumps over the lazy dog", 0
.code
main proc
		;set white text / black bkg
	mov eax, 15+(0*16)
	call SetTextColor
		;loop for length of string (exclude null)
	mov ecx, lengthof string - 1
	mov edx, offset string 
	mov esi, 0
	mov edi, 0
	call WriteString
	mov dl, 0
	mov dh, 0
L1:
		;moves cursor to pos
	call Gotoxy
	INPUT:
		call ReadChar
			;check input
		cmp al, string[esi]
		jnz WRONG
	RIGHT:
		mov eax,(2*16) + 0
		mov edi, 0
		jmp CONT
	WRONG:
		mov eax, (4*16) + 0
		inc edi
		cmp edi, 2
		jb CONT
		cmp edi, 2
		ja WL
		call SetTextColor
		mov al, string[esi]
		call WriteChar
		jmp CONT
	WL:
		cmp edi, 2
		jae INPUT	
	CONT:
		call SetTextColor
		mov al, string[esi]
		call WriteChar
		inc dl
		inc esi
	loop L1


	invoke ExitProcess,0
main endp
end main