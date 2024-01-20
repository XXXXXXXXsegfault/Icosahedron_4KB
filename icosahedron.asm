@WinName
.string "Icosahedron"

@p_line
# 40(%rsp) -- x
# 48(%rsp) -- y
# 56(%rsp) -- x2
# 64(%rsp) -- color
push %rax
push %rcx
push %rdx
push %rsi

mov 48(%rsp),%eax
lea (%rax,%rax,4),%eax
lea (%rax,%rax,4),%eax
shl $6,%eax
movslq %eax,%rax
neg %rax

mov 40(%rsp),%edx
mov 56(%rsp),%esi
mov 64(%rsp),%ecx
cmp %edx,%esi
jg @p_line_X1
xchg %edx,%esi
@p_line_X1
movslq %edx,%rdx
movslq %esi,%rsi
lea @_$DATA+4096+320000+800(%rax,%rdx,4),%rax
@p_line_X2
cmp %rdx,%rsi
jle @p_line_X3
mov %ecx,(%rax)
add $4,%rax
inc %rdx
jmp @p_line_X2
@p_line_X3
pop %rsi
pop %rdx
pop %rcx
pop %rax
ret

@p_triangle_2d
push %rbp
mov %rsp,%rbp
push %rax
push %rcx
push %rdx
push %rsi
push %rdi

# 16(%rbp) -- x1
# 24(%rbp) -- y1
# 32(%rbp) -- x2
# 40(%rbp) -- y2
# 48(%rbp) -- x3
# 56(%rbp) -- y3
# 64(%rbp) -- color
mov 24(%rbp),%eax
mov 40(%rbp),%ecx
cmp %eax,%ecx
jg @p_triangle_2d_X1
mov %ecx,24(%rbp)
mov %eax,40(%rbp)
mov 16(%rbp),%eax
mov 32(%rbp),%ecx
mov %ecx,16(%rbp)
mov %eax,32(%rbp)
@p_triangle_2d_X1
mov 24(%rbp),%eax
mov 56(%rbp),%ecx
cmp %eax,%ecx
jg @p_triangle_2d_X2
mov %ecx,24(%rbp)
mov %eax,56(%rbp)
mov 16(%rbp),%eax
mov 48(%rbp),%ecx
mov %ecx,16(%rbp)
mov %eax,48(%rbp)
@p_triangle_2d_X2
mov 40(%rbp),%eax
mov 56(%rbp),%ecx
cmp %eax,%ecx
jg @p_triangle_2d_X3
mov %ecx,40(%rbp)
mov %eax,56(%rbp)
mov 32(%rbp),%eax
mov 48(%rbp),%ecx
mov %ecx,32(%rbp)
mov %eax,48(%rbp)
@p_triangle_2d_X3

pushq 64(%rbp)
sub $24,%rsp
mov 24(%rbp),%ecx
@p_triangle_2d_A11
cmp %ecx,40(%rbp)
jle @p_triangle_2d_A12
mov %ecx,%eax
sub 24(%rbp),%eax
mov 32(%rbp),%edx
sub 16(%rbp),%edx
mov 40(%rbp),%esi
sub 24(%rbp),%esi
imul %edx
idiv %esi
mov %eax,%edi
add 16(%rbp),%edi

mov %ecx,%eax
sub 24(%rbp),%eax
mov 48(%rbp),%edx
sub 16(%rbp),%edx
mov 56(%rbp),%esi
sub 24(%rbp),%esi
imul %edx
idiv %esi
mov %eax,%esi
add 16(%rbp),%esi
mov %esi,(%rsp)
mov %edi,16(%rsp)
mov %ecx,8(%rsp)
call @p_line

inc %ecx
jmp @p_triangle_2d_A11
@p_triangle_2d_A12
cmp %ecx,56(%rbp)
jle @p_triangle_2d_A13
mov %ecx,%eax
sub 40(%rbp),%eax
mov 48(%rbp),%edx
sub 32(%rbp),%edx
mov 56(%rbp),%esi
sub 40(%rbp),%esi
imul %edx
idiv %esi
mov %eax,%edi
add 32(%rbp),%edi

mov %ecx,%eax
sub 24(%rbp),%eax
mov 48(%rbp),%edx
sub 16(%rbp),%edx
mov 56(%rbp),%esi
sub 24(%rbp),%esi
imul %edx
idiv %esi
mov %eax,%esi
add 16(%rbp),%esi
mov %esi,(%rsp)
mov %edi,16(%rsp)
mov %ecx,8(%rsp)
call @p_line

