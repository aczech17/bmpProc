global proceed
		;pixelArray - RDI
		;width		- RSI
		;height		- RDX
proceed:
		mov		r8, rdx	; R8 - height
		
		mov		rax, rsi
		imul	rax, 3
		and		rax, 3
		cmp		rax, 0
		je		padding0
		mov		rbx, 4
		sub		rbx, rax
		jmp		read_file
padding0:
		mov		rbx, 0
read_file:
		mov		rcx, 0
		mov		r9, 0
read_loop:
		cmp		rcx, rsi
		je		next_line
do_something:
		mov		rax, 0
		mov		rdx, 0
		
		mov		al, 255
		mov		dl, [rdi]
		sub		al, dl
		mov		[rdi], al
		
		mov		al, 255
		mov		dl, [rdi+1]
		sub		al, dl
		mov		[rdi+1], al
		
		mov		al, 255
		mov		dl, [rdi+2]
		sub		al, dl
		mov		[rdi+2], al
		
next_pixel:
		add		rcx, 1
		add		rdi, 3
		jmp		read_loop
next_line:
		add		r9, 1
		cmp		r9, r8
		je		exit
		
		add		rdi, rbx
		mov		rcx, 0
		jmp		read_loop
exit:
		ret
