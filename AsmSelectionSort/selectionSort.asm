INCLUDE Irvine32.inc

.data
    arraySize DWORD 10
    array DWORD 10 dup (?)

    promptPassValues db "Pass 10 values to array:", 0
    promptOriginal db "Original array:", 0
    promptSorted db "Sorted array:", 0

.code
main PROC
    ; Read numbers into the array
    mov edx, OFFSET promptPassValues
    call WriteString
    call Crlf
    call ReadArray

    ; Display the original array
    mov edx, OFFSET promptOriginal
    call WriteString
    call Crlf
    call DisplayArray

    ; Sort the array using Insertion Sort
    call SelectionSort

    ; Display the sorted array
    mov edx, OFFSET promptSorted
    call WriteString
    call Crlf
    call DisplayArray

    exit
main ENDP

; Selection Sort procedure
SelectionSort PROC
    mov ecx, 0
    
outerLoop:
    mov esi, ecx                ; esi -> minimum
    mov edi, ecx                ; edi -> idzie po nie posortowanej czÍúci
    inc edi

    mov ebx, [array + esi * 4]  ; ebx -> aktualne minimum

findMinimum:
    cmp edi, arraySize
    jae swapElements           ; Jak mamy koniec tablicy to swap

    ; Sprawdü czy aktualny element jest mniejszy od aktualnego minimum
    mov eax, [array + edi * 4]
    cmp eax, ebx
    jge incrementEdi

    ; Nowe minimum, update starego i indeksu
    mov ebx, eax
    mov esi, edi

incrementEdi:
    inc edi
    jmp findMinimum

swapElements:
    cmp esi, ecx                ; Czy nowe minimum
    je incrementEcx

    ; Swap
    mov eax, [array + esi * 4]  ; Znalezione minimum
    xchg eax, [array + ecx * 4] ; zamienia minimum z pierwszym nieposortowanym
    mov [array + esi * 4], eax

incrementEcx:
    inc ecx
    cmp ecx, arraySize
    jb outerLoop

selectionSortDone:
    ret
SelectionSort ENDP

; Procedure to display the array
DisplayArray PROC
    mov ecx, arraySize
    lea esi, array
displayLoop:
    mov eax, [esi]
    call WriteInt
    call Crlf
    add esi, 4
    loop displayLoop
    ret
DisplayArray ENDP

; Procedure to read the array
ReadArray PROC
    mov ecx, arraySize
    lea esi, array
readLoop:
    call ReadInt
    mov [esi], eax
    add esi, 4
    loop readLoop
    ret
ReadArray ENDP

END main