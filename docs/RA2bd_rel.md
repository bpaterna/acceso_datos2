# RA2. Acceso a Bases de Datos relacionales

!!! info "RA2"
    Desarrolla aplicaciones que gestionan información almacenada en bases de datos relacionales identificando y utilizando mecanismos de conexión..



<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                                                   |
|----------|------------|---------------------------------------------------------------|
| 1.0      | 12-08-2026 | Adaptación de los materiales a markdown                       |
| 1.1      | 24-08-2026 | Ampliación con preguntas de autoevaluación |


## 1. Introducción

Las bases de datos relacionales son esenciales en el desarrollo de aplicaciones. Su integración con una aplicación requiere realizar una **conexión** al sistema gestor de base de datos (SGBD) desde el lenguaje de programación. Este tema se centra en cómo realizar esa conexión, cómo trabajar con datos mediante sentencias SQL y cómo aplicar buenas prácticas, como el cierre de recursos, el uso de transacciones y procedimientos almacenados.

Una **base de datos relacional** es un sistema de almacenamiento de información que **organiza los datos en tablas**. Cada tabla representa una entidad (por ejemplo, **plantas o jardines**) y está compuesta por filas y columnas, donde cada fila representa un registro único y cada columna contiene un atributo específico de ese registro. Estas bases de datos (BD) siguen el **Modelo Relacional** que permite establecer vínculos o **relaciones entre diferentes tablas mediante claves primarias y foráneas**, facilitando así la integridad, la coherencia y la eficiencia en el manejo de grandes volúmenes de datos.

**Ejemplo de tabla `plantas`:**

| id_planta | nombre_comun | altura    |
| :--- | :--- |:------|
| 1 | Aloe Vera | 8.50  |
| 2 | Ficus Benjamina | 15.00 |


**Ejemplo de tabla `jardines`:**

| id_jardin | nombre | ciudad |
|:----------|:-------| :--- |
| 1         | Atenea | Castellón |
| 2         | Olimpo | Valencia |


La **Clave primaria (Primary Key)** es una columna (o conjunto de columnas) que **identifica de forma única** cada fila de una tabla. En nuestro ejemplo:

- `id_planta` es la clave primaria en la tabla `plantas`.
- `id_jardin` es la clave primaria en la tabla `jardines`.

La **Clave foránea (Foreign Key)** es una columna que **hace referencia a una clave primaria de otra tabla** para establecer una relación.

Si queremos registrar las plantas que tiene cada jardín, podemos utilizar una tabla intermedia llamada `jardines_plantas`. Esta tabla tendrá sus propias relaciones mediante claves foráneas:
* El campo `id_jardin` será una clave foránea que apunta al campo `id_jardin` de la tabla `jardines`.
* El campo `id_planta` será una clave foránea que apunta al campo `id_planta` de la tabla `plantas`.

**Ejemplo de tabla `jardines_plantas`:**

| id_jardin_planta | id_jardin | id_planta | fecha_plantacion |
|:-----------------|:----------| :--- |:-----------------|
| 1                | 1         | 1 | 2025-09-18       |
| 2                | 1         | 2 | 2025-09-18       |


El lenguaje **SQL (Structured Query Language)** se utiliza para gestionar bases de datos relacionales ya que gracias a él se pueden crear, modificar, consultar y eliminar datos de forma sencilla y estandarizada. Es lo que se denomina **CRUD**, es decir, **C**reate (crear), **R**ead (Leer), **U**pdate (Actualizar) y **D**elete (Borrar). Esto lo convierte en la opción preferida para una amplia variedad de aplicaciones empresariales y tecnológicas.

Algunos de sus comandos básicos son:

* **SELECT**: consultar datos
* **INSERT**: añadir registros
* **UPDATE**: modificar datos existentes
* **DELETE**: eliminar registros
* **CREATE**: definir tablas, claves, relaciones, etc.

Un ejemplo sencillo de consulta podría ser:

```sql
SELECT nombre FROM jardines WHERE ciudad = 'Valencia';
```

<span class="mi_h3">Tipos de SGBD relacionales</span>

