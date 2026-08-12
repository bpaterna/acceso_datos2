# DBeaver

![Imagen 1](img/dbeaver/dbeaver01.png)

<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                                                       |
|----------|------------|-------------------------------------------------------------------|
| 1.0      | 11-10-2025 | Adaptación de los materiales a markdown                           |
| 1.1      | 06-11-2025 | Ampliación con sección ver funciones y procedimientos almacenados |

<span class="mi_h3">Introducción</span>

**DBeaver** es una herramienta gráfica y gratuita que permite gestionar múltiples bases de datos de forma visual. Algunas de las acciones que podemos realizar con esta herramienta son las siguientes:

- Explorar la estructura de la base de datos (tablas, vistas, claves, relaciones…).

- Consultar datos.

- Modificar tablas, añadir registros o ejecutar scripts SQL sin salir del proyecto.

- Probar consultas antes de implementarlas en el programa.




<!--

## Conexión a SQLite

Los siguientes pasos ilustran como conectar a la BD **florabotanica.sqlite** de nuestro proyecto.

Para conectar a una base de datos, una vez iniciado el programa hay que hacer clic en el botón **Nueva conexión** (ícono de enchufe) o ir al menú `Archivo > Nueva conexión`.

![Imagen 2](img/dbeaver/dbeaver02.png)


Luego hay que seleccionar el tipo de base de datos a la que se quiere conectar. A continuación de describen los pasos para conectar a SQLite y a MySQL.


1. Selecciona el tipo de base de datos **SQlite** y pulsa **Siguiente**.
![Imagen 3](img/dbeaver/dbeaver03.png)



2. Introduce la ruta donde se encuentra la BD y haz clic en el botón *probar conexión*
![Imagen 4](img/dbeaver/dbeaver04.png)


    Si todo está correcto, verás un mensaje de éxito.  
    
    Si DBeaver necesita un controlador (driver), te lo ofrecerá para descargar automáticamente.
    ![Imagen 5](img/dbeaver/dbeaver05.png)

    Si la descarga falla, ve a https://github.com/xerial/sqlite-jdbc/releases y descarga el archivo **sqlite-jdbc-3.50.3.0.jar**

    ![Imagen 6](img/dbeaver/dbeaver06.png)

3. Haz clic en **Finalizar*. La nueva conexión aparecerá en el panel lateral izquierdo.  
Desde allí puedes:

- Ver tablas, vistas, funciones y procedimientos
- Ejecutar sentencias SQL
- Consultar y modificar registros
- Exportar datos en distintos formatos

![ref](img/dbeaver6.jpg)


FALTA
-->


<span class="mi_h3">Conexión a MySQL</span>

Para conectar a una base de datos *MySQL* sigue estos pasos:

1. Haz clic en el botón `Nueva conexión` (ícono de enchufe) o entra al menú `Archivo > Nueva conexión`

    ![Imagen 2](img/dbeaver/dbeaver02.png)

2. Selecciona `MySQL` y pulsa en el botón `Siguiente`

    ![Imagen 8](img/dbeaver/dbeaver08.jpg)

3. Indica los datos del `servidor`, `usuario` y `contraseña`. Si quieres ver todas las bases de datos a las que el usuario puede acceder deja marcada la casilla `Show all database`y no indiques nada en la casilla `database` 

    ![Imagen 9](img/dbeaver/dbeaver09.jpg)

    !!!Note ""
        Si aparece `Error "Public Key Retrieval is not allowed"` haz clic con el botón derecho en tu conexión y selecciona `Editar conexión` luego ve a la pestaña `Driver Properties` y cambia la propiedad `allowPublicKeyRetrieval` a `TRUE` (por defecto está a `false`). Luego haz clic en el botón `Aceptar`.
        ![Imagen 10](img/dbeaver/dbeaver10.jpg)

4. Una vez conectado, verás las bases de datos del servidor

    ![Imagen 11](img/dbeaver/dbeaver11.jpg)



<span class="mi_h3">Ver funciones y procedimientos almacenados</span>

Para poder ver el código de una función o un procedimiento almacenado en nuestra BD seguir estos pasos:

1. Desplegar el apartado Procedures de la BD.

2. Hacer clic con el botón derecho sobre la función o procedimiento, entrar en `Generar SQL` y luego en `DDL`.

    ![Imagen 12](img/dbeaver/dbeaver12.jpg)

    El código de la fución o procedimiento aparecerá en una ventana nueva.

    ![Imagen 13](img/dbeaver/dbeaver13.jpg)



---

<span class="mi_h3">Autoría</span>

Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)

---
