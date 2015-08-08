@@Universidad del Valle de Guatemala
@@Taller de Assembler
@@
@@Laboratorio 2
@@rutinas.s
@@
@@Jorge Manrique
@@13600
@@
@@Christopher Ajú
@@13171

.text
.align 2

.global NotaFinal
	
NotaFinal:
	
	@@ Recibe los datos de r0 a r3
	@@ r0 = nota comprobacion
	@@ r1 = nota corto
	@@ r2 = nota actividad
	@@ r3 = nota reflexion
	
	@@ suma de todas las notas y almacenar resultado final en r0
	add r0, r0, r1
	add r0, r0, r2
	add r0, r0, r3 @@resultado final en r0
	
	mov pc,lr

.global Rendimiento

Rendimiento:
	
	@@ recibe la nota final en r0 y hace determina si su rendimiento fue:
	@@ muy malo (menor a 40)
	@@ malo (entre 40 y 60)
	@@ regular (entre 61 y 75)
	@@ bueno (entre 76 y 90)
	@@ excelente (mayor o igual a 90)
	
	cmp r0, #40
	blt muymalo
	cmp r0, #40
	cmpgt r0, #60
	blt malo
	cmp r0, #61
	cmpgt r0, #75
	blt regular
	cmp r0, #76
	cmpgt r0, #90
	blt bueno
	cmp r0, #90
	bgt excelente
	
	@@ r0 = 0 si la nota es muy mala
	@@ r0 = 1 si la nota es mala
	@@ r0 = 2 si la nota es regular
	@@ r0 = 3 si la nota es buena
	@@ r0 = 4 si la nota es excelente
	
muymalo:		
	mov r0, #0
	mov pc,lr
	
malo:
	mov r0, #1
	mov pc,lr
	
regular:
	mov r0, #2
	mov pc,lr
	
bueno:
	mov r0, #3
	mov pc,lr
	
excelente:
	mov r0, #4
	mov pc,lr
	
	
.global convToStr
	@@convierte a una cadena un numero
	@@recibe en r0 el valor a convertir
	@@recibe en r1 la etiqueta donde sera guardada la cadena
	@@no retorna nada, el guardado se hace en la subrutina
convToStr:
	push {lr}
	push {r1}		@@guarda etiqueta para guardar datos
					@@r0 valor entero
	MOV R1, #100
	MOV R2, #10
	BL dividir
	@@r4=centenas, r5=decenas, r6=unidades
	ADD R4, R4, #48		@@convertir centenas a ascii
	ADD R5, R5, #48		@@convertir decenas a ascii
	ADD R6, R6, #48		@@convertir unidades a ascii
	POP {R1} 			@@recuperar etiqueta
	@@almacenaje
	STRB R4, [R1]		@@centenas
	STRB R5, [R1, #1]	@@decenas
	STRB R6, [R1, #2]	@@unidades
	pop {pc}

.global dividir
dividir:
	push {lr}
	MOV R4, #0		@@centenas
	MOV R5, #0		@@decenas
	MOV R6, R0		@@unidades, residuo
	
	div_centenas:
		CMP r6, r1
		BLT div_decenas	@@subdivision para decenas
		SUB R6, R6, R1
		ADD R4, R4, #1 @@se agrega la cantidad de centenas que hay
		B div_centenas
	div_decenas:
		CMP R6, R2
		BLT div_fin @@subdivision para unidades
		SUB R6, R6, R2
		ADD R5, R5, #1 @@se agrega la cantidad de decenas que hay
		B div_decenas
	
	div_fin:
		@@r4= centenas
		@@r5= decenas
		@@r6= unidades
		POP {pc}
		

.global convToInt
	@@Convierte a un valor entero una cadena
	@@recibe en r0 la direccion de cadena y lo retorna en r0
convToInt:
	push {lr}
	/*tomar datos*/
	LDRB R1, [r0] 
	LDRB R2, [R0,#1] 
	/*convertir*/
	SUB R1, R1, #48 /*decenas*/
	SUB R2, R2, #48 /*unidades*/
	/*retornar*/
	MOV R3, #10
	MUL R4, R1, R3 /*se vuelve decena*/
	ADD R0, R4, R2 /*se suma la unidad*/
	POP {pc}
	




