INCLUDE Irvine32.inc
.data
	string byte "Hello World!",0
.code
main proc
	mov ecx, lengthof string - 1
	mov eax, offset string
	mov esi, 0
	call WriteString
L1:
	
	
	invoke ExitProcess,0
main endp
end main