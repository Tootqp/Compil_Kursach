section .bss
	digitSpace resb 100
	digitSpacePos resb 8

	Vi resb 8
	Va resb 8
	Vb resb 8
	Vc resb 8
	T1 resb 8
	T2 resb 8
	T3 resb 8
	T4 resb 8
	T5 resb 8
section .data
	text db "start",10

	S1 db "Результат работы цикла:",10,0
	S2 db "Произведение а*в будет равно:",10,0
	S3 db "Произведение b*(a*a)*2 будет равно:",10,0
section .text
	global _start

_start:

	mov rax,10
	mov [Vi],rax
	mov rax,99
	mov [Va],rax
	mov rax,8799
	mov [Vb],rax
	mov rax,S1
	call _print_string
	L1 : 
	mov rax,[Vi]
	mov rbx,100
	cmp rax,rbx
	jl L2
	jmp L3
	L2 : 
mov rax,[Vi]
	call _print_num
	mov rax,[Vi]
	add rax,10
	mov [T1],rax
	mov rax,[T1]
	mov [Vi],rax
	jmp L1
	L3 : 
	mov rax,[Va]
	mov rbx,100
	cmp rax,rbx
	jg L4
	jmp L6
	L4 : 
	mov rax,[Va]
	mov rbx,[Vb]
	mul rbx
	mov [T2],rax
	mov rax,[T2]
	mov [Vc],rax
	mov rax,S2
	call _print_string
mov rax,[Vc]
	call _print_num
	jmp L5
	L6 : 
	mov rax,[Va]
	mov rbx,[Va]
	mul rbx
	mov [T3],rax
	mov rbx,[Vb]
	mul rbx
	mov [T4],rax
	mov rbx,2
	mul rbx
	mov [T5],rax
	mov rax,[T5]
	mov [Vc],rax
	mov rax,S3
	call _print_string
mov rax,[Vc]
	call _print_num
	L5 : 

	mov rax, 60
	mov rdi, 0
	syscall



_print_num:
    mov rcx, digitSpace
    mov rbx, 10
    mov [rcx], rbx
    inc rcx
    mov [digitSpacePos], rcx

_printRAXLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48

    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx

    pop rax
    cmp rax, 0
    jne _printRAXLoop

_printRAXLoop2:
    mov rcx, [digitSpacePos]

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall

    mov rcx, [digitSpacePos]
    dec rcx
    mov [digitSpacePos], rcx

    cmp rcx, digitSpace
    jge _printRAXLoop2

    ret


_print_string:
    push rax
    mov rbx, 0

_printLoop:
    inc rax
    inc rbx
    mov cl, [rax]
    cmp cl, 0
    jne _printLoop

    mov rax, 1
    mov rdi, 1
    pop rsi
    mov rdx, rbx
    syscall

    ret

        
