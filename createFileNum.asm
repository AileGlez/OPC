TITLE Creating a File              (createFileNum.asm)

Comment !
Use of File procedures.
!

INCLUDE myIrvine.inc

mCr=0dh
mLf=0ah
mNul=00h
totElem=50

.DATA
fHandle DWORD ?
fName BYTE "two.bin",mNul
arreglo sDWORD totElem+1 DUP(?) ; buffer

adios BYTE mCr,mLf, "ADIOS.",mNul
byEscri BYTE mCr,mLf, "Bytes Escritos: ",mNul

; Procedimiento GenerateValues
dirRet DWORD ?

.CODE
main PROC

; Create the file
    MOV EDX, OFFSET fName
    CALL CreateOutputFile
    MOV fHandle, EAX 

; Generate the array of values
    PUSH OFFSET arreglo
    PUSH totElem 
    CALL generateValues
    
      
; Write into the file
    MOV EAX, fHandle
    MOV EDX, OFFSET arreglo 
    MOV ECX, SIZEOF arreglo 
    CALL WriteToFile   ; EAX with the number of bytes written 
    MOV EDX, OFFSET byEscri
    CALL WriteString 
    CALL CrLf

; Close the file
    MOV EAX,  fHandle
    CALL CloseFile

; Adios
      mov EDX, OFFSET adios
      call WriteString
      call CrLf

	EXIT
main ENDP

;------------------------------------------------------------
generateValues PROC
;
; Generates values from -1,-2,-3,... and stores in an array.
; Receives: pop ECX = number of elements, pop ESI points to the array
; Returns: nothing, the result is intrinsec in the array
;------------------------------------------------------------
        POP dirRet
        POP ECX 
        POP ESI 

        MOV [ESI], ECX ; the number of elements of the buffer 
        ADD ESI, TYPE SDWORD 
        MOV EAX, ECX 
        CALL WriteInt
        CALL CrLF 

        MOV EBX, 1 ; control variable 
        .WHILE EBX <= ECX
            MOV EAX, EBX
            NEG EAX ; EAX has the negative value 
            CALL WriteInt
            CALL CrLf

            MOV [ESI], EAX ; storing the negative value
            ADD ESI, TYPE SDWORD
            INC EBX
        .ENDW
        PUSH dirRet
	RET
generateValues ENDP

END main