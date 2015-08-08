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
	