inc %ecx
jmp @p_triangle_2d_A12
@p_triangle_2d_A13
add $32,%rsp
pop %rdi
pop %rsi
pop %rdx
pop %rcx
pop %rax
mov %rbp,%rsp
pop %rbp
ret

@p_triangle_3d
movups 8(%rsp),%xmm0
movups 56(%rsp),%xmm1

push %rax
mov $8,%eax
cvtsi2ss %eax,%xmm4
xor %eax,%eax
cvtsi2ss %eax,%xmm5
pop %rax

subss %xmm4,%xmm0
mulps %xmm0,%xmm1
movss %xmm1,%xmm2
shufps $0x12,%xmm1,%xmm1
addss %xmm1,%xmm2
shufps $0x12,%xmm1,%xmm1
addss %xmm1,%xmm2
comiss %xmm5,%xmm2
jb @p_triangle_3d_A1
ret
@p_triangle_3d_A1

movss 56(%rsp),%xmm0
push %rax
mov $250,%eax
cvtsi2ss %eax,%xmm1
mulss %xmm1,%xmm0
cvtss2si %xmm0,%eax
mov %al,%ah
shl $8,%eax
mov %ah,%al

movups 16(%rsp),%xmm0
movups 32(%rsp),%xmm1
movups 48(%rsp),%xmm2

movss %xmm4,%xmm3
subss %xmm0,%xmm3
shufps $0x0,%xmm3,%xmm3
divps %xmm3,%xmm0
movss %xmm4,%xmm3
subss %xmm1,%xmm3
shufps $0x0,%xmm3,%xmm3
divps %xmm3,%xmm1
movss %xmm4,%xmm3
subss %xmm2,%xmm3
shufps $0x0,%xmm3,%xmm3
divps %xmm3,%xmm2

push %rax
mov $200,%eax
cvtsi2ss %eax,%xmm3
shufps $0x0,%xmm3,%xmm3

mulps %xmm3,%xmm2
shufps $0x12,%xmm2,%xmm2
cvtss2si %xmm2,%eax
push %rax
shufps $0x12,%xmm2,%xmm2
cvtss2si %xmm2,%eax
push %rax

mulps %xmm3,%xmm1
shufps $0x12,%xmm1,%xmm1
cvtss2si %xmm1,%eax
push %rax
shufps $0x12,%xmm1,%xmm1
cvtss2si %xmm1,%eax
push %rax

mulps %xmm3,%xmm0
shufps $0x12,%xmm0,%xmm0
cvtss2si %xmm0,%eax
push %rax
shufps $0x12,%xmm0,%xmm0
cvtss2si %xmm0,%eax
push %rax

call @p_triangle_2d
add $56,%rsp
pop %rax
ret
.align 2
@sqrt3
.long 0x3fddb3d7
@sqrt3_2
.long 0x405db3d7
@distance
.long 0x40278dde
@cosB
.long 0x3f3ecfa6
@sinB
.long 0x3f2aaaab

@triangle_init
push %rax
mov $0x40000000,%eax
movd %eax,%xmm0
shufps $0,%xmm0,%xmm0
mov @distance,%eax
or $0x80000000,%eax
movd %eax,%xmm2
shufps $0,%xmm2,%xmm2
movups %xmm0,%xmm3
movups %xmm2,%xmm5
mulps @_$DATA+32,%xmm3
mulps @_$DATA+64,%xmm5
addps %xmm5,%xmm3
movups %xmm3,@_$DATA+80

mov $0xbf800000,%eax
movd %eax,%xmm0
shufps $0,%xmm0,%xmm0
mov @sqrt3,%eax
movd %eax,%xmm1
shufps $0,%xmm1,%xmm1
movups %xmm0,%xmm3
movups %xmm1,%xmm4
mulps @_$DATA+32,%xmm3
mulps @_$DATA+48,%xmm4
addps %xmm5,%xmm3
addps %xmm4,%xmm3
movups %xmm3,@_$DATA+96

mov @sqrt3,%eax
or $0x80000000,%eax
movd %eax,%xmm1
shufps $0,%xmm1,%xmm1
movups %xmm0,%xmm3
movups %xmm1,%xmm4
mulps @_$DATA+32,%xmm3
mulps @_$DATA+48,%xmm4
addps %xmm5,%xmm3
addps %xmm4,%xmm3
movups %xmm3,@_$DATA+112

