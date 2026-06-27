# 2. Variables y Tipos de Datos


<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                             |
|----------|------------|-----------------------------------------|
| 1.0      | 27-06-2026 | Adaptación de los materiales a markdown |



## 1. ¿Qué es una variable?

Una **variable** es un espacio en la memoria de tu ordenador destinado a guardar un dato específico (un número, un fragmento de texto, el estado de un sensor, etc.). En Kotlin, a diferencia de otros lenguajes tradicionales, dispones de dos formas principales para declarar variables según necesites que su valor cambie o permanezca constante.


<span class="mi_h3">1.1. `val` – Inmutable (No se puede modificar)</span>

Se comporta como una constante. Una vez que le asignas un valor por primera vez, **no puedes volver a cambiarlo** en todo el programa. Es la opción recomendada por defecto para escribir código más seguro y evitar errores accidentales. Por ejemplo, en botánica, el nombre científico de una planta no suele cambiar nunca.

```kotlin
fun main() {
    // Declaración de un valor inmutable
    val nombreCientifico = "Helianthus annuus" 
    
    // nombreCientifico = "Rosa canina" // ¡Error de compilación! No se puede reasignar.

    // Uso de plantillas de texto (String templates) con el símbolo $
    println("El nombre científico del Girasol es $nombreCientifico")
}
```

<span class="mi_h3">1.2. `var` – Mutable (Se puede modificar)</span>

Es una variable normal. Puedes declarar su valor inicial y **modificarlo más adelante** tantas veces como necesites a lo largo de la ejecución de tu código. Por ejemplo, en botánica, la altura de una flor es un dato que cambia constantemente a medida que crece la planta.

```kotlin
fun main() {
    // Declaración de una variable mutable
    var alturaTalloCm = 15.0 
    
    // La planta crece 2.5 centímetros tras el riego
    alturaTalloCm += 2.5 
    
    println("La altura actual de la planta es de $alturaTalloCm cm") // Salida: 17.5 cm
}
```



## 2. Tipos de datos en Kotlin

En Kotlin **no es estrictamente obligatorio declarar el tipo de una variable**, ya que el compilador es capaz de deducirlo automáticamente según el valor que le asignes (a esto se le llama *inferencia de tipos*). No obstante, puedes especificarlo de forma explícita escribiendo `:` seguido del tipo de dato. A continuación tienes los tipos de datos más comunes que necesitarás durante este curso:

| Tipo | Descripción | Ejemplo de declaración |
| :--- | :--- | :--- |
| **Byte** | Entero muy pequeño (8 bits). Rango de -128 a 127. | `val macetasPorFila: Byte = 12` |
| **Short** | Entero corto (16 bits). Rango de -32.768 a 32.767. | `val semillasEnBolsa: Short = 350` |
| **Int** | Entero estándar (32 bits). El más común para contar. | `val totalHojas: Int = 12000` |
| **Long** | Entero largo (64 bits). Se debe añadir una `L` al final. | `val celulasEstimadas: Long = 9500000000L` |
| **Float** | Decimal de precisión simple (32 bits). Añade una `f` al final. | `val litrosRiego: Float = 2.5f` |
| **Double** | Decimal de precisión doble (64 bits). Tipo por defecto. | `val phTierra: Double = 6.5` |
| **Char** | Un único carácter individual, encerrado en comillas simples. | `val zonaInvernadero: Char = 'A'` |
| **String** | Texto o cadena de caracteres (comillas dobles). | `val familiaBotanica: String = "Cactaceae"` |
| **Boolean**| Valor lógico: verdadero (`true`) o falso (`false`). | `val esPlantaExterior: Boolean = false` |

> **Nota sobre Strings:** En Kotlin puedes acceder a caracteres individuales de un texto como si fuera un array utilizando corchetes.
> ```kotlin
> val especie = "Orquídea"
> val primeraLetra = especie[0] // Obtiene el carácter 'O'
> ```



## 3. Operadores aritméticos

Kotlin utiliza los operadores matemáticos estándar para realizar cálculos sobre tus variables numéricas.

| Operador | Operación | Ejemplo | Resultado |
| :---: | :--- | :---: | :---: |
| **`+`** | Suma | `5 + 3` | `8` |
| **`-`** | Resta | `10 - 4` | `6` |
| **`*`** | Multiplicación | `6 * 2` | `12` |
| **`/`** | División (entera o real) | `9 / 3` | `3` |
| **`%`** | Módulo (resto de la división) | `10 % 3` | `1` |



