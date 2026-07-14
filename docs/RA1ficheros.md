# RA1. Acceso a ficheros

<span class="mi_h3">Revisiones</span>

|Revisión | Fecha      | Descripción|
|---------|------------|-------------|
|1.0 | 13-07-2026 | Adaptación de los materiales a markdown|


## 1. Introducción

Un **fichero o archivo** es una unidad de almacenamiento de datos en un sistema informático. Es un conjunto de información (secuencia de bytes) organizada y almacenada en un dispositivo de almacenamiento (disco duro, memoria USB o un servidor en la nube). Los datos guardados en ficheros persisten más allá de la ejecución de la aplicación que los trata. La utilización de ficheros es una alternativa sencilla y eficiente a las bases de datos.

<span class="mi_h3">Características de un fichero</span>

* **Nombre:** Cada fichero tiene un nombre único dentro de su directorio.
* **Extensión:** Indica su tipo (`.txt` para texto, `.jpg` para imágenes, etc.).
* **Ubicación:** Directorios (carpetas) dentro del sistema de ficheros.
* **Contenido:** Texto, imágenes, vídeos, código fuente, bases de datos, etc.
* **Permisos de acceso:** Se pueden configurar para permitir o restringir la lectura, escritura o ejecución a determinados usuarios o programas.

<span class="mi_h3">Tipos de ficheros</span>

* **De texto:** Formato legible por humanos (`.txt`, `.csv`, `.json`, `.xml`). Por ejemplo: un catálogo de especies en formato CSV o JSON.
* **Binarios:** Formato no legible directamente (`.exe`, `.jpg`, `.mp3`, `.dat`). Por ejemplo: fotografías de hojas y flores en alta resolución.
* **De código fuente:** Contienen instrucciones escritas en lenguajes de programación (`.java`, `.kt`, `.py`).
* **De configuración:** Almacenan parámetros de configuración de programas (`.ini`, `.conf`, `.properties`, `.json`).
* **De bases de datos:** Se utilizan para almacenar grandes volúmenes de datos estructurados (`.db`, `.sql`).
* **Historial:** De eventos o errores en un sistema (`.log`).

<span class="mi_h3">API para manejo de ficheros</span>

`java.nio` (New IO) es una API disponible desde la versión 7 de Java que permite mejorar el rendimiento, así como simplificar el manejo de muchas operaciones. Funciona a través de interfaces y clases para que la máquina virtual Java tenga acceso a ficheros, atributos de ficheros y sistemas de ficheros. En los siguientes apartados veremos cómo trabajar con ella.



<span class="mi_h3">Formas de acceso</span>

El acceso a ficheros es una tarea fundamental en la programación, ya que permite leer y escribir datos persistentes. Según sus características y necesidades, existen dos formas principales de acceder a un fichero:

**Acceso secuencial**

* Los datos se procesan en orden, desde el principio hasta el final del fichero.
* Es el más común y sencillo.
* Se usa cuando se desea leer todo el contenido o recorrer registro por registro. Por ejemplo: lectura de un catálogo de plantas línea por línea, o de un fichero binario de taxonomía registro a registro.

![Imagen 1](img/ficheros1.jpg){ width="300" }

**Acceso aleatorio**

* Permite saltar a una posición concreta del fichero sin necesidad de leer lo anterior.
* Es útil cuando los registros tienen un tamaño fijo y se necesita eficiencia (por ejemplo, ir directamente a los datos de la planta número 100 de un fichero indexado).
* Requiere técnicas más avanzadas como el uso de `FileChannel`, `SeekableByteChannel` o `RandomAccessFile`.


![Imagen 2](img/ficheros2.jpg){ width="300" }


## 2. Gestión de ficheros y directorios

La gestión de ficheros y directorios se realiza a través de `Path` y `Files`.

**Path**

Representa una **ruta** en el sistema de ficheros (ej. `/home/botanico/rosa.png` o `C:\herbario\docs\clasificacion.txt`). Un objeto `Path` es una dirección y no significa que el fichero o directorio exista realmente en el disco.

| Método | Descripción |
| :--- | :--- |
| `Path.of(String)` | Crea un objeto `Path` a partir de un String de ruta (Java 11+). Por debajo llama a `Paths.get()`, que es el método original de la clase `Paths` (Java 7+). |
| `toString()` | Devuelve la ruta como un String (se llama por defecto desde `println`). |
| `toAbsolutePath()` | Devuelve la ruta absoluta del `Path`. |
| `fileName()` | Devuelve el nombre del fichero o directorio final de la ruta (por ejemplo, el nombre de la planta o el documento). |

<span class="mis_ejemplos">Ejemplo 1</span>

El siguiente código demuestra cómo crear y mostrar distintos tipos de rutas (no intenta acceder a los ficheros o directorios, por tanto pueden existir o no):

```kotlin
import java.nio.file.Path

fun main() {
    rutas()
}

fun rutas() {
    // Path relativo al directorio del proyecto (carpeta de muestras)
    val rutaRelativa: Path = Path.of("muestras", "orquidea.jpg")

    // Path absoluto en Windows
    val rutaAbsolutaWin: Path = Path.of("C:", "Herbario", "Especies", "Helechos")

    // Path absoluto en Linux/macOS
    val rutaAbsolutaNix: Path = Path.of("/home/botanico/jardin/flora_mediterranea")

    println("Ruta relativa: " + rutaRelativa) // Muestra la ruta relativa
    println("Ruta absoluta: " + rutaRelativa.toAbsolutePath()) // Ruta completa
    println("Ruta absoluta Windows: " + rutaAbsolutaWin)
    println("Ruta absoluta Linux: " + rutaAbsolutaNix)
}
```

!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que la salida por consola es:

    ```text
    Ruta relativa: muestras\orquidea.jpg
    Ruta absoluta: D:\kot\ficheros\muestras\orquidea.jpg
    Ruta absoluta Windows: C:\Herbario\Especies\Helechos
    Ruta absoluta Linux: \home\botanico\jardin\flora_mediterranea
    ```



