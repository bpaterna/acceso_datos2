# 1: Introducción y Entorno de Desarrollo


<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                             |
|----------|------------|-----------------------------------------|
| 1.0      | 27-06-2026 | Adaptación de los materiales a markdown |




## 1. Introducción

En el módulo de Programación de 1º de DAM, se trabaja habitualmente con **Java**, un lenguaje orientado a objetos ampliamente utilizado en el desarrollo de aplicaciones empresariales. Durante ese primer contacto, se asimilan conceptos fundamentales como estructuras de control, clases, objetos y herencia.

En este curso, dentro del módulo de **Acceso a Datos**, continuaremos aplicando estos mismos conceptos utilizando **Kotlin**.

### ¿Qué es Kotlin?
Kotlin es un lenguaje de programación moderno, conciso y seguro diseñado por JetBrains (los creadores de IntelliJ IDEA). Sus características clave son:
* **Ejecución en la JVM:** Funciona sobre la Máquina Virtual de Java (JVM).
* **Interoperabilidad:** Es 100% interoperable con Java. Esto significa que podemos usar librerías de Java en código de Kotlin y viceversa de forma directa.
* **Multiuso:** Se utiliza para desarrollo móvil (Android), aplicaciones de escritorio (Swing, JavaFX o Compose Desktop), backends web (Ktor o Spring) y desarrollo multiplataforma (Kotlin Multiplatform).





## 2. Instalación de IntelliJ IDEA Community

Para el desarrollo de nuestras aplicaciones utilizaremos el Entorno de Desarrollo Integrado (IDE) **IntelliJ IDEA** en su versión gratuita **Community Edition**.

### 2.1. Instalación en Ubuntu Mate (Ordenadores de clase)

Si trabaja desde el sistema operativo Ubuntu Mate del aula, siga estos pasos:

