# 4. Estructuras de control de flujo


<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                             |
|----------|------------|-----------------------------------------|
| 1.0      | 27-06-2026 | Adaptación de los materiales a markdown |



## 1. Introducción

Las estructuras de control te permiten romper la ejecución secuencial (de arriba a abajo) de tus programas. Con ellas, podrás tomar decisiones lógicas (condicionales) o repetir ciertas acciones varias veces (bucles).


## 2. Operadores relacionales y lógicos

Para establecer condiciones o realizar repeticiones, necesitas comparar valores. Estos son los operadores relacionales que utilizarás en Kotlin:

| Operador | Significado | Ejemplo | Resultado |
| :---: | :--- | :---: | :---: |
| **`==`** | Igual a | `5 == 5` | `true` |
| **`!=`** | Distinto de | `5 != 3` | `true` |
| **`>`** | Mayor que | `10 > 7` | `true` |
| **`<`** | Menor que | `3 < 8` | `true` |
| **`>=`** | Mayor o igual que | `6 >= 6` | `true` |
| **`<=`** | Menor o igual que | `4 <= 9` | `true` |

Puedes combinar varias condiciones utilizando **operadores lógicos**:

* **`&&` (AND):** Devuelve `true` solo si **ambas** condiciones son verdaderas.
* **`||` (OR):** Devuelve `true` si al menos **una** de las condiciones es verdadera.
* **`!` (NOT):** Invierte el valor lógico (lo que es `true` pasa a ser `false`).

## 3. Estructuras Condicionales

Los condicionales te permiten ejecutar diferentes bloques de código en función de si se cumplen o no determinadas condiciones.

<span class="mi_h3">3.1. Estructura `if` / `if-else`</span>

**Ejemplo 1: Condicional simple (`if`)**

Se ejecuta un bloque de código únicamente si la condición resulta verdadera.

```kotlin
val humedadSuelo = 35

if (humedadSuelo < 40) {
    println("Alerta: Humedad baja. Activando electroválvula de riego.")
}
```

**Ejemplo 2: Condicional doble (`if-else`)**

Permite tomar un camino alternativo si la condición no se cumple.

```kotlin
val phTierra = 7.5

if (phTierra < 7.0) {
    println("El sustrato es ácido.")
} else {
    // Se ejecuta si el pH es 7.0 o superior
    println("El sustrato es neutro o alcalino.")
}
```

**Ejemplo 3: Condicionales anidados**

Puedes introducir condicionales dentro de otros condicionales para refinar la lógica de control.

```kotlin
val temperatura = 24
val tieneSombra = true
val requiereSolDirecto = false

if (temperatura >= 20 && tieneSombra) {
    println("Condiciones ambientales base correctas.")
    
    if (!requiereSolDirecto) {
        println("La planta está protegida adecuadamente en la sombra.")
    } else {
        println("Aviso: Esta especie requiere sol directo. Mover maceta.")
    }
} else {
    println("Temperatura fuera de rango o falta de protección de sombra.")
}
```

**Ejemplo 4: `if` como expresión**

En Kotlin, el `if` puede devolver un valor directamente. Esto te permite ahorrar líneas de código al asignar valores.

```kotlin
val litrosAgua = 1.5
// El resultado del if se guarda directamente en la variable 'estadoRiego'
val estadoRiego = if (litrosAgua >= 2.0) "Óptimo" else "Insuficiente"

println("El riego de hoy ha sido: $estadoRiego")
```


<span class="mi_h3">3.2. La estructura `when`</span>

La estructura `when` sustituye al clásico `switch` de otros lenguajes. Es mucho más potente y legible cuando tienes múltiples caminos lógicos.

**Ejemplo 5: `when` como selector directo**

Evalúa una variable y toma una acción según su valor coincidente.

```kotlin
val tipoPlanta = "Cactus"

val frecuenciaRiego = when (tipoPlanta) {
    "Helecho" -> "Frecuente (cada 2 días)"
    "Cactus" -> "Muy poco frecuente (cada 15 días)"
    "Orquídea" -> "Moderado (cada 7 días)"
    else -> "Frecuencia de riego estándar (cada 5 días)"
}

println("Riego recomendado para $tipoPlanta: $frecuenciaRiego")
```

