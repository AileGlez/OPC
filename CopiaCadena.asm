TITLE *MASM Template	(quinto5.asm)*

; Descripcion:
; Uso de "Type" PTR
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
cad1    BYTE  "CADENA", 0 
cad2    BYTE  100 DUP(?) 
adios    BYTE "ADIOS", 0

; procedimiento
dirRet DWORD ? 

.CODE
; Procedimiento principal
main PROC

    PUSH OFFSET cad1
    PUSH OFFSET cad2

    CALL CopiaCade

    MOV EDX, OFFSET cad2
    CALL WriteString
        
    exit
main ENDP
    
CopiaCade PROC
    POP dirRet
    POP EDI 
    POP ESI 
    
    MOV EAX, [ESI]
    
    .WHILE EAX != 0 
        MOV [EDI], EAX 
        ADD ESI, TYPE BYTE
        ADD EDI, TYPE BYTE
    .ENDW 

    PUSH dirRet
    RET
CopiaCade ENDP 

END main