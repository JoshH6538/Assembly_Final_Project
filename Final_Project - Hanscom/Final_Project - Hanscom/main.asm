INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
	string1 byte 80 DUP (?)
	string2 byte 80 DUP (?)
	string3 byte 80 DUP (?)
	string4 byte 80 DUP (?)
    
	coord1	byte 20,0
	coord2	byte 40,0
	coord3	byte 60,0
	coord4	byte 80,0

	casc1	byte 20,0
	casc2	byte 40,0
	casc3	byte 60,0
	casc4	byte 80,0

	size1 dword ?
	size2 dword ?
	size3 dword ?
	size4 dword ?

    current byte 20 DUP(?)
	current_size dword ?
    cc      byte 2 DUP(?)
	startposx byte ?

	correct byte 2
	lastColor dword 15+(0*16)

	msec DWORD 0
	StartTime DWORD ?
	off1 dword ?
	off2 dword ?
	off3 dword ?
	off4 dword ?

	line byte 120 DUP('-')

	second dword 0

	totalcount dword 0
	correctcount dword 0
	wordstyped dword 0
	wordsmissed dword 0
	missed byte 0

	first byte 1
	firstsize dword ?

	LIMIT=60
	LINEHEIGHT=27
    TICK=250
	BUFMAX=256
	BUFMAXHEX=100h

	filename byte "words.txt"
	filehandle handle ?
	buffer byte BUFMAX+1 DUP(0)
	bytesRead dword ?

	bufind dword 0

.code
main proc
	;jmp GAME
		;Menu
	mGotoxy 55,10
	mWrite "TYPING GAME"
	mov eax, 1000
	call Delay
	mGotoxy 49,12
	mWrite "Assembly Final Project"
	mov eax, 1500
	call Delay
	mGotoxy 51,14
	mWrite "By Joshua Hanscom"
	mov eax, 1500
	call Delay
	call ClrScr
	mGotoxy 25,12
	mWrite "1. Play"
	mGotoxy 25,16
	;mWrite "2. Scoreboard"
	mGotoxy 0,0
	call ReadChar
	cmp al,'1'
	je GAME

	GAME:
		call ClrScr
		;jmp HERE
		mGotoxy 0,LINEHEIGHT
		mov ecx, 120
	FLOURISH:
		mov eax, 10
		call Delay
		mWrite "-"
		loop Flourish
		;initialize time variables
HERE:
	call GetMseconds
	mov StartTime, eax
	mov msec,eax
	mov off1, eax
	mov off2, eax
	add off2, 2000
	mov off3, eax
	add off3, 4000
	mov off4, eax
	add off4, 6000
	

	mov edx, offset filename
	call OpenInputFile
	mov filehandle,eax
	mov edx, offset buffer
	mov ecx, BUFMAX
	call ReadFromFile
	mov bytesRead, eax
	mov edx, offset buffer
	;call WriteString
	mov esi,0
	mov edi,0

FILEW1:
	mov esi, 0
	mov edi, bufind
	cmp edi, BUFMAX
	jae COMPLETE
WORD1:
	cmp buffer[edi],10
	je NEWWORD1
	mov al, buffer[edi]
	mov string1[esi],al
	inc esi
	inc edi
	jmp WORD1
NEWWORD1:
	inc edi
FILEDONE1:
	mov bufind,edi
	mov size1, esi
	mov firstsize,esi
	mov esi,0
	cmp first,1
	mov edi,0
	je FILEW2
	jmp SET2C

FILEW2:
	mov esi, 0
	mov edi, bufind
	cmp edi, BUFMAX
	jae COMPLETE
WORD2:
	cmp buffer[edi],10
	je NEWWORD2
	mov al, buffer[edi]
	mov string2[esi],al
	inc esi
	inc edi
	jmp WORD2
NEWWORD2:
	inc edi