Conocer qué **tipo de gestor de base de datos** se está utilizando es esencial para poder **conectar** correctamente desde una aplicación, ya que cada uno necesita su propio conector o driver. Podemos encontrar:

**1. Gestores independientes (cliente-servidor): PostgreSQL, MySQL, Oracle, SQL Server...**

- Sistemas robustos y escalables, ideales para entornos multi-usuario y aplicaciones web.
- Requieren un servidor dedicado y una configuración más compleja.
- Casos de uso: aplicaciones web, servicios empresariales, sistemas con alta demanda de acceso concurrente.


**2. Gestores embebidos: SQLite, H2, Derby...**

- Base de datos ligera, sin servidor, ideal para aplicaciones móviles o de escritorio donde no se requiere gestión centralizada.
- Fácil de configurar y desplegar, ya que la base de datos reside en un archivo local.
- Casos de uso: aplicaciones de escritorio, móviles, prototipos, pruebas unitarias.



## 2. Conexión a un SGBD

Cuando desarrollamos aplicaciones que trabajan con información persistente, necesitamos acceder a BD para consultar, insertar, modificar o eliminar datos. Existen dos formas principales de hacerlo desde el código:

- Acceso mediante ORM (Object-Relational Mapping).
- Acceso mediante conectores.


<span class="mi_h3">Acceso mediante ORM</span>

Un **ORM** es una herramienta que permite trabajar con la base de datos como si fuera un conjunto de objetos, evitando tener que escribir directamente SQL. El **ORM** se encarga de mapear las tablas a clases y los registros a objetos, y traduce automáticamente las operaciones del código a consultas SQL. Es ideal para trabajar de forma más productiva en aplicaciones complejas. Sus principales características son:

- Se trabaja con clases en lugar de tablas SQL.
- Ahorra mucho código repetitivo.
- Ideal para proyectos medianos o grandes que requieren mantener muchas entidades.

**Algunos ejemplos de ORMs**

ORM / Framework|	Lenguaje|	Descripción
---------------|---------|-----------------
Hibernate|	Java/Kotlin|	El ORM más utilizado con JPA
Exposed|	Kotlin|	ORM ligero y expresivo creado por JetBrains
Spring Data JPA|	Java/Kotlin|	Abstracción que automatiza el acceso a datos
Room|	Java/Kotlin|	ORM oficial para bases de datos SQLite en Android    

**JPA** (Java Persistence API) es una especificación estándar de Java que define cómo se deben mapear objetos Java (o Kotlin) a tablas de bases de datos relacionales. Es decir, permite gestionar la persistencia de datos de forma orientada a objetos, sin necesidad de escribir SQL directamente. Es el estándar utilizado por las herramientas ORM como Hibernate, EclipseLink, o Spring Data JPA.


<span class="mi_h3">Acceso mediante conectores</span>

Un **conector** (también llamado driver) es una librería software que permite que una aplicación se comunique con un gestor de base de datos (SGBD). Actúa como un puente entre nuestro código y la base de datos, traduciendo las instrucciones SQL a un lenguaje que el gestor puede entender y viceversa. Sin un conector, tu aplicación no podría comunicarse con la base de datos.

Una base de datos puede ser accedida desde diferentes orígenes o herramientas, siempre que tengamos:

- Las credenciales de acceso (usuario y contraseña)
- El host/servidor donde se encuentra la base de datos
- El motor de base de datos (PostgreSQL, MySQL, SQLite, etc.)
- Los puertos habilitados y los permisos correctos


Las principales formas de conectarse a una base de datos son las siguientes:

| Medio de conexión                         | Descripción                                                                 |
|-------------------------------------------|-----------------------------------------------------------------------------|
| Aplicaciones de escritorio             | Herramientas gráficas como **DBeaver**, **pgAdmin**, **MySQL Workbench**, **DB Browser for SQLite**. Permiten explorar, consultar y administrar BD de forma visual. |
| Aplicaciones desarrolladas en código   | Programas en **Kotlin**, **Java**, **Python**, **C#**, etc., mediante **conectores** como **JDBC**, **psycopg2**, **ODBC**, etc. para acceder a BD desde código. |
| Línea de comandos                      | Clientes como `psql` (PostgreSQL), `mysql`, `sqlite3`. Permiten ejecutar comandos SQL directamente desde terminal. |
| Aplicaciones web                        | Sitios web que acceden a BD desde el backend (por ejemplo, en Spring Boot, Node.js, Django, etc.). |
| APIs REST o servidores intermedios     | Servicios web que conectan la BD con otras aplicaciones, actuando como puente o capa de seguridad. |
| Aplicaciones móviles                   | Apps Android/iOS que acceden a BD locales (como **SQLite**) o remotas (vía **Firebase**, API REST, etc.). |
| Herramientas de integración de datos   | Software como **Talend**, **Pentaho**, **Apache Nifi** para migrar, transformar o sincronizar datos entre sistemas. |

De todas las formas posibles de interactuar con una base de datos, nos vamos a centrar en el uso de **conectores JDBC (Java Database Connectivity)**. Una aplicación (escrita en Kotlin, Java u otro lenguaje) puede leer, insertar o modificar información almacenada en una base de datos relacional si previamente se ha conectado al sitema gestor de base de datos (SGBD). **JDBC** es una API estándar de Java (y compatible con Kotlin) que permite conectarse a una BD, enviar instrucciones SQL y procesar los resultados manualmente. Es el método de más bajo nivel, pero ofrece un control total sobre lo que ocurre en la BD. Es ideal para aprender los fundamentos del acceso a datos y aprenderlo ayuda a entender mejor lo que hace un ORM por debajo.

Sus principales características son:

- El programador escribe directamente las consultas SQL.
- Requiere gestionar manualmente conexiones, sentencias y resultados.
- Se necesita un driver específico (conector) para cada SGBD:


A continuación se muestra su sintaxis general. Aunque puede variar según el SGBD con el que se trabaje. Por ejemplo en SQLite no se necesita usuario ni contraseña ya que es una base de datos local:

    jdbc:<gestor>://<host>:<puerto>/<nombre_base_datos>


También dependiendo del SGBD será necesario utilizar la dependencia adecuada en **Gradle** añadiendo las líneas correspondientes en el fichero **build.gradle.kts** dentro del bloque `dependencies { . . . }`


**Algunos ejemplos de conectores según el SGBD**

SGBD|	Conector (Driver JDBC)|	URL de conexión típica | Dependencia Gradle
----|-------------------------|-----------------------|-----------------------
PostgreSQL|	org.postgresql.Driver| jdbc:postgresql://host:puerto/nombreBD |implementation("org.postgresql:postgresql:42.7.1")
MySQL / MariaDB|	com.mysql.cj.jdbc.Driver| jdbc:mysql://host:puerto/nombreBD | implementation("com.mysql:mysql-connector-j:8.3.0")
SQLite (embebido)|	org.sqlite.JDBC	|jdbc:sqlite:nombreBD | implementation("org.xerial:sqlite-jdbc:3.43.0.0")






<span class="mis_ejemplos">Ejemplo 1: Conexión a SQLite</span>

El siguiente ejemplo muestra como conectar a una BD **SQLite** llamada `florabotanica.sqlite` que se encuentra en la carpeta `datos` dentro de un proyecto en **Kotlin**.


``` kotlin
import java.io.File
import java.sql.DriverManager

fun main() {
    val dbPath = "datos/florabotanica.sqlite"
    val file = File(dbPath)
    println("Ruta absoluta de la BD: ${file.absolutePath}")
    
    val url = "jdbc:sqlite:${dbPath}"
    DriverManager.getConnection(url).use { conn ->
        println("Conexión establecida correctamente")
    }   
}
```

!!! success "Prueba y analiza el ejemplo"
    - Crea un proyecto kotlin con gradle y añade las dependencias para trabajar con SQLite.
    - Descarga el fichero con la BD de ejemplo desde el siguiente enlace:
       [florabotanica.sqlite](recursos/florabotanica.sqlite){:florabotanica.sqlite} y cópialo en una carpeta llamada `datos` que deberás crear en la raíz del proyecto de IntelliJ (al mismo nivel que la carpeta `src` y que el archivo `build.gradle.kts`).
    - Ejecuta el programa y verifica que la conexión con la BD se establece correctamente.


