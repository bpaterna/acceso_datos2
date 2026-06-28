# 5. Funciones


<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                             |
|----------|------------|-----------------------------------------|
| 1.0      | 27-06-2026 | Adaptación de los materiales a markdown |



## 1. Introducción

Las **funciones** (conocidas como *métodos* en lenguajes como Java) son bloques de código independientes diseñados para realizar una tarea específica. Te sirven para organizar tu código, evitar la duplicación de instrucciones (principio *DRY - Don't Repeat Yourself*) y hacer que tus programas sean mucho más legibles y fáciles de mantener.



## 2. Definición y sintaxis básica

Para declarar una función en Kotlin, debes utilizar la palabra reservada **`fun`**, seguida del nombre de la función (en camello o *camelCase*), paréntesis para los parámetros (si los tiene) y llaves `{}` que delimitan las instrucciones de la función.

**Parámetro vs. Argumento**

Es común confundir estos términos al principio. Esta tabla te ayudará a diferenciarlos claramente:

| Concepto | ¿Qué es? | Ejemplo botánico |
| :--- | :--- | :--- |
| **Parámetro** | La variable que se define en la firma o declaración de la función. Actúa como un contenedor. | `fun regar(planta: String) { ... }`<br>*(aquí `planta` es el parámetro)* |
| **Argumento** | El valor real que le envías a la función cuando la llamas. | `regar("Girasol")`<br>*(aquí `"Girasol"` es el argumento)* |

**Ejemplo 1: Función simple sin parámetros ni retorno**

Ideal para realizar acciones fijas, como imprimir una cabecera de informe.

```kotlin
// Declaración de la función
fun mostrarCabeceraInvernadero() {
    println("=====================================")
    println("   SISTEMA DE CONTROL BOTÁNICO v2   ")
    println("=====================================")
}

fun main() {
    // Llamada a la función
    mostrarCabeceraInvernadero()
}
```



## 3. Funciones con parámetros

Las funciones suelen necesitar información del exterior para realizar su trabajo. Puedes pasarle una o varias variables indicando siempre su nombre y su tipo de dato.

**Ejemplo 2: Función con un parámetro (sin retorno)**

```kotlin
fun registrarRegado(especie: String) {
    println("Acción: Se ha suministrado agua a la planta: $especie")
}

fun main() {
    // Al llamar a la función, le enviamos un argumento de tipo String
    registrarRegado("Orquídea")
    registrarRegado("Helecho")
}
```



## 4. Funciones que devuelven un valor

Si necesitas que una función realice un cálculo y te devuelva el resultado para poder guardarlo en una variable u operar con él, debes indicar el **tipo de retorno** al final de la cabecera (usando dos puntos `:`) y emplear la palabra clave **`return`** dentro de la función.

**Ejemplo 3: Calcular el consumo anual de agua**

```kotlin
// Indicamos con ': Double' al final que esta función devolverá un número decimal
fun calcularConsumoAnual(litrosSemanales: Double): Double {
    val semanasAño = 52.0
    val totalConsumo = litrosSemanales * semanasAño
    return totalConsumo
}

fun main() {
    val consumoMacetas = calcularConsumoAnual(2.5)
    println("Consumo anual estimado para el lote de macetas: $consumoMacetas litros.")
}
```



## 5. Funciones simplificadas (Expresión única)

Si una función tiene una sola línea de código que simplemente devuelve un valor, Kotlin te permite prescindir de las llaves `{}` y de la palabra `return`. En su lugar, puedes estructurarla utilizando el operador de asignación **`=`**.

**Ejemplo 4: Formatear nombre familiar de una especie**

```kotlin
// Función simplificada de expresión única (single-expression function)
fun obtenerNombreFamiliar(nombreComun: String) = "Familia de las $nombreComun"

fun main() {
    val texto = obtenerNombreFamiliar("Rosáceas")
    println(texto) // Salida: Familia de las Rosáceas
}
```



## 6. Parámetros con valores por defecto

En Kotlin, puedes asignar valores predeterminados a los parámetros en la firma de la función. Si al llamar a la función decides no enviar ese argumento, el programa utilizará automáticamente el valor por defecto que hayas configurado. Esto evita tener que escribir múltiples funciones sobrecargadas.

**Ejemplo 5: Registro de especies con ubicación predeterminada**

```kotlin
// Por defecto, asumimos que las plantas se ubican en el 'Invernadero A'
fun registrarEspecie(nombre: String, ubicacion: String = "Invernadero A") {
    println("Especie: $nombre | Ubicación asignada: $ubicacion")
}

fun main() {
    // Llamada usando el valor por defecto de la ubicación
    registrarEspecie("Cactus de Navidad") // Salida: Ubicación asignada: Invernadero A
    
    // Llamada especificando una ubicación diferente
    registrarEspecie("Monstera deliciosa", "Sector Sombra") // Salida: Ubicación asignada: Sector Sombra
}
```



## 7. Argumentos nombrados (*Named Arguments*)

Cuando llamas a una función que tiene muchos parámetros (algunos de ellos con valores por defecto), puede ser confuso recordar el orden exacto de las variables. Kotlin te permite solucionar esto indicando explícitamente el nombre del parámetro al que le estás asignando el valor. Además, te permite cambiar el orden de los argumentos en la llamada.

**Ejemplo 6: Programación de tareas de abono**

```kotlin
fun programarTratamiento(especie: String, mililitros: Double, repetirSemanas: Int = 1) {
    println("Tratamiento programado para '$especie':")
    println("- Cantidad: $mililitros ml")
    println("- Duración: $repetirSemanas semana(s)")
}

fun main() {
    // 1. Llamada tradicional (respetando el orden estricto de los parámetros)
    programarTratamiento("Bonsái Ficus", 15.0, 4)
    
    // 2. Llamada utilizando argumentos nombrados en desorden (facilita la legibilidad)
    programarTratamiento(
        mililitros = 25.5, 
        especie = "Hiedra inglesa", 
        repetirSemanas = 2
    )
    
    // 3. Llamada combinando argumentos nombrados y valores por defecto
    programarTratamiento("Sansevieria", mililitros = 10.0) // Utiliza el valor por defecto: 1 semana
}
```



---

<span class="mi_h3">Autoría</span>

Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)

---