**Ejemplo 6: `when` con condiciones complejas**

Si no le pasas ningún parámetro entre paréntesis a `when`, puedes evaluar condiciones libres en cada rama (similar a una cadena de `if-else if`).

```kotlin
val humedadSuelo = 45

val estadoHumedad = when {
    humedadSuelo >= 80 -> "Suelo encharcado (peligro para las raíces)"
    humedadSuelo in 40..79 -> "Humedad óptima"
    humedadSuelo in 15..39 -> "Humedad moderada (se recomienda regar pronto)"
    else -> "Suelo completamente seco (regar inmediatamente)"
}

println("Informe del sensor: $estadoHumedad")
```



## 4. Estructuras Repetitivas (Bucles)

Los bucles te permiten repetir la ejecución de un bloque de código. En Kotlin dispones de cuatro estructuras: `while`, `do-while`, `for` y `repeat`.


<span class="mi_h3">4.1. Bucle `while`</span>

Repite las instrucciones **mientras** la condición sea verdadera. Evalúa la condición **antes** de entrar al bucle; si es falsa desde el principio, el bloque nunca llega a ejecutarse.

```kotlin
var diasSinLluvia = 1

while (diasSinLluvia <= 5) {
    println("Día $diasSinLluvia sin lluvia: La reserva de agua disminuye.")
    diasSinLluvia++ // Incrementamos para evitar un bucle infinito
}
```


<span class="mi_h3">4.2. Bucle `do-while`</span>

Es similar al anterior, pero con una diferencia clave: **evalúa la condición al final**. Esto garantiza que el bloque de código se ejecutará **al menos una vez**, sin importar si la condición es falsa desde el inicio.

```kotlin
var litrosEnRegadera = 0

do {
    litrosEnRegadera++
    println("Llenando regadera... Volumen actual: $litrosEnRegadera litros")
} while (litrosEnRegadera < 5)
```


<span class="mi_h3">4.3. Bucle `for`</span>

Se utiliza para recorrer colecciones, listas o un **rango numérico definido**. Lo emplearás cuando sepas de antemano cuántas veces necesitas repetir una acción.

```kotlin
// Recorre los números del 1 al 5, ambos incluidos
for (dia in 1..5) {
    println("Día de germinación $dia: La semilla absorbe humedad de la tierra.")
}
```



<span class="mi_h3">4.4. Bucle `repeat`</span>

Es una función exclusiva de Kotlin para simplificar las repeticiones. Te permite ejecutar un bloque de instrucciones un número exacto de veces, sin necesidad de definir rangos ni variables contadoras adicionales.

```kotlin
// Simulación de una pulverización de agua automatizada
repeat(3) {
    println("Pulverizando agua sobre las hojas.")
}
```



**Comparativa de estructuras repetitivas**

Para ayudarte a decidir qué bucle utilizar en el desarrollo de tus aplicaciones, puedes consultar esta tabla resumen:

| Estructura | ¿Cuándo usarla? | ¿Evalúa primero? | ¿Se ejecuta al menos una vez? |
| :--- | :--- | :---: | :---: |
| **`while`** | Cuando no sabes el número exacto de repeticiones y estas dependen de una condición externa que debe cumplirse desde el principio. | Sí | No |
| **`do-while`** | Cuando quieres garantizar que la acción se realice al menos una vez antes de verificar si debe repetirse. | No | Sí |
| **`for`** | Cuando conoces de antemano el número exacto de veces que deseas iterar o necesitas recorrer una lista/rango. | Sí | Depende de si el rango o lista está vacío |
| **`repeat`** | Para tareas sencillas donde solo necesitas repetir un bloque de código un número fijo de veces sin interactuar con un índice. | Sí (valida si N > 0) | No (si N es 0 o menor) |



---

<span class="mi_h3">Autoría</span>

Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)

---