FILEDONE2:
	mov bufind,edi
	mov size2, esi
	mov esi,0
	cmp first,1
	mov edi,0
	je FILEW3
	jmp SET3C

FILEW3:
	mov esi, 0
	mov edi, bufind
	cmp edi, BUFMAX
	jae COMPLETE
WORD3:
	cmp buffer[edi],10
	je NEWWORD3
	mov al, buffer[edi]
	mov string3[esi],al
	inc esi
	inc edi
	jmp WORD3
NEWWORD3:
	inc edi
FILEDONE3:
	mov bufind,edi
	mov size3, esi
	mov esi,0
	cmp first,1
	mov edi,0
	je FILEW4
	jmp SET4C

FILEW4:
	mov esi, 0
	mov edi, bufind
	cmp edi, BUFMAXHEX
	jae COMPLETE
WORD4:
	cmp buffer[edi],10
	je NEWWORD4
	mov al, buffer[edi]
	mov string4[esi],al
	inc esi
	inc edi
	jmp WORD4
NEWWORD4:
	inc edi
FILEDONE4:
	mov bufind,edi
	mov size4, esi
	mov esi,0
	cmp first,1
	mov edi,0
	je FIRSTIT
	jmp SET1C


SETFSIZE:
	mov first,0
	mov esi, firstsize
	mov current_size,esi
	jmp FIRSTIT
SET1:
		;replace last word
	jmp FILEW4
SET1C:
		;delay previous
	add off4,10000
	mov casc4[1],0
FIRSTIT:
	cmp first,1
	je SETFSIZE
		;set current string1
	push eax
	mov eax, size1
	mov current_size, eax
	pop eax
	mov ecx, current_size
	mov esi,0
	mov correct,2
	;mov current_size, lengthof string1
	mov bl, coord1[0]
	mov cc[0],bl
	mov startposx,bl
	mov bl, casc1[1]
	mov cc[1],bl
	jmp ASSIGN1

SET2:
		;replace last word
	jmp FILEW1
SET2C:
		;delay previous
	add off1,10000
	mov casc1[1],0
		;set current string2
	push eax
	mov eax, size2
	mov current_size, eax
	pop eax
	mov ecx, current_size
	mov esi,0
	mov correct,2
	;mov current_size, lengthof string2
	mov bl, coord2[0]
	mov cc[0],bl
	mov startposx,bl
	mov bl, casc2[1]
	mov cc[1],bl
	jmp ASSIGN2

SET3:
		;replace last word
	jmp FILEW2
SET3C:
		;delay previous
	add off2,10000
	mov casc2[1],0
		;set current string3
	push eax
	mov eax, size3
	mov current_size, eax
	pop eax
	mov ecx, current_size
	mov esi,0
	mov correct,2
	mov bl, coord3[0]
	mov cc[0],bl
	mov startposx,bl
	mov bl, casc3[1]
	mov cc[1],bl
	jmp ASSIGN3
SET4:
		;replace last word
	jmp FILEW3
SET4C:
		;delay previous
	add off3,10000
	mov casc3[1],0
		;set current string4
	mov esi,0
	mov correct,2
	push eax
	mov eax, size4
	mov current_size, eax
	pop eax
	mov ecx, current_size
	mov bl, coord4[0]
	mov cc[0],bl
	mov startposx,bl
	mov bl, casc4[1]
	mov cc[1],bl
	jmp ASSIGN4

ASSIGN1:
	mov al,string1[esi]
	mov current[esi], al
	inc esi
	loop ASSIGN1
	jmp DISPLAYSTR

ASSIGN2:
	mov al,string2[esi]
	mov current[esi], al
	inc esi
	loop ASSIGN2
	jmp DISPLAYSTR

ASSIGN3:
	mov al,string3[esi]
	mov current[esi], al
	inc esi
	loop ASSIGN3
	jmp DISPLAYSTR

ASSIGN4:
	mov al,string4[esi]
	mov current[esi], al
	inc esi
	loop ASSIGN4
	jmp DISPLAYSTR

