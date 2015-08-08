@@Universidad del valle de Guatemala
@@Taller de assembler
@@Archivo: lab2.s
@@Autores: Christopher Aju 13171, Jorge Manrique 13600

@@*********************************************
@@		Descripcion de rutina
@@Main para laboratorio 2
@@Pide notas de laboratorio 2:
@@	Comprobacion <= 10
@@	Corto <= 20
@@	Actividad <= 60
@@	Reflexion <= 10
@@El rango de entrada es de 2 digitos
@@Utiliza las subrutinas para hacer el calculo
@@*********************************************

.global _start

_start:
@@*****************
@@lectura de datos
@@*****************
/*comprobacion*/
	/*mensaje*/
	MOV R7, #4					@@llamado a write
	MOV R0, #1					@@llamado a monitor
	MOV R2, #36					@@longitud de cadena
	LDR R1, =askComprobacion	@@mensaje
	SWI 0
	/*lectura*/
	MOV R7, #3					@@llamado a read
	MOV R0, #0					@@llado a teclado
	MOV R2, #3					@@longitud de cadena
	LDR R1, =nota1				@@variable
	SWI 0
	
/*corto*/
	/*mensaje*/
	MOV R7, #4					@@llamado a write
	MOV R0, #1					@@llamado a monitor
	MOV R2, #27					@@longitud de cadena
	LDR R1,	=askCorto			@@mensaje
	SWI 0
	/*lectura*/
	MOV R7, #3					@@llamado a read
	MOV R0, #0					@@llado a teclado
	MOV R2, #3					@@longitud de cadena
	LDR R1, =nota2				@@variable
	SWI 0
	
/*actividad*/
	/*mensaje*/
	MOV R7, #4					@@llamado a write
	MOV R0, #1					@@llamado a monitor
	MOV R2, #33					@@longitud de cadena
	LDR R1, =askActividad		@@mensaje
	SWI 0
	/*lectura*/
	MOV R7, #3					@@llamado a read
	MOV R0, #0					@@llado a teclado
	MOV R2, #3					@@longitud de cadena
	LDR R1, =nota3				@@variable
	SWI 0
	
/*reflexion*/
	/*mensaje*/
	MOV R7, #4					@@llamado a write
	MOV R0, #1					@@llamado a monitor
	MOV R2, #34					@@longitud de cadena
	LDR R1, =askReflexion		@@mensaje
	SWI 0
	/*lectura*/
	MOV R7, #3					@@llamado a read
	MOV R0, #0					@@llado a teclado
	MOV R2, #3					@@longitud de cadena
	LDR R1, =nota4				@@variable
	SWI 0

@@******************************************
@@Conversion de string a int de los datos
@@******************************************
/*nota1*/
	LDR R0, =nota1 @@se carga una cadena
	BL convToInt
	LDR R1, =valor1
	STR R0, [R1]
/*nota2*/
	LDR R0, =nota2
	BL convToInt
	LDR R1, =valor2
	STR R0, [R1]
/*nota3*/
	LDR R0, =nota3
	BL convToInt
	LDR R1, =valor3
	STR R0, [R1]
/*nota4*/
	LDR R0, =nota4
	BL convToInt
	LDR R1, =valor4
	STR R0, [R1]

@@***********************************
@@Calculo de nota y rendimiento
@@***********************************
/*calculo de nota final*/
	LDR R0, =valor1
	LDR R0, [R0]
	LDR R1, =valor2
	LDR R1, [R1]
	LDR R2, =valor3
	LDR R2, [R2]
	LDR R3, =valor4
	LDR R3, [R3]
	BL NotaFinal	
	
	/*almacenaje en formato numero*/
	LDR R1, =valor5 
	STR R0, [R1] /*INT*/
	
	/*almacenaje en formato string*/
	/*r0=valor a convertir, r1=etiqueta de guardado*/
	LDR R0, =valor5
	LDR R0, [R0] 	@@carga de valor
	LDR R1, =final  @@carga de etiqueta
	BL convToStr /*STRING*/
	@@el almacenaje se hace en la subrutina
	