**Files**

Es una clase de utilidad con las acciones (borrar, copiar, mover, leer, etc.) que podemos realizar sobre las rutas (`Path`). Algunos de sus principales métodos son:

| Método | Descripción |
| :--- | :--- |
| `exists()`, `isDirectory()`, `isRegularFile()`, `isReadable()` | Verificar la existencia y accesibilidad de un elemento botánico o carpeta. |
| `list()`, `walk()` | Listar el contenido de un directorio. |
| `readAttributes()` | Obtener atributos (tamaño del archivo de imagen, fecha de registro de la muestra, etc.). |
| `createDirectory()` | Crear un directorio. Solo crea el directorio final y espera que todo el "camino" hasta él ya exista. |
| `createDirectories()` | Crea un directorio y también los directorios padre si no existen (ej. crear `/plantas/terrestres/helechos/`). Es la forma más segura. |
| `createFile()` | Crear un nuevo fichero. |
| `delete()` | Borrar un fichero o directorio (lanza una excepción si el borrado falla). Lanza `NoSuchFileException` si el fichero o directorio no existe. Es más seguro usar `deleteIfExists()`. |
| `move(origen, destino)` | Mover o renombrar un fichero o directorio (por ejemplo, reclasificar una especie). |
| `copy(origen, destino)` | Copiar un fichero o directorio. Si el destino ya existe, se puede sobrescribir utilizando `copy(Path, Path, REPLACE_EXISTING)`. Si se copia un directorio, no se copiará su contenido (el nuevo directorio estará vacío). |



<span class="mis_ejemplos">Ejemplo 2</span>

Partimos de una carpeta llamada `muestras` donde guardamos fotos, descripciones de texto y registros de audio de la naturaleza sin ningún orden. Este programa organizará automáticamente los archivos en subcarpetas según su formato (extensión) para que el herbario quede perfectamente estructurado.

> Puedes descargar la carpeta del ejemplo comprimida desde el siguiente enlace: [muestras.zip](recursos/muestras.zip){:muestras.zip}). La carpeta debe estar ubicada en la raíz del proyecto de IntelliJ (al mismo nivel que la carpeta `src` y que el archivo `build.gradle.kts`).


```kotlin

import java.nio.file.Path
import java.nio.file.Files
import java.nio.file.StandardCopyOption
import kotlin.io.path.extension // Extensión de Kotlin para obtener la extensión

fun main() {
    organizar()
}

fun organizar(){
    // 1. Ruta de la carpeta de muestras botánicas a organizar
    val carpeta = Path.of("muestras")

    println("--- Iniciando la clasificación botánica en la carpeta: " + carpeta + " ---")
    try {
        // 2. Recorrer la carpeta desordenada y utilizar .use para asegurar el cierre de recursos
        Files.list(carpeta).use { streamDePaths ->
            streamDePaths.forEach { pathFichero ->
                // 3. Solo nos interesan los ficheros de muestras, ignoramos subcarpetas
                if (Files.isRegularFile(pathFichero)) {

                    // 4. Obtener la extensión del fichero (ej: "jpg", "txt", "mp3")
                    val extension = pathFichero.extension.lowercase()
                    if (extension.isBlank()) {
                        println("-> Ignorando archivo sin tipo: " + pathFichero.fileName)
                        return@forEach // Salta a la siguiente muestra
                    }

                    // 5. Crear la ruta de destino dentro de la carpeta correspondiente
                    val carpetaDestino = carpeta.resolve(extension)

                    // 6. Crear el directorio de destino de la categoría si no existe
                    if (Files.notExists(carpetaDestino)) {
                        println("-> Creando nueva sección para archivos: ." + extension)
                        Files.createDirectories(carpetaDestino)
                    }

                    // 7. Mover la muestra botánica a su nueva ubicación clasificada
                    val pathDestino = carpetaDestino.resolve(pathFichero.fileName)
                    Files.move(pathFichero, pathDestino, StandardCopyOption.REPLACE_EXISTING)
                    println("-> Clasificando " + pathFichero.fileName + " en la carpeta [." + extension + "]")
                }
            }
        }
        println("\n--- ¡Clasificación del herbario completada con éxito! ---")
    } catch (e: Exception) {
        println("\n--- Ocurrió un error durante la clasificación de muestras ---")
        e.printStackTrace()
    }
}
```


!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que la salida por consola es:

    ```text
    --- Iniciando la clasificación botánica en la carpeta: muestras ---
    -> Creando nueva sección para archivos: .txt
    -> Clasificando flor.txt en la carpeta [.txt]
    -> Clasificando arbusto.txt en la carpeta [.txt]
    -> Creando nueva sección para archivos: .jpg
    -> Clasificando 20191106_071048.jpg en la carpeta [.jpg]
    -> Clasificando 20191101_071830.jpg en la carpeta [.jpg]
    -> Creando nueva sección para archivos: .mp3
    -> Clasificando pad-harmonious-and-soothing-voice-like-background.mp3 en la carpeta [.mp3]
    -> Clasificando dark-cinematic-atmosphere.mp3 en la carpeta [.mp3]
    -> Creando nueva sección para archivos: .mp4
    -> Clasificando 293968_small.mp4 en la carpeta [.mp4]
    -> Creando nueva sección para archivos: .pdf
    -> Clasificando lorem-ipsum-1.pdf en la carpeta [.pdf]
    -> Clasificando lorem-ipsum-2.pdf en la carpeta [.pdf]
    
    --- ¡Clasificación del herbario completada con éxito! ---
    ```


<span class="mi_h3">Técnicas para recorrer un directorio</span>

Como hemos visto en el clasificador anterior, recorrer directorios para "mirar" o gestionar su contenido es clave. Aquí analizamos los diferentes métodos para hacerlo:

**1. `Files.list(path)`**

Lista únicamente el contenido del directorio especificado **sin acceder a las subcarpetas**. Es ideal para operaciones superficiales (como nuestra clasificación anterior, donde solo queríamos trabajar a primer nivel).

* **Ventajas:**
    * Rápido y eficiente al no ser recursivo.
    * Control preciso, operando solo en el primer nivel del directorio.
    * Devuelve un `Stream` de Java que permite usar operadores funcionales (`filter`, `map`, etc.) de forma segura con `.use`.
* **Inconvenientes:**
    * No explora subdirectorios.
    * Para recorrer un árbol completo, se necesita implementar la recursividad manualmente.

**2. `Files.walk(path)`**
Recorre un directorio y todo su contenido **recursivamente**. Entra en cada subcarpeta y en sus subcarpetas de manera sucesiva. Es extremadamente útil para búsquedas globales en el herbario (ej. buscar fotos de flores en cualquier rincón del proyecto, borrar reportes temporales o contar ficheros de registros).

* **Ventajas:**
    * Recorre árboles de directorios completos (recursivo) de forma muy sencilla.
    * Extremadamente potente para búsquedas profundas o para aplicar operaciones en cascada.
    * Devuelve un `Stream`, permitiendo un filtrado muy expresivo.
* **Inconvenientes:**
    * Puede ser lento y consumir más memoria en estructuras gigantescas con miles de subcarpetas y ficheros.
    * Es una herramienta excesiva ("overkill") si solo necesitas leer el nivel superior.

**3. `Files.newDirectoryStream(path)`**
Es similar a `Files.list()`, pues lista solo el contenido inmediato. La diferencia es que no devuelve un `Stream` de Java 8, sino un `DirectoryStream`, una versión más antigua optimizada para bucles tradicionales `for`.

* **Ventajas:**
    * Utiliza un bucle for-each tradicional, que puede resultar más familiar a nivel sintáctico.
* **Inconvenientes:**
    * **¡PELIGRO!** Requiere cerrar el recurso manualmente (`.close()`). Si se olvida, provoca fugas de recursos (*resource leaks*).
    * Es menos expresivo que los Streams, ya que no se pueden encadenar operadores funcionales fácilmente.
    * Considerado obsoleto en código Kotlin idiomático, que prefiere `Files.list().use { ... }`.


<span class="mis_ejemplos">Ejemplo 3:</span>

Despues de clasificar nuestros archivos, queremos crear un listado para ver como ha quedado la estructura de nuestra carpeta `muestras`. Necesitamos listar cada una de las subcarpetas de clasificación y ver qué muestras hay dentro de cada una de ellas de forma jerárquica.

```kotlin
import java.nio.file.Path
import java.nio.file.Files

fun main() {
    listado()
}

fun listado(){
    val carpetaPrincipal = Path.of("muestras")

    println("--- Estructura final del Herbario Digital con Files.walk() ---")
    try {
        Files.walk(carpetaPrincipal).use { stream ->
            // Ordenar el stream para una visualización ordenada por categorías
            stream.sorted().forEach { path ->
                // Calcular profundidad para la indentación
                // Restamos el número de componentes de la ruta base para que la raíz no tenga sangrado
                val profundidad = path.nameCount - carpetaPrincipal.nameCount
                val indentacion = "\t".repeat(profundidad)

                // Determinamos si es una sección (categoría/directorio) o un registro (fichero)
                val prefijo = if (Files.isDirectory(path)) "[CATEGORÍA]" else "[MUESTRA]"

                // No imprimimos la propia carpeta raíz, solo su contenido clasificado
                if (profundidad > 0) {
                    println("$indentacion$prefijo ${path.fileName}")
                }
            }
        }
    } catch (e: Exception) {
        println("\n--- Ocurrió un error durante la generación del informe botánico ---")
        e.printStackTrace()
    }
}
```

!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que la salida por consola es:

    ```text
    --- Estructura final del Herbario Digital con Files.walk() ---
        [CATEGORÍA] jpg
            [MUESTRA] 20191101_071830.jpg
            [MUESTRA] 20191106_071048.jpg
        [CATEGORÍA] mp3
            [MUESTRA] dark-cinematic-atmosphere.mp3
            [MUESTRA] pad-harmonious-and-soothing-voice-like-background.mp3
        [CATEGORÍA] mp4
            [MUESTRA] 293968_small.mp4
        [CATEGORÍA] pdf
            [MUESTRA] lorem-ipsum-1.pdf
            [MUESTRA] lorem-ipsum-2.pdf
        [CATEGORÍA] txt
            [MUESTRA] arbusto.txt
            [MUESTRA] flor.txt
    ```



## 3. Ficheros de texto

Los ficheros de texto son legibles directamente por humanos y son una buena opción para guardar información después de cerrar el programa. A continuación se muestran algunas clases y métodos para leer y escribir información en ellos:

| Método | Descripción |
| :--- | :--- |
| `Files.readAllLines(path)` | Devuelve un `List<String>`. Se utiliza para leer todas las líneas de un fichero. |
| `Files.exists(path)` | Verifica la existencia de un fichero o directorio. |
| `split()`, `trim()`, `toIntOrNull()` | Métodos habituales de String para procesar y limpiar el texto leído. |
| `Files.write(path, lines)` | Escribe una lista de líneas (`List<String>`) en un fichero. |
| `StandardOpenOption.READ` | Abre un fichero en modo lectura. |
| `StandardOpenOption.WRITE` | Abre un fichero en modo escritura. |
| `StandardOpenOption.APPEND` | Agrega contenido al final del fichero sin borrar lo anterior. |
| `StandardOpenOption.CREATE` | Si el fichero no existe, lo crea automáticamente. |
| `StandardOpenOption.TRUNCATE_EXISTING` | Si el fichero ya existe, borra su contenido antes de escribir. |
| `Files.newBufferedReader(Path)` <br> `Files.newBufferedWriter(Path)` | Métodos más eficientes para el manejo de ficheros grandes mediante búferes de memoria. |
| `Files.readString(Path)` <br> `Files.writeString(Path, String)` | Permite realizar la lectura o escritura completa del contenido del fichero como un único bloque de texto (disponible desde Java 11+). |