DISPLAYSTR:
	mGotoxy startposx,cc[1]
	;set white text / black bkg
	mov eax, 15+(0*16)
	call SetTextColor
	mov eax,0
	mWriteString OFFSET	current

FALL:
		;prints timer
	mGotoxy 100,1
	push eax
	mov eax,second
	call WriteDec
	pop eax
		;prints white or red line
	cmp missed,1
	jne BOTLINE
	mov eax, 4+(0*16)
	call SetTextColor
	jmp BOTLINE2
BOTLINE:
	mov eax, 15+(0*16)
	call SetTextColor
	mov missed,0
BOTLINE2:
	mGotoxy 0,LINEHEIGHT
	mWriteString offset line
	mGotoxy startposx,cc[1]

	movzx ecx,cc[0]
	movzx esi, startposx
	sub ecx, esi
	mov esi,0

	CHECK:
		cmp correct,1
		je G
		cmp correct,0
		je R
		jmp NEUTRAL

	NEUTRAL:
		push eax
		mov eax, lastColor
		call SetTextColor
		pop eax
		jmp PRINT
	G:
		push eax
		mov eax, 2+(0*16)
		call SetTextColor
		mov lastColor,eax
		pop eax
		jmp PRINT
	R:
		push eax
		mov eax, 4+(0*16)
		call SetTextColor
		mov lastColor,eax
		pop eax
		jmp PRINT

	PRINT:
		cmp ecx,0
		jz REST
		push eax
		mov al, current[esi]
		call WriteChar
		pop eax
		inc esi
		loop PRINT

		pushad
		movzx eax,cc[0]
		movzx ebx,startposx
		sub eax,ebx
		mov ebx,current_size
		dec ebx
		cmp eax, ebx
		popad
		jae DONE

	REST:
		mov ecx,current_size
		push eax
		movzx eax, cc[0]
		movzx edi, startposx
		sub eax, edi
		sub ecx,eax
		mov eax, 15+(0*16)
		call SetTextColor
		pop eax
		mov edi,esi

	RESTPRINT:
		push eax
		mov al, current[edi]
		call WriteChar
		pop eax
		inc edi
		loop RESTPRINT

	CASCADE:
			;print string1
		mov ax, word ptr current
		mov bx, word ptr string1
		cmp ax,bx
		je PRINT2

		mov bl,casc1[0]
		mov bh,casc1[1]
		mGotoxy bl,bh

		pushad
		mov eax,0
		call GetMseconds
		mov ebx,off1
		add ebx,TICK
		cmp eax,ebx
		popad
		jb PRINT2

		mWriteString offset string1
		inc casc1[1]

	PRINT2:
			;print string2
		mov ax, word ptr current
		mov bx, word ptr string2
		cmp ax,bx
		je PRINT3

		mov bl,casc2[0]
		mov bh,casc2[1]
		mGotoxy bl,bh
		pushad
		mov eax,0
		call GetMseconds
		mov ebx,off2
		add ebx,TICK
		cmp eax,ebx
		popad
		jb PRINT3

		mWriteString offset string2
		inc casc2[1]

	PRINT3:
			;print string3
		mov ax, word ptr current
		mov bx, word ptr string3
		cmp ax,bx
		je PRINT4
		mov bl,casc3[0]
		mov bh,casc3[1]
		mGotoxy bl,bh

		pushad
		mov eax,0
		call GetMseconds
		mov ebx,off3
		add ebx,TICK
		cmp eax,ebx
		popad
		jb PRINT4

		mWriteString offset string3
		inc casc3[1]

	PRINT4:
			;print string4
		mov ax, word ptr current
		mov bx, word ptr string4
		cmp ax,bx
		je TIME
		mov bl,casc4[0]
		mov bh,casc4[1]
		mGotoxy bl,bh

		pushad
		mov eax,0
		call GetMseconds
		mov ebx,off4
		add ebx,TICK
		cmp eax,ebx
		popad
		jb TIME

		mWriteString offset string4
		inc casc4[1]
		