movups %xmm0,%xmm3
mulps @_$DATA+64,%xmm3
movups %xmm3,@_$DATA+128

pop %rax
ret

@triangle_paint
sub $64,%rsp
movups @_$DATA+80,%xmm0
movups %xmm0,(%rsp)
movups @_$DATA+96,%xmm0
movups %xmm0,16(%rsp)
movups @_$DATA+112,%xmm0
movups %xmm0,32(%rsp)
movups @_$DATA+128,%xmm0
movups %xmm0,48(%rsp)
call @p_triangle_3d
add $64,%rsp
ret

@triangle_rotate
# %eax -- p1
# %ecx -- p2
# %edx -- p3
push %rax
push %rsi
mov %rax,%rsi
movups @_$DATA+80(%rcx),%xmm1
subps @_$DATA+80(%rax),%xmm1

movss @sqrt3_2,%xmm7
shufps $0,%xmm7,%xmm7


movups @_$DATA+128,%xmm2
movups %xmm1,%xmm3
divps %xmm7,%xmm3
movups %xmm3,%xmm4
movups %xmm2,%xmm5
movups %xmm2,%xmm6
shufps $0x09,%xmm3,%xmm3
shufps $0x12,%xmm4,%xmm4
shufps $0x12,%xmm5,%xmm5
shufps $0x09,%xmm6,%xmm6
mulps %xmm5,%xmm3
mulps %xmm6,%xmm4
subps %xmm4,%xmm3

# %xmm2 -- x
# %xmm3 -- y

movss @cosB,%xmm5
movss @sinB,%xmm6
shufps $0,%xmm5,%xmm5
shufps $0,%xmm6,%xmm6

movups %xmm5,%xmm7
movups %xmm6,%xmm8

mulps %xmm2,%xmm8
mulps %xmm3,%xmm7
subps %xmm8,%xmm7

mulps %xmm2,%xmm5
mulps %xmm3,%xmm6
addps %xmm6,%xmm5

#xor %eax,%eax
#cvtsi2ss %eax,%xmm0
#shufps $0,%xmm0,%xmm0
#subps %xmm5,%xmm0
#movups %xmm0,%xmm5

mov $3,%eax
cvtsi2ss %eax,%xmm0
shufps $0,%xmm0,%xmm0
mulps %xmm0,%xmm7
mov $2,%eax
cvtsi2ss %eax,%xmm0
shufps $0,%xmm0,%xmm0
divps %xmm0,%xmm1
addps @_$DATA+80(%rsi),%xmm1
addps %xmm7,%xmm1
movups %xmm1,@_$DATA+80(%rdx)
movups %xmm5,@_$DATA+128

pop %rsi
pop %rax
ret

@triangle_op
.byte 0xc0,0x46,0x52,0x61,0x49,0x58
.byte 0x80,0x06,0x64,0x58
.byte 0x80,0x58,0x49,0x61
.byte 0x80,0x18,0x64,0x46,0x52
.byte 0x80,0x61,0x52,0x46
.byte 0x80,0x21,0x49,0x58,0x64
@triangle_op_end
.align 2
@cos1D
.long 0x3f7ff605
@sin1D
.long 0x3c8ef859

@rotate_z1
# %rax -- vector
movss (%rax),%xmm0
movss 4(%rax),%xmm1
movss %xmm0,%xmm2
movss %xmm1,%xmm3
mulss @cos1D,%xmm0
mulss @sin1D,%xmm1
mulss @sin1D,%xmm2
mulss @cos1D,%xmm3
addss %xmm1,%xmm0
subss %xmm2,%xmm3
movss %xmm0,(%rax)
movss %xmm3,4(%rax)
ret
@rotate_z2
# %rax -- vector
movss (%rax),%xmm0
movss 4(%rax),%xmm1
movss %xmm0,%xmm2
movss %xmm1,%xmm3
mulss @cos1D,%xmm0
mulss @sin1D,%xmm1
mulss @sin1D,%xmm2
mulss @cos1D,%xmm3
subss %xmm1,%xmm0
addss %xmm2,%xmm3
movss %xmm0,(%rax)
movss %xmm3,4(%rax)
ret
@rotate_y1
# %rax -- vector
movss (%rax),%xmm0
movss 8(%rax),%xmm1
movss %xmm0,%xmm2
movss %xmm1,%xmm3
mulss @cos1D,%xmm0
mulss @sin1D,%xmm1
mulss @sin1D,%xmm2
mulss @cos1D,%xmm3
addss %xmm1,%xmm0
subss %xmm2,%xmm3
movss %xmm0,(%rax)
movss %xmm3,8(%rax)
ret
@rotate_y2
# %rax -- vector
movss (%rax),%xmm0
movss 8(%rax),%xmm1
movss %xmm0,%xmm2
movss %xmm1,%xmm3
mulss @cos1D,%xmm0
mulss @sin1D,%xmm1
mulss @sin1D,%xmm2
mulss @cos1D,%xmm3
subss %xmm1,%xmm0
addss %xmm2,%xmm3
movss %xmm0,(%rax)
movss %xmm3,8(%rax)
ret

