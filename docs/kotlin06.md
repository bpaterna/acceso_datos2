# 6. Estructuras de datos


<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                             |
|----------|------------|-----------------------------------------|
| 1.0      | 27-06-2026 | Adaptación de los materiales a markdown |



## 1. Introducción

Las estructuras de datos te permiten organizar, almacenar y manipular grupos de información de manera eficiente. Imagina que en lugar de declarar una variable para el pH de cada maceta de tu invernadero, puedes agruparlos todos en una sola estructura para analizarlos o modificarlos masivamente en segundos.



## 2. Array (Vector / Arreglo)

Un **Array** es una colección ordenada de elementos con un **tamaño fijo** que no puede cambiar una vez creado. Todos los elementos almacenados deben ser del mismo tipo de dato y se accede a ellos a través de un índice numérico (que empieza siempre en `0`).


<span class="mi_h3">2.1. Arrays especializados para tipos primitivos</span>

Para optimizar el rendimiento y la memoria, Kotlin dispone de clases de arrays específicas para tipos numéricos o booleanos:

* `IntArray`, `ByteArray`, `ShortArray`, `LongArray`
* `FloatArray`, `DoubleArray`
* `BooleanArray`, `CharArray`


<span class="mi_h3">2.2. Tres formas de crear un array</span>

```kotlin
fun main() {
    // 1. Crear un array vacío indicando el tamaño fijo (lleno de ceros por defecto)
    val phParcelas = DoubleArray(4) 
    phParcelas[0] = 6.5
    phParcelas[1] = 7.2
    // ...
    
    // 2. Asignar los valores directamente al crearlo
    val phZonas = doubleArrayOf(5.5, 6.8, 7.1)
    
    // 3. Utilizar arrayOf para tipos genéricos (como Strings, que no tienen clase optimizada)
    val plantasSocio = arrayOf("Ajo", "Zanahoria", "Lechuga")
}
```



<span class="mi_h3">2.3. Operaciones comunes con Arrays</span>

```kotlin
fun main() {
    val floresInvernadero = arrayOf("Rosa", "Tulipán", "Lirio", "Girasol")
    
    // Acceder a un elemento por su índice
    println("La primera flor del catálogo es: ${floresInvernadero[0]}") // Rosa
    
    // Cambiar el valor de un elemento
    floresInvernadero[2] = "Lirio blanco"
    
    // Consultar el tamaño total del array
    println("Total flores registradas: ${floresInvernadero.size}") // 4
    
    // RECORRER UN ARRAY (2 formas de hacerlo con un bucle 'for')
    
    println("\n--- Método 1: Recorrido directo por elementos ---")
    for (flor in floresInvernadero) {
        println("- Especie: $flor")
    }
    
    println("\n--- Método 2: Recorrido por índices ---")
    for (i in 0..floresInvernadero.size - 1) {
        println("Posición $i en el estante: ${floresInvernadero[i]}")
    }
}
```



## 3. List (Lista)

A diferencia de los Arrays, las **listas** son colecciones ordenadas cuyo tamaño puede ser dinámico. Además, permiten almacenar elementos duplicados. En Kotlin existen dos variantes fundamentales de listas:

<span class="mi_h3">3.1. Lista Inmutable (`List`)</span>
Una vez creada con la función `listOf()`, **no se puede modificar** (no puedes añadir, eliminar ni cambiar sus elementos).

```kotlin
val tareasFijas = listOf("Regar", "Abonar", "Revisar plagas")
// tareasFijas.add("Podar") // ¡Error de compilación! Es inmutable.
```

<span class="mi_h3">3.2. Lista Mutable (`MutableList`)</span>
Creada con `mutableListOf()`, te permite gestionar libremente un inventario dinámico de elementos.

**Ejemplo práctico: Inventario de maceteros**

