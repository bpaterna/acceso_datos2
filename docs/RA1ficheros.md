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

```kotlin
import java.nio.file.Path

fun main() {
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

Salida por consola:

```text
Ruta relativa: muestras\orquidea.jpg
Ruta absoluta: F:\bio-proyecto\muestras\orquidea.jpg
Ruta absoluta Windows: C:\Herbario\Especies\Helechos
Ruta absoluta Linux: \home\botanico\jardin\flora_mediterranea
```


!!! success "Prueba y analiza el ejemplo 1"
    Prueba el código de ejemplo y verifica que funciona correctamente.



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

Imagina que tenemos una carpeta llamada `muestras_desordenadas` donde guardamos fotos, descripciones de texto y registros de audio de la naturaleza sin ningún orden. Este programa organizará automáticamente los archivos en subcarpetas según su formato (extensión) para que el herbario quede perfectamente estructurado.

```kotlin
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.StandardCopyOption
import kotlin.io.path.extension // Extensión de Kotlin para obtener la extensión

fun main() {
    // 1. Ruta de la carpeta de muestras botánicas a organizar
    val carpeta = Path.of("muestras_desordenadas")
    
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

Salida por consola:

```text
--- Iniciando la clasificación botánica en la carpeta: muestras_desordenadas ---
-> Creando nueva sección para archivos: .jpg
-> Clasificando rosa_silvestre.jpg en la carpeta [.jpg]
-> Clasificando pino_albar.jpg en la carpeta [.jpg]
-> Creando nueva sección para archivos: .txt
-> Clasificando propiedades_manzanilla.txt en la carpeta [.txt]
-> Clasificando guia_cuidados_helecho.txt en la carpeta [.txt]
-> Creando nueva sección para archivos: .pdf
-> Clasificando estudio_taxonomico_orquideas.pdf en la carpeta [.pdf]

--- ¡Clasificación del herbario completada con éxito! ---
```

!!! success "Prueba y analiza el ejemplo 2"
    Prueba el código de ejemplo y verifica que funciona correctamente.


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

Queremos crear un reporte visual de toda la estructura de nuestra carpeta de botánica tras haberla ordenado. Necesitamos listar cada una de las subcarpetas de clasificación (`jpg`, `txt`, `pdf`) y ver qué muestras hay dentro de cada una de ellas de forma jerárquica.

```kotlin
import java.nio.file.Files
import java.nio.file.Path

fun main() {
    val carpetaPrincipal = Path.of("muestras_desordenadas")
    
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

Salida por consola:




!!! success "Prueba y analiza el ejemplo 3"
    Prueba el código de ejemplo y verifica que funciona correctamente.

    ```text
    --- Estructura final del Herbario Digital con Files.walk() ---
    [CATEGORÍA] jpg
        [MUESTRA] pino_albar.jpg
        [MUESTRA] rosa_silvestre.jpg
    [CATEGORÍA] pdf
        [MUESTRA] estudio_taxonomico_orquideas.pdf
    [CATEGORÍA] txt
        [MUESTRA] guia_cuidados_helecho.txt
        [MUESTRA] propiedades_manzanilla.txt
    ```


---
<span class="mi_h3">Autoría</span>

<span class="mi_autoria">
Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)
</span>
---