**Comportamiento de la división**

* **División entre enteros:** Si divides dos números enteros, Kotlin descartará los decimales y te devolverá otro número entero.
  ```kotlin
  val mlPorMaceta = 7 / 2 // El resultado será 3, no 3.5
  ```
* **División con decimales:** Para obtener un resultado con decimales, al menos uno de los valores que utilices debe ser de tipo `Double` o `Float`.
  ```kotlin
  val mlPorMacetaExacto = 7.0 / 2 // El resultado será 3.5
  ```



## 4. Control de Nulos (*Null Safety*)

Uno de los principales problemas en lenguajes como Java es el famoso error `NullPointerException` (cuando intentas acceder a algo que apunta a la nada, es decir, a un valor `null`). Kotlin está diseñado específicamente para evitar este problema obligándote a controlar los nulos de forma explícita desde el código.


<span class="mi_h3">4.1. Variables no anulables (Por defecto)</span>

En Kotlin, por defecto, **las variables no pueden contener valores nulos**. Si intentas asignar `null` a una variable estándar, tu programa no llegará a compilar.

```kotlin
var nombreFlor: String = "Rosa"
// nombreFlor = null // ¡Error de compilación! No se permite asignar null.
```

<span class="mi_h3">4.2. Variables anulables (Símbolo `?`)</span>

Si necesitas que una propiedad pueda estar vacía o no definida (por ejemplo, si una planta aún no ha florecido y su color de flor es desconocido), debes decírselo al compilador añadiendo el signo de interrogación `?` al final del tipo de dato.

```kotlin
var colorFloracion: String? = "Amarillo"
colorFloracion = null // ¡Correcto! Ahora sí se permite almacenar null.
```



<span class="mi_h3">4.3. Operadores para trabajar con valores nulos</span>

Cuando trabajas con variables que pueden ser nulas, Kotlin te obliga a proteger tu código antes de interactuar con ellas. Dispones de tres operadores principales para gestionarlo de manera limpia:

**Llamada segura (`?.`)** Ejecuta la acción o método **solo si la variable no es nula**. Si la variable es `null`, la operación se ignora y devuelve `null` sin colgar la aplicación.

```kotlin
fun main() {
    var variedadHibrido: String? = null
    // Intenta calcular la longitud del texto. Al ser null, no rompe el programa y devuelve null.
    println(variedadHibrido?.length) // Salida: null

    variedadHibrido = "F1-Golden"
    println(variedadHibrido?.length) // Salida: 9
}
```

**Operador Elvis (`?:`)** Te permite definir un **valor de respaldo o por defecto** en caso de que la variable que estés evaluando resulte ser nula.

```kotlin
fun main() {
    var tipoSustrato: String? = null
    // Si tipoSustrato es null, se asigna el valor "Universal"
    val sustratoFinal = tipoSustrato ?: "Universal"
    println("Sustrato a utilizar: $sustratoFinal") // Salida: Sustrato a utilizar: Universal
}
```

**Afirmación no nula (`!!`)** Fuerza al compilador a tratar la variable como si estuviera 100% seguro de que no es nula. **Ten mucho cuidado con este operador**: si la variable resulta ser nula en tiempo de ejecución, tu aplicación fallará inmediatamente lanzando una excepción.

```kotlin
fun main() {
    var codigoPlanta: String? = null
    
    // Solo debes usar '!!' si estás completamente seguro de que no es null
    // println(codigoPlanta!!.uppercase()) // ¡Lanzará NullPointerException y detendrá el programa!
}
```



<span class="mi_h3">4.4. Estructura alternativa usando condicionales (`if`)</span>

También puedes controlar los valores nulos utilizando una estructura condicional clásica `if-else`. Esto le indica de manera lógica a Kotlin que estás verificando la seguridad de la variable antes de utilizarla:

```kotlin
fun main() {
    val insecticidaRecomendado: String? = "Aceite de Neem"

    if (insecticidaRecomendado != null) {
        // Dentro de este bloque, Kotlin sabe que la variable NO es nula y te deja usarla sin operadores adicionales.
        println("Aplicando tratamiento: ${insecticidaRecomendado.uppercase()}")
    } else {
        println("Tratamiento ecológico por defecto: Agua jabonosa.")
    }
}
```



---

<span class="mi_h3">Autoría</span>

Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)

---