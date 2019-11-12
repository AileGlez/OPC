TITLE Creating a File              (readFromFileNum.asm)

Comment !
Use of File procedures.
!

INCLUDE myIrvine.inc

mCr=0dh
mLf=0ah
mNul=00h
totElemMax=100

.DATA
fHandle DWORD ?
fName BYTE "two.bin",mNul
arreglo SDWORD totElemMax+1 DUP(?)
eleArre SDWORD ?    ; Elements recovered, in the array

adios BYTE mCr,mLf, "ADIOS.",mNul
byLei BYTE mCr,mLf, "Bytes Leidos: ",mNul
eleRec BYTE mCr,mLf, "Elementos recuperados: ",mNul

; Procedimiento printValues
dirRet DWORD ?

.CODE
main PROC

; Create the file
    MOV EDX, OFFSET fName
    CALL OpenInputFile
    MOV fHandle, EAX 

; Read from the file
    MOV EAX, fHandle
    MOV EDX, OFFSET arreglo 
    MOV ECX, SIZEOF arreglo 
    CALL ReadFromFile   ; EAX with the number of bytes read
    MOV EDX, OFFSET byLei
    CALL WriteString 
    CALL CrLf

; Display the array of values
    PUSH OFFSET arreglo
    CALL PrintValues
    POP eleArre

; Elements recovered in the arreglo
    MOV EDX, OFFSET eleRec 
    CALL WriteString 
    MOV EAX, eleArre 
    CALL WriteInt 
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
printValues PROC
;
; Print values from the array.
; Receives: pop ESI points to the array
; Returns: The amount of elements in the array
;------------------------------------------------------------
      POP dirRet
      POP ESI 

      MOV ECX, [ESI] ; the number of elements, in first place
      ADD ESI, TYPE SDWORD 
      MOV  EAX, ECX 
      CALL CrLf 
      CALL WriteInt
      CALL CrLf

      MOV EBX, 1 ; control variable 
      .WHILE EBX <= ECX
          MOV EAX, [ESI]
          ADD ESI, TYPE SDWORD 
          CALL WriteInt
          CALL CrLf

          INC EBX

      .ENDW
      PUSH ECX
      PUSH dirRet

	RET
printValues ENDP

END main