!!! warning "Práctica 1: Crea tu BD y conecta a ella desde tu proyecto Gradle"
    - Crea un proyecto kotlin con gradle y añade las dependencias para trabajar con SQLite.    
    - A partir del fichero de información utilizado en el proyecto de la unidad anterior, crea una base de datos SQLite **nombre_de_tu_BD.sqlite** con una tabla que contenga la información del fichero. Puedes utilizar [DB Browser for SQLite](db_browser_sqlite.html) y guárdala en la carpeta `datos` de tu proyecto.
    - Añade las líneas de código necesarias para conectar a tu BD y muestra un mensaje indicando si se ha establecido la conexión correctamente o no.



## 3. Operaciones sobre la BD

En **JDBC** (Java Database Connectivity), las operaciones sobre la base de datos se realizan  utilizando los siguientes objetos y métodos:

- **Connection**, establece el canal de comunicación con el SGBD (PostgreSQL, MySQL, etc.)

- Los objetos **PreparedStatement** y **CreateStatement** se utlizan para enviar consultas SQL desde el programa a la base de datos. A continuación se muestra una tabla con el uso de cada uno:


| Si necesitas...                                     | Usa...            |
|-----------------------------------------------------|-------------------|
| Consultas sin parámetros                            | `CreateStatement`       |
| Consultas con datos del usuario                     | `PreparedStatement` |
| Seguridad frente a inyecciones SQL                  | `PreparedStatement` |
| Ejecutar muchas veces con distintos valores         | `PreparedStatement` |
| Crear tablas o sentencias SQL complejas que no cambian | `CreateStatement`


- Los métodos **executeQuery()**, **executeUpdate()** y **execute()** se utilizan para ejecutar sentencias SQL, pero se usan en contextos diferentes. A continuación se muestra una tabla con el uso de cada uno:


Método|	Uso principal|	Tipo de sentencia SQL|	Resultado que devuelve
------|--------------|-----------------------|------------------------
**executeQuery()**|	Realizar consultas|	SELECT|	Objeto  **ResultSet** con el resultado de la consulta SQL. Permite recorrer fila a fila el conjunto de resultados, accediendo a cada campo por nombre o por posición
**executeUpdate()**|Realizar modificaciones|	INSERT, UPDATE, DELETE, DDL (CREATE, DROP, etc.)|	Entero con el número de filas afectadas
**execute()**|No se sabe de antemano qué tipo de sentencia SQL se va a ejecutar (consulta o modificación)| Sentencias SQL que pueden devolver varios resultados| Booleano **true** si el resultado es un ResultSet (SELECT) y **false** si el resultado es un entero (INSERT, UPDATE, DELETE,CREATE, ALTER)


<span class="mi_h3">Liberación de recursos</span>

Cuando una aplicación accede a una base de datos, abre varios recursos internos que consumen memoria y conexiones activas en el sistema:

- La conexión con el servidor de base de datos (Connection).
- Las sentencias SQL preparadas (Statement o PreparedStatement).
- El resultado de la consulta (ResultSet).

Estos recursos no se liberan automáticamente cuando se termina su uso (especialmente en Java o Kotlin con JDBC). Si no se cierran correctamente, se pueden producir problemas como:

- Fugas de memoria.
- Bloqueo de conexiones (demasiadas conexiones abiertas).
- Degradación del rendimiento.
- Errores inesperados en la aplicación.

Para liberar estos recursos hay dos opciones:

**1. Usar try–catch–finally manual**

Cuándo:

- No estás en Kotlin o no puedes usar .use.

- Necesitas capturar y manejar excepciones dentro del mismo método.

- Necesitas lógica extra antes o después de cerrar el recurso (por ejemplo, reintentos, logging detallado, liberar múltiples recursos en un orden específico).