@do_rotate
mov @_$DATA+25,%al
test %al,%al
je @T_paint_K

cmp $1,%al
jne @K_LEFT
mov $@_$DATA+32,%rax
call @rotate_z2
add $16,%rax
call @rotate_z2
add $16,%rax
call @rotate_z2
movb $1,@_$DATA+24
jmp @T_paint_K
@K_LEFT

cmp $3,%al
jne @K_RIGHT
mov $@_$DATA+32,%rax
call @rotate_z1
add $16,%rax
call @rotate_z1
add $16,%rax
call @rotate_z1
movb $1,@_$DATA+24
jmp @T_paint_K
@K_RIGHT

cmp $2,%al
jne @K_UP
mov $@_$DATA+32,%rax
call @rotate_y1
add $16,%rax
call @rotate_y1
add $16,%rax
call @rotate_y1
movb $1,@_$DATA+24
jmp @T_paint_K
@K_UP

mov $@_$DATA+32,%rax
call @rotate_y2
add $16,%rax
call @rotate_y2
add $16,%rax
call @rotate_y2
movb $1,@_$DATA+24
@T_paint_K
ret

@paint_all


mov $80000,%ecx
xor %eax,%eax
mov $@_$DATA+4096,%rdx
@T_paint_clear
mov %rax,(%rdx)
add $8,%rdx
dec %ecx
jne @T_paint_clear

mov $@triangle_op,%rax
@T_paint_loop_X1
cmp $@triangle_op_end,%rax
jae @T_paint_loop_X2
mov (%rax),%cl
test $0x80,%cl
je @T_paint_loop_X3
call @triangle_init
jmp @T_paint_loop_X4
@T_paint_loop_X3
mov %ecx,%edx
mov %edx,%esi
shl $2,%esi
mov %esi,%edi
shl $2,%edi
and $0x30,%esi
and $0x30,%edi
and $0x30,%edx
push %rax
push %rcx
mov %edi,%eax
mov %esi,%ecx
call @triangle_rotate
pop %rcx
pop %rax

@T_paint_loop_X4
call @triangle_paint
inc %rax
jmp @T_paint_loop_X1
@T_paint_loop_X2
ret


@WndProc
push %rbx
push %r9
push %r8
push %rdx
push %rcx
cmp $2,%edx
jne @WndProc_DESTROY
xor %ecx,%ecx
mov %rcx,(%rsp)
.dllcall "msvcrt.dll" "exit"
@WndProc_DESTROY
cmp $15,%edx
jne @WndProc_PAINT
push %rbp
mov %rsp,%rbp
sub $128,%rsp
and $0xf0,%spl

lea 32(%rsp),%rdx
.dllcall "user32.dll" "BeginPaint"
mov %rax,112(%rsp)
mov %rax,%rcx
.dllcall "gdi32.dll" "CreateCompatibleDC"
mov %rax,104(%rsp)
mov 112(%rsp),%rcx
mov $400,%edx
mov %edx,%r8d
.dllcall "gdi32.dll" "CreateCompatibleBitmap"
mov %rax,96(%rsp)
mov %rax,%rdx
mov 104(%rsp),%rcx
.dllcall "gdi32.dll" "SelectObject"
call @paint_all
mov 96(%rsp),%rcx
mov $640000,%edx
mov $@_$DATA+4096,%r8
.dllcall "gdi32.dll" "SetBitmapBits"
mov 112(%rsp),%rcx
xor %edx,%edx
mov %edx,%r8d
mov $400,%r9d
push %rdx
pushq $0xcc0020
push %rdx
push %rdx
pushq 136(%rsp)
push %r9
sub $32,%rsp
.dllcall "gdi32.dll" "BitBlt"
add $80,%rsp
mov 104(%rsp),%rcx
.dllcall "gdi32.dll" "DeleteObject"
mov 112(%rsp),%rcx
.dllcall "gdi32.dll" "DeleteDC"
lea 32(%rsp),%rdx
mov 8(%rbp),%rcx
.dllcall "user32.dll" "EndPaint"
mov %rbp,%rsp
pop %rbp