Dentro de los ficheros de texto existen **ficheros de texto plano** (sin ningún tipo de estructura interna) como los TXT y **ficheros de texto estructurado** (en los que la información sigue una organización) como pueden ser CSV, JSON o XML.



<span class="mis_ejemplos">Ejemplo 4: Escritura y lectura de ficheros de texto plano</span>

El siguiente ejemplo muestra como leer y escribir información en un ficheros de texto plano `.txt`.

```kotlin
import java.nio.file.Files
import java.nio.charset.StandardCharsets

fun main() {
    textoPlano()
}


fun textoPlano(){

    // Ruta del fichero con el que vamos a trabajar
    val ruta = Path.of("muestras2/anotacion.txt")

    Files.createDirectories(ruta.parent) // Crea la carpeta "muestras" si no existe

    // Escritura de una línea writeString (si el archivo no existe lo crea y si existe lo vacía
    val anotacion = "Muestra de Helecho de Java recolectada en el invernadero principal."
    Files.writeString(ruta, anotacion, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING)

    // Lectura rápida de todo el bloque con readString
    val contenidoCompleto = Files.readString(ruta)
    println("--- 1. Contenido del fichero leído con readString: ---")
    println(contenidoCompleto)



    // Escritura de múltiples líneas en un fichero de texto con Files.write
    val lineas = listOf(
        "\n1. Regar cuando las raíces se observen de color grisáceo.",
        "2. Mantener en un espacio con luz indirecta.",
        "3. Evitar corrientes de aire."
    )
    Files.write(ruta, lineas, StandardCharsets.UTF_8, StandardOpenOption.APPEND)

    // Lectura con readAllLines (devuelve una lista línea por línea)
    val lineasLeidas = Files.readAllLines(ruta)
    println("\n--- 2. Contenido leído con readAllLines: ---")
    for (linea in lineasLeidas) {
        println(linea)
    }

    

    // Escribir registros de actividad (Logs) con Buffered Writer
    Files.newBufferedWriter(ruta, StandardOpenOption.APPEND).use { writer ->
        writer.write("[SISTEMA] Invernadero automatizado iniciado...\n")
        writer.write("[SENSOR] Nivel de humedad óptimo detectado (75%).\n")
    }

    // Lectura secuencial eficiente con newBufferedReader
    println("\n--- 3. Contenido leído con newBufferedReader: ---")
    Files.newBufferedReader(ruta).use { reader ->
        reader.lineSequence().forEach { linea ->
            println(linea)
        }
    }
}
```



!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que la salida por consola es:

    ```text
    Fichero de cuidados de orquídeas escrito correctamente.
    
    --- Contenido leído con readAllLines: ---
    1. Regar únicamente cuando las raíces se observen de color grisáceo.
    2. Mantener en un espacio con luz indirecta.
    ¡Evitar por completo las corrientes de aire frío!
    
    --- Contenido leído completo con readString: ---
    1. Regar únicamente cuando las raíces se observen de color grisáceo.
    2. Mantener en un espacio con luz indirecta.
    ¡Evitar por completo las corrientes de aire frío!
    
    --- Contenido leído con newBufferedReader: ---
    1. Regar únicamente cuando las raíces se observen de color grisáceo.
    2. Mantener en un espacio con luz indirecta.
    ¡Evitar por completo las corrientes de aire frío!
    ```



## 4. Ficheros de intercambio de información

Los ficheros de texto en los que la información está estructurada y organizada de una manera predecible permiten que distintos sistemas la lean y entiendan de forma automática. Estos tipos de ficheros se utilizan habitualmente en el desarrollo de software para intercambiar datos entre diferentes aplicaciones. Los formatos más comunes y estandarizados son **CSV, JSON y XML**.

Para poder llevar a cabo este intercambio, es necesario extraer la información del fichero de origen. Este proceso no suele realizarse línea por línea manualmente, sino que el contenido del fichero se lee (parsea) y se traduce a objetos utilizando técnicas de **serialización y deserialización**:

*   **Serialización:** Proceso de convertir un objeto en memoria (por ejemplo, una clase `Planta` o `Especie`) en una representación textual (como una cadena JSON o XML) que se puede almacenar en un fichero o enviar a través de una red.
*   **Deserialización:** El proceso inverso; consiste en leer un fichero estructurado (JSON, XML, etc.) y reconstruir el objeto original en la memoria del programa para poder trabajar con él de forma estructurada.


A continuación se describen los 3 formatos de intercambio de información basados en texto más comunes, con ejemplos de lectura y escritura integrando un proyecto gestionado con **Gradle**.



<span class="mi_h3">4.1. CSV (Comma-Separated Values)</span>

Los ficheros **CSV** son archivos de texto plano con valores separados por un delimitador predeterminado (una coma, punto y coma, tabulador, etc.). Son la herramienta ideal para exportar e importar datos tabulares desde software como Excel, Google Sheets o gestores de bases de datos relacionales.

En Kotlin, se pueden procesar con librerías tradicionales como *OpenCSV* o mediante alternativas más modernas e idiomáticas como **Kotlin-CSV** (la cual utilizaremos).

**Métodos principales de Kotlin-CSV:**