- Estás trabajando en un proyecto que sigue un estilo más clásico de Java.


**2. Utilización de .use { ... }**

Es la que utilizaremos en nuestros proyectos.

Se recomienda utilizarlo si:

- Estás trabajando con un recurso que implementa AutoCloseable (Connection, Statement, ResultSet, File, etc.).

- Solo necesitas abrir, usar y cerrar el recurso de forma automática.

- No necesitas lógica compleja de manejo de excepciones dentro del mismo bloque.

Ventajas:

- Código más limpio y legible.

- Cierra automáticamente el recurso aunque ocurra una excepción.

- Evita errores de olvidar close().



<span class="mis_ejemplos">Ejemplo 2: Utilización de close()</span>

A continuación tienes un ejemplo en el que se declara una constante con la ruta a la BD, se establece la conexión, se consultan datos y se cierran los recursos abiertos (ResultSet, Statement y Connection) utilizando **close()** dentro de un bloque **finally** para garantizar su cierre incluso si ocurre un error. El orden correcto de cierre es del más interno al más externo:

``` kotlin
import java.sql.Connection
import java.sql.Statement
import java.sql.ResultSet
import java.sql.DriverManager
import java.sql.SQLException

// Ruta al archivo de base de datos SQLite
const val URL_BD = "jdbc:sqlite:src/main/resources/florabotanica.sqlite"

fun main() {
    var conn: Connection? = null
    var stmt: Statement? = null
    var rs: ResultSet? = null

    try {
        conn = DriverManager.getConnection(URL_BD)
        println("Conectado a la BD")

        stmt = conn.createStatement()
        rs = stmt.executeQuery("SELECT * FROM plantas")

        while (rs.next()) {
            println(rs.getString("nombre_comun"))
        }
    } catch (e: SQLException) {
        println("Error al conectar o consultar la base de datos: ${e.message}")
    } catch (e: Exception) {
        e.printStackTrace()
    } finally {
        try {
            rs?.close()
            stmt?.close()
            conn?.close()
            println("Conexión cerrada correctamente")
        } catch (e: Exception) {
            println("Error al cerrar los recursos: ${e.message}")
        }
    }
}
```


!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que funciona correctamente.


<span class="mis_ejemplos">Ejemplo 3: Utilización de .use</span>

A continuación se muestra un **ejemplo con .use (sin necesidad de cerrar recursos manualmente)** que realiza la misma consulta que el ejemplo anterior. Ahora los recursos abiertos de cerrarán automáticamente. Además, por organización del código, se ha declarado una función para conectar a la BD:

- **conn.use { ... }** cierra la conexión automáticamente al final del bloque.

- **stmt.use { ... }** cierra el Statement automáticamente.

- **ResultSet** se cierra cuando cierras el Statement.

``` kotlin
import java.sql.Connection
import java.sql.DriverManager
import java.sql.SQLException

// Ruta al archivo de base de datos SQLite
const val URL_BD = "jdbc:sqlite:src/main/resources/florabotanica.sqlite"

// Obtener conexión
fun conectarBD(): Connection? {
    return try {
        DriverManager.getConnection(URL_BD)
    } catch (e: SQLException) {
        e.printStackTrace()
        null
    }
}

fun main() {
    conectarBD()?.use { conn ->
        println("Conectado a la BD")

        conn.createStatement().use { stmt ->
            stmt.executeQuery("SELECT * FROM plantas").use { rs ->
                while (rs.next()) {
                    println(rs.getString("nombre_comun"))
                }
            }
        }
    } ?: println("No se pudo conectar")
}
```

!!! success "Prueba y analiza el ejemplo"
    Prueba el código de ejemplo y verifica que funciona correctamente.

!!! warning "Práctica 2: amplía tu proyecto"
    - Declara una constante con la ruta a la BD. 
    - Declara una función para conectar a la BD. 
    - En el main conecta con la BD y realiza una consulta sobre tus datos utilizando .use (para no tener que cerrar recursos manualmente).





---
<span class="mi_h3">Autoría</span>

<span class="mi_autoria">
Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)
</span>
---