1. **Descargar los archivos:** Acceda a la web oficial [jetbrains.com/idea/download/](https://www.jetbrains.com/idea/download/) y seleccione la pestaña de **Linux**. Busque la sección *IntelliJ IDEA Community Edition* y descargue el archivo `.tar.gz`.
2. **Descomprimir y ubicar:** Extraiga el archivo descargado (que habitualmente se guardará en la carpeta `Descargas`) y mueva la carpeta resultante a su directorio de usuario (fuera de la carpeta temporal de descargas).
3. **Configurar permisos de ejecución:**
    * Navegue hasta la carpeta `bin` dentro del directorio extraído.
    * Localice el archivo ejecutable `idea.sh`.
    * Haga clic derecho sobre él, seleccione **Propiedades > Permisos** y asegúrese de que la opción **Permitir ejecutar el archivo como un programa** (o *Permet executar*) esté marcada.
    * Ejecute el archivo desde la terminal o haciendo doble clic sobre él.

### 2.2. Instalación en Windows

Para realizar la instalación en un equipo personal con Windows:

1. **Descargar el instalador:** Acceda a la misma página de descargas y elija la pestaña de **Windows**. Descargue el archivo `.exe` de la versión *Community Edition*.
2. **Asistente de instalación:** Ejecute el instalador descargado y siga los pasos indicados en pantalla:
    * **Directorio de destino:** Por defecto se instalará en `C:\Program Files\JetBrains\...` (requiere aproximadamente 3.2 GB de espacio en disco).
    * **Opciones de instalación:** Se recomienda marcar la opción para crear un acceso directo en el escritorio y, opcionalmente, asociar las extensiones de archivo `.kt` (Kotlin).
    * **Menú Inicio:** Seleccione la carpeta de destino del menú (por defecto *JetBrains*) y pulse **Install**.
3. **Primer inicio:** Al abrir la aplicación por primera vez, acepte los términos de uso y elija si desea importar configuraciones previas en caso de que ya tuviera otra versión instalada.

---

## 3. Gestión y Configuración de Proyectos

### 3.1. Organización del espacio de trabajo
Antes de crear programas, es importante mantener el espacio de trabajo organizado. Es recomendable crear una carpeta raíz en su unidad de almacenamiento (por ejemplo, una carpeta llamada `kot` dentro de la unidad de trabajo) donde se guardarán de forma ordenada los proyectos del curso.

> *Consejo de personalización:* Puede cambiar la apariencia del entorno pulsando en el icono de la **rueda dentada (Ajustes)** en la esquina inferior izquierda de la pantalla de bienvenida. Para estas explicaciones utilizaremos el modo de color claro (*Light Mode*).

### 3.2. Creación de un nuevo proyecto (`control_plantas`)

Para crear su primer proyecto botánico en Kotlin:

1. Abra IntelliJ IDEA y haga clic en **New Project** en la ventana de inicio.
2. Configure los parámetros en la ventana de configuración:
    * **Name:** `control_plantas`
    * **Location:** Seleccione su directorio de trabajo (por ejemplo, `F:\kot` o la ruta de su carpeta de usuario).
    * **Language:** Asegúrese de marcar **Kotlin** en la columna de la izquierda.
    * **Build system:** Seleccione el sistema nativo de **IntelliJ**.
    * **JDK:** Seleccione la versión disponible de Java instalada en el sistema (por ejemplo, JDK 24 o la versión del aula).
    * **Opciones adicionales:** Asegúrese de tener activada la opción **Add sample code** (para disponer de un archivo inicial de ejemplo) y **Use compact project structure**.
3. Haga clic en **Create**.

---

### 3.3. Estructura del proyecto y creación de archivos

Al crearse el proyecto, la interfaz mostrará una estructura de carpetas en el margen izquierdo:

* **`.idea` / `out`:** Carpetas de configuración interna del IDE y de compilación (no deben modificarse manualmente).
* **`src` (Source):** Es la carpeta más importante. Aquí se almacena todo el código fuente de nuestra aplicación.
* **`Main.kt`:** Archivo que contiene el punto de entrada de nuestro programa.

#### Cómo crear un nuevo archivo de código:
Si necesita crear una clase o un nuevo archivo de Kotlin en el futuro:
1. Haga clic derecho sobre la carpeta **`src`**.
2. Seleccione **New > Kotlin File/Class**.
3. Escriba el nombre deseado para el archivo y seleccione el tipo correspondiente (File, Class, Interface, etc.).

---

### 3.4. Primer programa: ¡Hola, Invernadero! (Ejecución de la aplicación)

Para que un proyecto en Kotlin pueda ejecutarse, requiere como mínimo tener un punto de entrada definido por una función llamada `main`. Kotlin utiliza la palabra reservada `fun` para declarar funciones.

Reemplace el código autogenerado del archivo `Main.kt` con el siguiente programa inicial, adaptado para realizar el control y simulación de riego de una planta:

```kotlin
fun main() {
    val planta = "Orquídea"
    println("¡Bienvenido al sistema de control botánico!")
    println("Planta seleccionada en el sistema: $planta")

    // Simulación del registro de crecimiento diario (5 días)
    for (dia in 1..5) {
        println("Día $dia: La planta '$planta' ha sido regada correctamente.")
    }
}
```

#### Ejecución del programa:
Para ejecutar el código escrito, haga clic en el icono verde de **Play** ($\vartriangleright$) situado en el margen izquierdo de la función `main` (o en la barra de herramientas superior).

El resultado de la ejecución se mostrará inmediatamente en la consola, en la parte inferior de la pantalla:

```text
¡Bienvenido al sistema de control botánico!
Planta seleccionada en el sistema: Orquídea
Día 1: La planta 'Orquídea' ha sido regada correctamente.
Día 2: La planta 'Orquídea' ha sido regada correctamente.
Día 3: La planta 'Orquídea' ha sido regada correctamente.
Día 4: La planta 'Orquídea' ha sido regada correctamente.
Día 5: La planta 'Orquídea' ha sido regada correctamente.

Process finished with exit code 0
```

---

### 3.5. Compartir y entregar proyectos

Cuando deba entregar una tarea de programación o compartir un proyecto con el profesor, evite subir archivos sueltos. El procedimiento correcto se realiza desde el explorador de archivos de su sistema operativo:

1. Cierre el IDE IntelliJ IDEA para asegurarse de que no haya procesos de escritura activos.
2. Localice la carpeta de su proyecto (por ejemplo, la carpeta `control_plantas` que se encuentra dentro de su espacio de trabajo `kot`).
3. Comprima la carpeta del proyecto en un único archivo comprimido:
    * **En Windows:** Haga clic derecho sobre la carpeta del proyecto $\rightarrow$ **Enviar a $\rightarrow$ Carpeta comprimida (en zip)**.
    * **En Ubuntu:** Haga clic derecho sobre la carpeta $\rightarrow$ **Comprimir... $\rightarrow$ Seleccionar formato .zip**.
4. Envíe o suba a la plataforma del aula el archivo `.zip` resultante.










---

<span class="mi_h3">Autoría</span>

Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)

---