| Método | Descripción | Ejemplo de uso |
| :--- | :--- | :--- |
| `readAll(File)` | Lee todo el fichero CSV y devuelve una lista de listas de cadenas (`List<List<String>>`), donde cada sublista representa una fila. | `val filas = csvReader().readAll(File("plantas.csv"))` |
| `readAllWithHeader(File)` | Lee el fichero CSV utilizando la primera línea como cabecera. Devuelve una lista de mapas (`List<Map<String, String>>`), ideal para acceder a los valores por el nombre de su columna. | `val datos = csvReader().readAllWithHeader(File("plantas.csv"))` |
| `open { readAllAsSequence() }` | Abre el archivo y procesa las filas como una secuencia (`Sequence`). Es el método más eficiente y recomendado para ficheros CSV de gran tamaño, ya que no carga todo el contenido en memoria de golpe. | `csvReader().open("plantas.csv") { readAllAsSequence().forEach { println(it) } }` |
| `writeAll(data, File)` | Escribe una colección completa de filas (lista de listas de cadenas) en el fichero CSV de una sola vez. | `csvWriter().writeAll(listOf(listOf("Aloe Vera", "0.6")), File("salida.csv"))` |
| `writeRow(row, File)` | Escribe una única fila (lista de cadenas) al final del fichero CSV indicado. | `csvWriter().writeRow(listOf("Lavanda", "1.0"), File("salida.csv"))` |
| `writeAllWithHeader(data, File)` | Escribe los datos en el fichero CSV generando automáticamente una fila de cabecera en base a las claves del mapa proporcionado. | `csvWriter().writeAllWithHeader(listOf(mapOf("nombre" to "Girasol", "altura" to "3.0")), File("salida.csv"))` |
| Configuración de delimitador | Permite personalizar el carácter delimitador que separa los campos del CSV (por defecto es la coma `,`, pero se puede cambiar a punto y coma `;`, tabulador, etc.). | `csvReader { delimiter = ';' }` |



<span class="mis_ejemplos">Ejemplo 6: Lectura y escritura de ficheros CSV</span>

Partimos de un fichero llamado `plantas.csv` almacenado dentro de la carpeta `datos` de nuestro proyecto con la siguiente información:

```text
1;Aloe Vera;Aloe barbadensis miller;7;0.6
2;Lavanda;Lavandula angustifolia;3;1.0
3;Helecho de Boston;Nephrolepis exaltata;5;0.9
4;Bambú de la suerte;Dracaena sanderiana;4;1.5
5;Girasol;Helianthus annuus;2;3.0
```

Como puedes observar el carácter delimitador que separa los campos del CSV es un punto y coma (`;`) y los campos representan la estructura de una planta:

*   `id_planta` (Int)
*   `nombre_comun` (String)
*   `nombre_cientifico` (String)
*   `riego` (Int - frecuencia en días)
*   `altura` (Double - altura máxima en metros)


> Puedes descargar el fichero desde este enlace: [plantas.csv](recursos/plantas.csv){:plantas.csv}) y ubicarlo en una carpeta llamada `datos` que deberás crear en la raíz del proyecto de IntelliJ (al mismo nivel que la carpeta `src` y que el archivo `build.gradle.kts`).


Para que nuestra aplicación utilice las funciones de la librería **Kotlin-CSV** hemos de configurar la dependencia correspondiente en el archivo `build.gradle.kts`. Estas son las líneas que hay que añadir:

```kotlin
plugins {
    kotlin("jvm") version "1.9.0"
}

dependencies {
    implementation("com.github.doyaaaaaken:kotlin-csv-jvm:1.9.1")
}
```

Y el código fuente del archivo `Main.kt`es el siguiente:

```kotlin
import java.nio.file.Files
import java.nio.file.Path
import java.io.File
import com.github.doyaaaaaken.kotlincsv.dsl.csvReader
import com.github.doyaaaaaken.kotlincsv.dsl.csvWriter

// Data class que modela la estructura de la planta
data class Planta(
    val idPlanta: Int,
    val nombreComun: String,
    val nombreCientifico: String,
    val riego: Int,
    val altura: Double
)

fun main() {
    val entradaCSV = Path.of("datos/plantas.csv")
    val salidaCSV = Path.of("datos/plantas2.csv")

    // Leer los datos estructurados del CSV y guardarlos en una lista de objetos Planta
    val datos: List<Planta> = leerDatosCSV(entradaCSV)

    // Mostrar por consola la información deserializada
    for (dato in datos) {
        println(" - ID: ${dato.idPlanta}, Nombre común: ${dato.nombreComun}, Científico: ${dato.nombreCientifico}, Riego: cada ${dato.riego} días, Altura: ${dato.altura}m")
    }

    // Guardar una copia procesada en un nuevo fichero CSV
    escribirCSV(salidaCSV, datos)
}

fun leerDatosCSV(ruta: Path): List<Planta> {
    var plantas: List<Planta> = emptyList()

    if (!Files.isReadable(ruta)) {
        println("Error: No se puede leer el fichero en la ruta: $ruta")
    } else {
        val reader = csvReader {
            delimiter = ';'
        }

        // Leemos todas las filas del CSV (devuelve List<List<String>>)
        val filas: List<List<String>> = reader.readAll(ruta.toFile())

        // Convertimos las filas de texto en objetos Planta válidos
        plantas = filas.mapNotNull { columnas ->
            if (columnas.size >= 5) {
                try {
                    val id = columnas[0].toInt()
                    val nombreComun = columnas[1]
                    val nombreCientifico = columnas[2]
                    val riego = columnas[3].toInt()
                    val altura = columnas[4].toDouble()
                    Planta(id, nombreComun, nombreCientifico, riego, altura)
                } catch (e: Exception) {
                    println("Fila inválida ignorada: $columnas -> Error: ${e.message}")
                    null
                }
            } else {
                println("Fila con formato incompleto ignorada: $columnas")
                null
            }
        }
    }
    println("\nInformación leída con éxito de: $ruta")
    return plantas
}

fun escribirCSV(ruta: Path, plantas: List<Planta>) {
    try {
        val fichero: File = ruta.toFile()
        csvWriter {
            delimiter = ';'
        }.writeAll(
            plantas.map { planta ->
                listOf(
                    planta.idPlanta.toString(),
                    planta.nombreComun,
                    planta.nombreCientifico,
                    planta.riego.toString(),
                    planta.altura.toString()
                )
            },
            fichero
        )
        println("\nInformación guardada con éxito en: $fichero")
    } catch (e: Exception) {
        println("Error al escribir el fichero CSV: ${e.message}")
    }
}

```