```kotlin
fun main() {
    // Declaración de una lista de macetas mutable
    val maceteros = mutableListOf("Maceta Barro", "Maceta Plástico")
    
    // Añadir elementos al final de la lista
    maceteros.add("Maceta Cerámica") // Ahora contiene 3 elementos
    
    // Añadir un elemento en una posición o índice específico
    maceteros.add(1, "Maceta Biodegradable") // Se introduce entre la de barro y la de plástico
    
    // Modificar un elemento mediante su índice
    maceteros[2] = "Maceta Fibra de Coco" // Reemplaza "Maceta Plástico"
    
    // Eliminar por valor exacto
    maceteros.remove("Maceta Barro")
    
    // Eliminar por índice
    maceteros.removeAt(0) // Elimina el elemento en la posición 0 ("Maceta Biodegradable")
    
    println("Inventario final de maceteros: $maceteros")
    
    // Limpiar toda la lista por completo
    maceteros.clear()
}
```



## 4. Set (Conjunto)

Un **Set** es una colección de elementos únicos **donde no se permiten duplicados** y donde el orden de los elementos no está garantizado. Se utiliza principalmente cuando quieres asegurarte de que una lista de datos no contenga elementos repetidos.

**Ejemplo práctico: Control de plagas activas en parcelas**

```kotlin
fun main() {
    // 1. Set Inmutable: "Pulgón" solo se registrará una vez
    val plagasDetectadas = setOf("Pulgón", "Araña roja", "Pulgón")
    println("Plagas bajo control: $plagasDetectadas") // Salida: [Pulgón, Araña roja]
    
    // 2. Set Mutable: Añadir nutrientes garantizando que sean únicos
    val abonoMezcla = mutableSetOf("Nitrógeno", "Fósforo")
    
    abonoMezcla.add("Potasio")
    abonoMezcla.add("Nitrógeno") // Se ignora silenciosamente porque ya existe
    
    println("Composición química del abono: $abonoMezcla") // [Nitrógeno, Fósforo, Potasio]
    
    // Verificar si un elemento existe en el conjunto de forma ultra rápida (operador 'in')
    if ("Potasio" in abonoMezcla) {
        println("La mezcla contiene Potasio, es apta para la floración.")
    }
    
    // Eliminar un elemento
    abonoMezcla.remove("Nitrógeno")
}
```



## 5. Map (Diccionario o Mapa)

Un **Map** es una colección de **pares clave $\rightarrow$ valor**. Cada clave es única (no puede repetirse), pero los valores sí pueden duplicarse. Es la estructura ideal cuando necesitas asociar un identificador (como el nombre de una planta o un código de lote) con un valor o dato asociado.

**Ejemplo práctico: Registro de humedad ideal y pH por lote**

```kotlin
fun main() {
    // 1. Map Inmutable: Asociar planta con su humedad ideal (%)
    val humedadIdeal = mapOf(
        "Helecho" to 80,
        "Cactus" to 20,
        "Orquídea" to 60
    )
    
    // Acceder al valor asociado a una clave
    println("La humedad ideal para el Helecho es del ${humedadIdeal["Helecho"]}%")
    
    // 2. Map Mutable: Registro de pH de la tierra por lote de cultivo
    val registroPhLotes = mutableMapOf<String, Double>()
    
    // Añadir o actualizar claves con sus valores correspondientes
    registroPhLotes["Lote A-Girasol"] = 6.8
    registroPhLotes["Lote B-Hortensia"] = 5.5
    registroPhLotes["Lote A-Girasol"] = 6.5 // Sobrescribe el valor anterior
    
    // Acceder a los datos de forma segura
    println("pH Hortensias: ${registroPhLotes["Lote B-Hortensia"]}")
    
    // Eliminar un registro
    registroPhLotes.remove("Lote B-Hortensia")
}
```



**Comparativa: Array, List, Set y Map**

Esta tabla resumen te servirá para repasar las diferencias estructurales de cada una de las colecciones que has aprendido:

| Estructura | ¿Mantiene el orden? | ¿Permite duplicados? | ¿Claves únicas? | ¿Es modificable su tamaño? |
| :--- | :---: | :---: | :---: | :--- |
| **Array** | Sí | Sí | No | **No** (tamaño fijo al crearse) |
| **List** | Sí | Sí | No | **Sí** (siempre que sea `MutableList`) |
| **Set** | No | **No** | Sí (los elementos actúan como claves únicas) | **Sí** (siempre que sea `MutableSet`) |
| **Map** | No | En los valores (no en las claves) | **Sí** (las claves deben ser únicas) | **Sí** (siempre que sea `MutableMap`) |


---

<span class="mi_h3">Autoría</span>

Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)

---