TIME:
	mGotoxy cc[0],cc[1]
	pushad
	mov eax,0
	call GetMseconds
	mov ebx,msec
	add ebx,TICK
	cmp eax,ebx
	popad
	jb READK

	pushfd
	add msec,TICK
	mov correct,2
		;falls one line
	inc cc[1]
	mov missed,0
		;checks if word hit line
	cmp cc[1],LINEHEIGHT
	jb TIMER

		;adds missed characters to totalcount
	pushad
	mov eax, current_size
	movzx ebx, cc[0]
	movzx ecx, startposx
	sub ebx,ecx
	sub eax,ebx
	add totalcount,eax
	mov missed,1
	popad
	inc wordsmissed
	jmp MISSEDWORD	; move to next word

TIMER: ; prints current second elapsed in top right
	mGotoxy 115,1
	mov eax, msec
	sub eax,StartTime
	;divide start time by TICK
	shr eax,10
	mov second, eax
	cmp eax,LIMIT
	jae FIN
	popfd
	jmp NOINPUT

READK:
		;reads char
	push ebx
	call ReadKey
	pop ebx
	jnz READ
	jmp TIME

NOINPUT:
	pushfd
		;clear screen before print next line
	call Clrscr
	popfd
	jmp FALL

READ:
			;check input
		cmp al, current[esi]
		jnz WRONG
	RIGHT:
		mov correct,1
		inc totalcount
		inc correctcount
		jmp CONT
	WRONG:
		mov correct,0
		inc totalcount
		jmp NOCONT
	CONT:
		inc cc[0]
	NOCONT:
		jmp NOINPUT
	
DONE:
	inc wordstyped
	jmp CONTINUE

MISSEDWORD:
CONTINUE:
	pushad
	mov ax, word ptr current
	mov bx, word ptr string1
	cmp ax,bx
	pushad
	pushfd
	call ClrScr	
	popfd
	popad
	je SET2

	mov bx, word ptr string2
	cmp ax,bx
	pushad
	pushfd
	call ClrScr	
	popfd
	popad
	je SET3

	mov bx, word ptr string3
	cmp ax,bx
	pushad
	pushfd
	call ClrScr	
	popfd
	popad
	je SET4

	mov bx, word ptr string4
	cmp ax,bx
	pushad
	pushfd
	call ClrScr	
	popfd
	popad
	je SET1
COMPLETE:
	call ClrScr
	mGotoxy 50,3
	mWrite "Completed all words!"
	mov eax, 1000
	call Delay
FIN:
	;set white text / black bkg
	mov eax, 15+(0*16)
	call SetTextColor
	mGotoxy 0,0
	call ClrScr
	mGotoxy 50,3
	mWrite "Words Typed: "
	mov eax, wordstyped
	call WriteDec
	mGotoxy 50,5
	mWrite "Words Missed: "
	mov eax, wordsmissed
	call WriteDec


	mGotoxy 47,7
	mWrite "Words Per Minute: "
	mov eax, msec
	sub eax, StartTime
	shr eax, 9
	mov ebx, eax
	mov eax, wordstyped
	mov	ecx,60
	mul ecx
	div ebx
	shl eax,1
	call WriteDec


	mGotoxy 42,9
	mWrite "Accuracy: "
	mov eax, correctcount
	call WriteDec
	mWrite " / "
	mov eax, totalcount
	call WriteDec
	mWrite " characters = "

	mov eax, correctcount
	mov ebx, 100
	mul ebx
	mov ebx,totalcount
	div ebx
	call WriteDec
	mWrite "."
	mov eax,edx
	mov ebx,100
	mul ebx
	mov ebx, totalcount
	div ebx
	call WriteDec
	mWrite "%"
	mGotoxy 42,50
	

	invoke ExitProcess,0
main endp
end main 