!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que la salida por consola es:

    ```text
    --- Información leída con éxito de: datos\plantas.csv
    --- Información de la lista de objetos Planta
    - ID: 1, Nombre común: Aloe Vera, Cientéfico: Aloe barbadensis miller, Riego: cada 7 días, Altura: 0.6m
    - ID: 2, Nombre común: Lavanda, Cientéfico: Lavandula angustifolia, Riego: cada 3 días, Altura: 1.0m
    - ID: 3, Nombre común: Helecho de Boston, Cientéfico: Nephrolepis exaltata, Riego: cada 5 días, Altura: 0.9m
    - ID: 4, Nombre común: Bambú de la suerte, Cientéfico: Dracaena sanderiana, Riego: cada 4 días, Altura: 1.5m
    - ID: 5, Nombre común: Girasol, Cientéfico: Helianthus annuus, Riego: cada 2 días, Altura: 3.0m
    --- Información guardada con éxito en: datos\plantas2.csv
    ```


!!! warning "Práctica 1: crea la base de tu proyecto"
    En esta práctica daremos forma a la base de nuestro proyecto. Diseñaremos nuestra estructura de datos principal, crearemos nuestro primer fichero de datos en formato **CSV** y programaremos un menú para que el usuario interactúe con la aplicación por consola. A medida que avancemos iremos añadiendo funciones a este proyecto.

    **Realiza los siguientes pasos:**

    1. **Crea tu proyecto:** Elige la temática de tu proyecto de entre las propuestas por la profesora y busca un nombre. Luego crea el proyecto desde intelliJ para programar con Kotlin y Gradle.
    2. **Diseña tu data class:** Define una clase de datos (*data class*) en Kotlin que represente un elemento individual de tu colección. Debe incluir obligatoriamente un identificador único o ID (`Int`), un nombre descriptivo (`String`) y al menos tres atributos adicionales (uno de ellos debe ser de tipo `Double`).
    3. **Crea tu fichero de datos inicial:** Genera manualmente un archivo con extensión `.csv` con al menos 5 registros que cumplan con la estructura de tu *data class*. Utiliza el punto y coma (`;`) como delimitador y guárdalo dentro de la carpeta `datos` de tu proyecto. Recuerda que debes crear esta carpeta en la raíz del proyecto de IntelliJ (al mismo nivel que la carpeta `src` y que el archivo `build.gradle.kts`).
    4. **Crea un menú de consola interactivo:** Programa un bucle en tu función `main()` que mantenga la aplicación en ejecución y pinte un menú en la terminal con las siguientes opciones:
        * `1. Leer datos desde CSV`
        * `0. Salir`
    5. **Implementa la lectura del CSV:** Cuando el usuario seleccione la opción `1`, llama a una función dedicada (por ejemplo, `leerCSV()`) que compruebe la existencia del fichero, lo lea, deserialice las líneas a objetos de tu *data class* y muestre la lista formateada por consola.

    **Aspectos Técnicos Obligatorios:**

      * **Funcionamiento del menú:** El menú debe repetirse continuamente hasta que el usuario decida salir (opción 0). 
      * **Valida la entrada del usuario:** Asegúrate de que la aplicación sea robusta. Si el usuario introduce letras, espacios en blanco o números fuera del rango del menú, el programa debe mostrar un aviso amigable y volver a pintar las opciones sin detener su ejecución.
      * **Configuración del proyecto:** Añade la librería **Kotlin-CSV** en las dependencias de tu archivo `build.gradle.kts`.
      * **Robustez y manejo de errores:** Debes verificar la accesibilidad y existencia del fichero mediante `Files.isReadable()` antes de iniciar la lectura. El mapeo de datos debe incluir control de excepciones numéricas por si alguna fila del CSV contiene datos corruptos.




<span class="mi_h3">4.2. XML (eXtensible Markup Language)</span>

Los ficheros **XML** son estructurados y extensibles. Se organizan utilizando un sistema de etiquetas jerárquicas anidadas similar al HTML. Permiten la validación estructural mediante esquemas (XSD) y son muy demandados en entornos empresariales consolidados (sistemas *legacy*).

Para interactuar con XML en Kotlin, utilizaremos el ecosistema **Jackson XML** (`XmlMapper`), que automatiza el mapeo directo de clases a etiquetas.

**Métodos clave de `XmlMapper`:**

| Método | Descripción |
| :--- | :--- |
| `readValue(File, Class<T>)` | Parsea un archivo físico XML y lo transforma en un objeto o estructura en memoria. |
| `writeValue(File, Object)` | Guarda la representación XML de un objeto de forma directa en un fichero del sistema. |
| `writeValueAsString(Object)` | Convierte el objeto a formato de texto plano estructurado como XML (String). |
| `registerModule(Module)` | Registra extensiones como `KotlinModule` para dar soporte nativo a tipos específicos de Kotlin. |
| `enable(SerializationFeature.INDENT_OUTPUT)` | Activa el formateado legible (identación/tabulado) para las salidas escritas. |



<span class="mis_ejemplos">Ejemplo 7: Lectura y escritura de ficheros XML</span>

Partimos de un fichero llamado `mis_plantas.xml` en la carpeta `datos/` con el siguiente contenido:

```xml
<plantas>
    <planta>
        <id_planta>1</id_planta>
        <nombre_comun>Aloe Vera</nombre_comun>
        <nombre_cientifico>Aloe barbadensis miller</nombre_cientifico>
        <frecuencia_riego>7</frecuencia_riego>
        <altura_maxima>0.6</altura_maxima>
    </planta>
    <planta>
        <id_planta>2</id_planta>
        <nombre_comun>Lavanda</nombre_comun>
        <nombre_cientifico>Lavandula angustifolia</nombre_cientifico>
        <frecuencia_riego>3</frecuencia_riego>
        <altura_maxima>1.0</altura_maxima>
    </planta>
</plantas>
```

**Dependencias necesarias en `build.gradle.kts`:**

```kotlin
dependencies {
    implementation("com.fasterxml.jackson.dataformat:jackson-dataformat-xml:2.17.0")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin:2.17.0")
}
```

**Código en Kotlin:**

```kotlin
import java.nio.file.Path
import java.io.File
import com.fasterxml.jackson.dataformat.xml.XmlMapper
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty
import com.fasterxml.jackson.module.kotlin.readValue
import com.fasterxml.jackson.module.kotlin.registerKotlinModule

// Clase que modela los nodos individuales <planta>
data class PlantaXML(
    @JacksonXmlProperty(localName = "id_planta")
    val idPlanta: Int,
    @JacksonXmlProperty(localName = "nombre_comun")
    val nombreComun: String,
    @JacksonXmlProperty(localName = "nombre_cientifico")
    val nombreCientifico: String,
    @JacksonXmlProperty(localName = "frecuencia_riego")
    val riego: Int,
    @JacksonXmlProperty(localName = "altura_maxima")
    val altura: Double
)

// Clase contenedora que representará la etiqueta raíz <plantas>
@JacksonXmlRootElement(localName = "plantas")
data class PlantasWrapper(
    @JacksonXmlElementWrapper(useWrapping = false)
    @JacksonXmlProperty(localName = "planta")
    val listaPlantas: List<PlantaXML> = emptyList()
)

fun main() {
    val entradaXML = Path.of("datos/mis_plantas.xml")
    val salidaXML = Path.of("datos/mis_plantas2.xml")

    val datos = leerDatosXML(entradaXML)
    for (planta in datos) {
        println(" - ID: ${planta.idPlanta}, Común: ${planta.nombreComun}, Riego: cada ${planta.riego} días")
    }

    escribirDatosXML(salidaXML, datos)
}

fun leerDatosXML(ruta: Path): List<PlantaXML> {
    val fichero = ruta.toFile()
    val xmlMapper = XmlMapper().registerKotlinModule()
    
    // Leemos el XML directamente sobre la clase contenedora wrapper
    val contenedor: PlantasWrapper = xmlMapper.readValue(fichero)
    return contenedor.listaPlantas
}

fun escribirDatosXML(ruta: Path, plantas: List<PlantaXML>) {
    try {
        val fichero = ruta.toFile()
        val contenedor = PlantasWrapper(plantas)
        val xmlMapper = XmlMapper().registerKotlinModule()

        // Generamos el XML formateado con saltos de línea y tabuladores para que sea legible
        val xmlString = xmlMapper.writerWithDefaultPrettyPrinter().writeValueAsString(contenedor)
        fichero.writeText(xmlString)
        
        println("\nInformación guardada en XML: $fichero")
    } catch (e: Exception) {
        println("Error al guardar XML: ${e.message}")
    }
}
```


!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que la salida por consola es:

    ```text
    FALTA
    ```




!!! warning "Práctica 2: amplía tu proyecto"
    En esta práctica añadiremos un fichero de datos en formato **CSV** y ampliaremos el menú con una opción para leer su contenido.

    1. **Crea tu archivo XML**
       Genera manualmente un archivo con extensión `.xml` con al menos 5 registros que cumplan con la estructura de tu *data class*. 
    
    2. **Amplia el menú con la opción 2 para leer el XML**

    3. **Implementa la lectura del XML:**
       Cuando el usuario seleccione la opción `2`, llama a una función dedicada (por ejemplo, `leerXML()`) que compruebe la existencia del fichero, lo lea, deserialice las líneas a objetos de tu *data class* y muestre la lista formateada por consola.

    **Aspectos Técnicos Obligatorios:**
        
      * **Configuración del proyecto:** Añade las dependencias necesarias en tu archivo `build.gradle.kts`.
      * **Robustez y manejo de errores:** Debes verificar la accesibilidad y existencia del fichero mediante `Files.isReadable()` antes de iniciar la lectura. 




<span class="mi_h3">4.3. JSON (JavaScript Object Notation)</span>

Los ficheros **JSON** son formatos de intercambio ligeros, ágiles y sencillos de leer por humanos. Se estructuran mediante colecciones de pares clave-valor y listas ordenadas. Son la base fundamental para el consumo de APIs REST, configuraciones del sistema y entornos de bases de datos no relacionales como MongoDB.

En Kotlin, se procesan usando la biblioteca oficial **kotlinx.serialization**, que destaca por ser extremadamente rápida, segura en tiempos de compilación e independiente de la plataforma.

**Métodos clave de `kotlinx.serialization`:**

| Método / Ejemplo | Descripción |
| :--- | :--- |
| `Json.encodeToString(objeto)` | Traduce cualquier objeto de memoria a formato de cadena de texto JSON. |
| `Json.decodeFromString<T>(jsonString)` | Deserializa una cadena de texto JSON y la convierte de vuelta en un objeto tipado. |
| `Json { prettyPrint = true }` | Configuración del formateador para generar salidas JSON ordenadas e indentadas. |



<span class="mis_ejemplos">Ejemplo 8: Lectura y escritura de ficheros JSON</span>

Partiremos de un archivo inicial llamado `mis_plantas.json` guardado en la carpeta `datos/`:

```json
[
  {
    "id_planta": 1,
    "nombre_comun": "Aloe Vera",
    "nombre_cientifico": "Aloe barbadensis miller",
    "frecuencia_riego": 7,
    "altura_maxima": 0.6
  },
  {
    "id_planta": 2,
    "nombre_comun": "Lavanda",
    "nombre_cientifico": "Lavandula angustifolia",
    "frecuencia_riego": 3,
    "altura_maxima": 1.0
  }
]
```

**Configuración de plugins y dependencias en `build.gradle.kts`:**

```kotlin
plugins {
    kotlin("jvm") version "1.9.0"
    kotlin("plugin.serialization") version "1.9.0" // Requerido para la autogeneración de serializadores
}

dependencies {
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.6.0")
}
```

**Código en Kotlin:**

```kotlin
import java.nio.file.Files
import java.nio.file.Path
import kotlinx.serialization.*
import kotlinx.serialization.json.*

// Anotamos la data class indicando que es serializable para el compilador de Kotlin
@Serializable
data class PlantaJSON(
    @SerialName("id_planta") val idPlanta: Int,
    @SerialName("nombre_comun") val nombreComun: String,
    @SerialName("nombre_cientifico") val nombreCientifico: String,
    @SerialName("frecuencia_riego") val riego: Int,
    @SerialName("altura_maxima") val altura: Double
)

fun main() {
    val entradaJSON = Path.of("datos/mis_plantas.json")
    val salidaJSON = Path.of("datos/mis_plantas2.json")

    val datos = leerDatosInicialesJSON(entradaJSON)
    for (planta in datos) {
        println(" - ID: ${planta.idPlanta}, Común: ${planta.nombreComun}, Altura: ${planta.altura}m")
    }

    escribirDatosJSON(salidaJSON, datos)
}

fun leerDatosInicialesJSON(ruta: Path): List<PlantaJSON> {
    // Leemos el contenido completo del JSON como String
    val jsonString = Files.readString(ruta)
    
    // Convertimos de texto JSON a una lista de objetos Planta
    return Json.decodeFromString<List<PlantaJSON>>(jsonString)
}

fun escribirDatosJSON(ruta: Path, plantas: List<PlantaJSON>) {
    try {
        // Configuramos el formateador con la opción 'prettyPrint' activa
        val jsonConfigurador = Json { prettyPrint = true }
        val jsonString = jsonConfigurador.encodeToString(plantas)
        
        Files.writeString(ruta, jsonString)
        println("\nInformación guardada en JSON: $ruta")
    } catch (e: Exception) {
        println("Error al guardar JSON: ${e.message}")
    }
}
```

!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que la salida por consola es:

    ```text
    Ruta relativa: muestras\orquidea.jpg
    ```


!!! warning "Práctica 3: amplía tu proyecto"
    En esta práctica añadiremos un fichero de datos en formato **JSON** y ampliaremos el menú con una opción para leer su contenido.

    1. **Crea tu archivo XJSON**
       Genera manualmente un archivo con extensión `.json` con al menos 5 registros que cumplan con la estructura de tu *data class*. 
    
    2. **Amplia el menú**
       Añade la opción 3 para leer el JSON**

    3. **Implementa la lectura del JSON:**
       Cuando el usuario seleccione la opción `3`, llama a una función dedicada (por ejemplo, `leerJSON()`) que compruebe la existencia del fichero, lo lea, deserialice las líneas a objetos de tu *data class* y muestre la lista formateada por consola.

    **Aspectos Técnicos Obligatorios:**

      * **Configuración del proyecto:** Añade las dependencias necesarias en tu archivo `build.gradle.kts`.
      * **Robustez y manejo de errores:** Debes verificar la accesibilidad y existencia del fichero mediante `Files.isReadable()` antes de iniciar la lectura. 






<span class="mi_h3">4.4. Conversiones entre ficheros</span>

Cada uno de los formatos analizados cuenta con virtudes y flaquezas particulares en función del contexto (velocidad, legibilidad, flexibilidad). Convertir entre CSV, JSON y XML permite aprovechar las ventajas de cada uno en nuestro herbario digital.

El flujo estandarizado para realizar conversiones no consiste en transformar un formato de texto en otro de forma directa (lo que aumentaría la complejidad y fragilidad del código), sino en utilizar las clases de Kotlin como un **paso intermedio universal**:

```text
Formato Origen (ej. CSV) ➔ Objetos Kotlin en Memoria ➔ Formato Destino (ej. JSON)
```




!!! warning "Práctica 6: Amplía tu proyecto"

    1. **Amplia el menú con las siguientes opciones**
       * Opción 4: convertir JSON a CSV
       * Opción 5: convertir JSON a XML
       * Opción 6: convertir XML a JSON 
       * Opción 7: convertir XML a CSV
       * Opción 8: convertir CSV a JSON
       * Opción 9: convertir CSV a XML

    2. **Implementa las opciones del punto anterior**
       Cuando el usuario seleccione la opción del menú, llama a una función correspondente que compruebe la existencia del fichero, lo lea, deserialice las líneas a objetos de tu *data class* y lo convierta en el formato de destino.

    **Aspectos Técnicos Obligatorios:**
      * **Configuración del proyecto:** Añade las dependencias necesarias en tu archivo `build.gradle.kts`.
      * Uso de las clases de `java.nio.file` (`Path` y `Files`) para toda la administración de rutas e interacciones de ficheros de texto.
      * **Robustez y manejo de errores:** Debes verificar la accesibilidad y existencia del fichero mediante `Files.isReadable()` antes de iniciar la lectura. 
      * **Verificación:** Muestra los resultados limpios del fichero transformado por la consola.




!!! danger "Entrega parcial"
    Entrega en Aules la carpeta `main` de tu proyecto comprimida en formato .zip

    **IMPORTANTE**: El proyecto no debe contener código que no se utilice, ni restos de pruebas de los ejemplos y no debe estar separado por prácticas. Debe ser un proyecto totalmente funcional.






---
<span class="mi_h3">Autoría</span>

<span class="mi_autoria">
Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)
</span>
---