jmp @WndProc_KEYUP
@WndProc_PAINT

cmp $275,%edx
jne @WndProc_TIMER
call @do_rotate
sub $32,%rsp
xor %edx,%edx
xor %r8d,%r8d
.dllcall "user32.dll" "InvalidateRect"
add $32,%rsp
jmp @WndProc_KEYUP
@WndProc_TIMER

cmp $256,%edx
jne @WndProc_KEYDOWN
cmp $0x25,%r8d
jne @KEYDOWN_LEFT
movb $1,@_$DATA+25
@KEYDOWN_LEFT
cmp $0x26,%r8d
jne @KEYDOWN_UP
movb $2,@_$DATA+25
@KEYDOWN_UP
cmp $0x27,%r8d
jne @KEYDOWN_RIGHT
movb $3,@_$DATA+25
@KEYDOWN_RIGHT
cmp $0x28,%r8d
jne @KEYDOWN_DOWN
movb $4,@_$DATA+25
@KEYDOWN_DOWN
@WndProc_KEYDOWN
cmp $257,%edx
jne @WndProc_KEYUP
cmp $0x25,%r8d
jb @WndProc_KEYUP
cmp $0x28,%r8d
ja @WndProc_KEYUP
movb $0,@_$DATA+25
@WndProc_KEYUP
pop %rcx
pop %rdx
pop %r8
pop %r9
sub $32,%rsp
.dllcall "user32.dll" "DefWindowProcA"
add $32,%rsp
pop %rbx
ret

.entry
mov $0x3f800000,%eax
mov %eax,@_$DATA+32
mov %eax,@_$DATA+52
mov %eax,@_$DATA+72
sub $88,%rsp
.dllcall "user32.dll" "SetProcessDPIAware"
movq $80,(%rsp)
movq $@WndProc,8(%rsp)
movq $0,16(%rsp)
movq $0x400000,24(%rsp)
sub $32,%rsp
xor %ecx,%ecx
mov $0x7f00,%edx
mov %rcx,(%rsp)
mov %rdx,8(%rsp)
.dllcall "user32.dll" "LoadIconA"
mov %rax,64(%rsp)
xor %ecx,%ecx
mov $0x7f00,%edx
mov %rcx,(%rsp)
mov %rdx,8(%rsp)
.dllcall "user32.dll" "LoadCursorA"
mov %rax,72(%rsp)
add $32,%rsp
movq $8,48(%rsp)
movq $0,56(%rsp)
movq $@WinName,64(%rsp)
movq $0,72(%rsp)
mov %rsp,%rcx
sub $24,%rsp
push %rcx
.dllcall "user32.dll" "RegisterClassExA"
test %rax,%rax
je @Err
pushq $0
pushq $0x400000
pushq $0
pushq $0
pushq $429
pushq $406
pushq $0
pushq $0
mov $0x10c80000,%r9d
mov $@WinName,%r8d
mov %r8d,%edx
mov $0x100,%ecx
push %r9
push %r8
push %rdx
push %rcx
.dllcall "user32.dll" "CreateWindowExA"
test %rax,%rax
je @Err
mov %rax,%rcx
xor %edx,%edx
mov $10,%r8d
xor %r9d,%r9d
.dllcall "user32.dll" "SetTimer"
@MsgLoop
lea 32(%rsp),%rcx
xor %edx,%edx
mov %edx,%r8d
mov %edx,%r9d
.dllcall "user32.dll" "GetMessageA"
cmp $0,%rax
jle @Err
lea 32(%rsp),%rcx
.dllcall "user32.dll" "TranslateMessage"
lea 32(%rsp),%rcx
.dllcall "user32.dll" "DispatchMessageA"
jmp @MsgLoop

@Err
xor %ecx,%ecx
push %rcx
push %rcx
.dllcall "msvcrt.dll" "exit"
.datasize 644096
# DATA
# 0 -- dc
# 8 -- memdc
# 16 -- bmp
# 24 -- paint
# 25 -- key
# 32 -- xaxis
# 48 -- yaxis
# 64 -- zaxis
# 80 -- triangle
# 4096 -- pbuf