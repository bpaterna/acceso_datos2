# 3. Entrada y salida estándar


<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                             |
|----------|------------|-----------------------------------------|
| 1.0      | 27-06-2026 | Adaptación de los materiales a markdown |



## 1. Introducción

En programación, la **entrada y salida estándar** representa el canal de comunicación directo entre tu programa y la persona que lo está utilizando. A través de la consola, podrás mostrar informes sobre el estado del invernadero (salida) o solicitar que se introduzcan nuevos datos de catalogación de plantas (entrada).



## 2. Salida de datos por consola

Para enviar información y texto hacia la pantalla, Kotlin pone a tu disposición dos funciones muy similares pero con un comportamiento diferente respecto al salto de línea (`print` y `println`).

| Función | Descripción | Ejemplo de uso | Resultado en consola |
| :--- | :--- | :--- | :--- |
| **`print()`** | Imprime el texto tal cual, **sin añadir un salto de línea** al final. El siguiente texto se mostrará pegado a continuación. | `print("Rosa ")`<br>`print("roja")` | `Rosa roja` |
| **`println()`** | Imprime el texto y **añade automáticamente un salto de línea** al final. El siguiente texto comenzará en la línea inferior. | `println("Rosa")`<br>`println("roja")` | `Rosa`<br>`roja` |

**Ejemplo práctico en consola:**

Imagina que quieres mostrar una pequeña ficha de registro de tareas de jardinería combinando ambas funciones:

```kotlin
fun main() {
    print("Estado del riego: ")
    print("COMPLETADO") // Se muestra en la misma línea
    
    println() // Esto genera un salto de línea vacío
    
    println("--- Datos de la parcela ---")
    println("Especie: Lavanda")
    println("Ubicación: Sector Sur")
}
```



## 3. Entrada de datos por teclado

Para que tus programas no sean estáticos y puedan reaccionar a lo que decida el usuario, necesitas capturar lo que se escribe desde el teclado. Para ello se utiliza la función **`readLine()`**.

**Características clave de `readLine()`:**

1. **Siempre devuelve texto:** Aunque el usuario introduzca un número (como un `5`), la función lo capturará como un texto (`"5"`). Su tipo de retorno es **`String?`** (una cadena de texto que puede ser nula).
2. **Control del botón "Enter":** Si el usuario simplemente pulsa la tecla *Enter* sin escribir absolutamente nada, `readLine()` no devolverá un valor nulo (`null`), sino una **cadena vacía** (`""`).
3. **Conversión necesaria:** Si necesitas operar matemáticamente con el dato que introduce el usuario (por ejemplo, para realizar cálculos de crecimiento), tendrás que transformar ese texto al tipo de dato numérico correspondiente (`toInt()`, `toDouble()`, etc.).

---

## 4. Comprobaciones de seguridad

Dado que intentar convertir un texto vacío o con letras (como `"mucho"`) a un número entero provocará que tu programa falle y se detenga con un error, **siempre debes realizar una comprobación previa de seguridad**.

La forma correcta y segura de comprobar que la entrada de teclado no es nula ni está vacía antes de realizar cualquier conversión numérica es utilizando la función de validación `.isNotBlank()`.

**Ejemplo práctico: Cálculo de crecimiento estimado**
Observa este programa que solicita la altura actual de un girasol y calcula cuánto medirá la próxima semana suponiendo un crecimiento estimado de 15 centímetros:

```kotlin
fun main() {
    print("Introduce la altura actual del girasol (en cm): ")
    
    // Capturamos lo que escribe el usuario por consola
    val entrada = readLine()
    
    // Validamos de forma segura que la entrada no sea nula ni esté vacía o con espacios
    if (entrada != null && entrada.isNotBlank()) {
        
        // Convertimos el String de forma segura a un número entero
        val alturaActual = entrada.toInt()
        val alturaEstimada = alturaActual + 15
        
        println("La próxima semana tu girasol medirá aproximadamente $alturaEstimada cm.")
        
    } else {
        // Mensaje de aviso si el usuario pulsó Enter sin escribir o dejó espacios en blanco
        println("Error: Altura introducida no válida. Asegúrate de escribir un número entero.")
    }
}
```

**¿Qué ocurre bajo la superficie al ejecutar este programa?**

* **Caso 1 (Entrada válida):**
  ```text
  Introduce la altura actual del girasol (en cm): 45
  La próxima semana tu girasol medirá aproximadamente 60 cm.
  ```
* **Caso 2 (Entrada vacía o incorrecta - Pulsar enter directamente):**
  ```text
  Introduce la altura actual del girasol (en cm): 
  Error: Altura introducida no válida. Asegúrate de escribir un número entero.
  ```




---

<span class="mi_h3">Autoría</span>

Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)

---