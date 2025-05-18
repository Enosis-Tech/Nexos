# Propósito del documeto

En este documento se redacta la ABI del sistema operativo
y la que el compilador NCC usa al generar código máquina

# Sección 1.0.0: Proposito de los registros dentro del sistema

En esta sección se redacta el própósito de cada registri en el sistema
y el como el sistema operativo interpreta a cada uno.

La sección se divide en tres partes iniciando con *propósito*, *Registros volátiles*, *Registros no volátiles* y *Registros de manejo especial*

## Propósito

El registro *Acumulador (A)* se usa para indicar al sistema el *syscall* que se va a usar y para devolver valores de 8 bits.

Por otra parte los registro *H, L, D, E e IX* se usan para pasar parámetros.

*HL* es tratado por el sistema como el registro acumulador de 16 bits para operaciones de 16 bits y para devolver parámetros de 16 bits.

El registro *DE* es usado como segundo parámetro en el sistema y es tratado como un registro volátil sin propósito especial.

En caso de usar los registros *H, L, D y E* como registros separados, en ese caso serían los parámetros de 8 bits para subrutinas que les basten esos valores

En el caso del registro *IX* es tratado como parámetro para punteros a arreglos. Su valor es conservado en caso de no ser usado por la subrutina. Se especifíca su fue o no usado de forma interna para saber el rendimiento de una rutina.

El registro *IY* es usado como *framepointer* del marco de la pila de una subrutina. Su valor siempre es conservado por el sistema.

Los registros *SP* es manejado por el usuario, pero el sistema operativo hace que su valor inicial sea *FFFF* dentro de memoria. Un mal manejo de este registro puede causar corrupción del sistema, pero se asume que el usuario sabe como manejar una estructura pila.

El registro *PC* es manejado por el flujo del programa, pero al cargar una aplicación su valor es *0x4000* así que la dirección donde debe iniciar el programa es esa.

## Registros volátiles

Estos son registros cuyo valor no debe ser conservado entre llamadas a subrutinas

----------------------------------------------------------------------------------------------
| Tipo de función | 1er registro | 2do registro | 3er registro | 4to registro | 5to registro |
|-----------------|--------------|--------------|--------------|--------------|--------------|
|  8 bits         | A            | H            | L            | D            | E            |
| 16 bits         | HL           | DE           | —            | —            | —            |
----------------------------------------------------------------------------------------------

## Registros no volátiles

Estos son registros cuyo valor debe ser conservado entre llamadas a subrutinas

-------------------------------------------------
| Tipo de función | 1er registro | 2do registro |
|-----------------|--------------|--------------|
|  8 bits         | B            | C            |
| 16 bits         | SP           | IY           |
-------------------------------------------------

## Registrso con un manejo especial

Estos registros se caracterízan por tener un manejo especial en cuanto a su conservación y no conservación.

El registro *IX* el cual se conserva su valor si no es usado como parámetro de la subrutina. Este registro es un punto medio entre voátil y nó volátil. Si una subrutina no lo usa como parámetro, internamente debe conservarlo y restaurar su valor al finalizar; en caso de que no lo usa como parámetro y tampoco internamente, no es necesario conservar su valor de forma explícita ya que se asume que su valor sigue siendo el mismo finalizando la subrutina.

El registro *I* no debe cambiado su valor por seguridad, aunque el usuario puede hacerlo y si está aquí es por que el sistema restaura su valor siempre al hacer un cambio de contexto. Así que no es necesario guardar o conservar su valor, pero sí asegurarse de no cambiarlo para que no surja inestabilidad.

El registro *R* no es usado por el sistema y su manejo depende del usuario. El sistema solo se encarga de conservar su valor en cambios de contexto.

Los **bancos** son utilizados por el sistema al hacer un cambio de contexto, pero pueden ser usados libremente por el usuario. Solo tenga en cuenta que el sistema no conserva su valor y es responsabilidad del usuario conservarlo. La mejor forma de conservar su valor es solo usandolos en rutinas que pueden aprovecharlos y que no se usan seguido o muy pocas veces ya que el hardware generará una interrupción una vez se acabe el tiempo de su proceso.

# Convención de pasos de parámetros (Calling Convention)

En está sección se trata la convención de llamadas y el como funciona iniciando desde los más básico con ejemplos en funciones simples. Está convención es la que usa el sistema operativo y NCC.

La ABI usa 4 registros de 8 bits o 2 de 16 bits para pasar parámetros. En caso de que una función use más parámetros el resto de valores se pasan en la pila.

Esta tabla define el orden en el que los parámetros se pasan a una función según su tamaño.  
Si no hay suficientes registros, se usan parámetros en la pila.

------------------------------------------------------------------------------------------------------------------
| Tipo de función | 1er parámetro  | 2do parámetro  | 3er parámetro  | 4to parámetro  | Parámetros adicionales   |
|-----------------|----------------|----------------|----------------|----------------|--------------------------|
|  8 bits         | L              | H              | E              | D              | Pila                     |
| 16 bits         | HL             | DE             | —              | —              | Pila                     |
------------------------------------------------------------------------------------------------------------------

También se puede usar el registro acumulador como parámetro, pero no se recomienda a menos que sea para indicar algo que requeier de comparaciones inmediatas. En caso de utilizarlo para otra cosa se saldría de la ABI y es su respondabilidad manejarlo.

En caso de que debamos devolver un dato de más de 16 bits se debe hacer mediante un puntero a una dirección de memoria.