/*Calculo de rendimiento*/
	LDR R0, =valor5
	LDR R0, [R0]
	BL Rendimiento
	/*r0 contiene el valor*/
	LDR R1, =flag
	STR R0, [R1]
	
	/*comparaciones*/
	LDR R0, =flag
	LDR R0, [R0]
	CMP r0, #0
	BEQ print_muyMalo
	CMP R0, #1
	BEQ	print_malo
	CMP R0, #2
	BEQ print_regular
	CMP R0, #3
	BEQ print_bueno
	CMP R0, #4
	BEQ print_excelente

/*CASES*/
print_muyMalo:
	@@tipo
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #62				@@longitud de cadena
	LDR R1, =msgMuyMalo		@@mensaje
	SWI 0
	@@nota
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #3				@@longitud de cadena
	LDR R1, =final	@@mensaje
	SWI 0
	@@enter
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #1				@@longitud de cadena
	LDR R1, =enter			@@mensaje
	SWI 0
	B end
	
print_malo:
	@@tipo
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #58				@@longitud de cadena
	LDR R1, =msgMalo		@@mensaje
	SWI 0
	@@nota
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #3				@@longitud de cadena
	LDR R1, =final	@@mensaje
	SWI 0
	@@enter
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #1				@@longitud de cadena
	LDR R1, =enter			@@mensaje
	SWI 0
	B end
	
print_regular:
	@@tipo
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #61				@@longitud de cadena
	LDR R1, =msgRegular		@@mensaje
	SWI 0
	@@nota
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #3				@@longitud de cadena
	LDR R1, =final	@@mensaje
	SWI 0
	@@enter
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #1				@@longitud de cadena
	LDR R1, =enter			@@mensaje
	SWI 0
	B end
	
print_bueno:
	@@tipo
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #59				@@longitud de cadena
	LDR R1, =msgBueno		@@mensaje
	SWI 0
	@@nota
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #3				@@longitud de cadena
	LDR R1, =final	@@mensaje
	SWI 0
	@@enter
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #1				@@longitud de cadena
	LDR R1, =enter			@@mensaje
	SWI 0
	B end
	
print_excelente:
	@@tipo
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #63				@@longitud de cadena
	LDR R1, =msgExcelente	@@mensaje
	SWI 0
	@@nota
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #3				@@longitud de cadena
	LDR R1, =final	@@mensaje
	SWI 0
	@@enter
	MOV R7, #4				@@llamado a write
	MOV R0, #1				@@llamado a monitor
	MOV R2, #1				@@longitud de cadena
	LDR R1, =enter			@@mensaje
	SWI 0
	

@@******************
@@	Fin de programa
@@******************
end:
	MOV R7, #1
	SWI 0
	
@@****************************************
.data
/*mensajes*/
askComprobacion:
	.asciz "Ingrese la nota de la comprobacion:\n"
askCorto:
	.asciz "Ingrese la nota del corto:\n"
askActividad:
	.asciz "Ingrese la nota de la actividad:\n"
askReflexion:
	.asciz "Ingrese la nota de la reflexion:\n"
	
msgMuyMalo:
	.asciz "El rendimiento del estudiante fue muy malo, con nota final de "
msgMalo:
	.asciz "El rendimiento del estudiante fue malo, con nota final de "
msgRegular:
	.asciz "El rendimiento del estudiante fue regular, con nota final de "
msgBueno:
	.asciz "El rendimiento del estudiante fue bueno, con nota final de "
msgExcelente:
	.asciz "El rendimiento del estudiante fue excelente, con nota final de "
enter:
	.asciz "\n"
	
/*variables*/
nota1:
	.asciz "  "
nota2:
	.asciz "  "
nota3:
	.asciz "  "
nota4:
	.asciz "  "
final:
	.asciz "   "

valor1:
	.word 0
valor2:
	.word 0
valor3:
	.word 0
valor4:
	.word 0
valor5:
	.word 0
flag:
	.word 0
