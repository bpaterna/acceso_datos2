# Docker

![Imagen 1](img/docker-logo.png)

<span class="mi_h3">Revisiones</span>

| Revisión | Fecha      | Descripción                             |
|----------|------------|-----------------------------------------|
| 1.0      | 06-05-2026 | Adaptación de los materiales a markdown |



## 1. Introducción

Docker es una plataforma para empaquetar aplicaciones y dependencias en contenedores ligeros y reproducibles. Es útil, entre otros, en desarrollo aislado, testing, despliegue de microservicios y en reproducir entornos. Un contenedor es una instancia en ejecución de una imagen.


## 2. Comandos básicos

La siguiente tabla recoge algunos de los comandos que utilizaremos durente este curso:

| Comando | Ejemplo y descripción         |
|---------|------------------|
|--version| **docker --version** Muestra la versión instalada de Docker        |
|pull| **docker pull mysql:8.0** Descarga imagen desde un registry (por defecto Docker Hub) al host local (se indica tag para evitar :latest)        |
|run| **docker run --name mi-c -e VAR=valor -p 8080:80 -v datos:/data -d imagen:tag** Crea y ejecuta un contenedor a partir de una imagen; opciones controlan nombre, puertos, volúmenes, variables, modo detached, etc          |
|ps| **docker ps** Lista contenedores en ejecución <br />**docker ps -a** Lista todos (incluidos detenidos)         |
|logs| **docker logs mi-c** Muestra la salida (stdout/stderr) del contenedor <br />**docker logs -n 10 mi-c** Muestra las 10 últimas líneas <br />**docker logs -f** Para seguir en tiempo real    |
|exec -it| Ejecuta un comando dentro de un contenedor en ejecución<br /> -i mantiene stdin <br />-t asigna un pseudo-TTY (útil para shells interactivos) <br />**docker exec -it mi-c bash** Ejecuta “bash” en el  contenedor <br />**docker exec -d mi-c touch /tmp/prueba** Ejecuta “touch” en el contenedor, (creará un fichero llamado “prueba” dentro del directorio “tmp”) |
|start| **docker start mi-c** Inicia un contenedor detenido       |
|stop| **docker stop mi-c** Detiene un contenedor iniciado     |
|rm| **docker rm mi-c** Elimina un contenedor     |
|cp| **docker cp host_file mi-c:/ruta/** Copia del anfitrión al contenedor<br />**docker cp mi-c:/tmp/prueba ./** Copia del contenedor al directorio actual del anfitrión                    |


## 3. Instalar Docker en Windows

**1. Descargar Docker Desktop**

- Accede a: https://www.docker.com/products/docker-desktop/
- Haz clic en **Download for Windows** y descarga el instalador (`Docker Desktop Installer.exe`).

> **Nota:** Para saber si tienes Windows ARM o Intel/AMD (x64), ve a:
>
> **Configuración → Sistema → Acerca de**
>
> Revisa el campo **"Tipo de sistema"**:
> - **Procesador basado en x64** → Intel/AMD.
> - **Procesador basado en ARM** → Qualcomm, Microsoft SQ, etc.

**2. Instalar Docker Desktop**

1. Ejecuta el instalador.
2. Marca las siguientes opciones:
    - `Use WSL 2 instead of Hyper-V`
    - `Add shortcut to desktop` (opcional)
3. Pulsa **OK / Install**.
4. Espera a que finalice la instalación.
5. Reinicia el equipo si el instalador lo solicita.

**3. Instalar WSL 2 (si no lo tienes)**

1. Abre **PowerShell** como administrador.
2. Ejecuta:

```powershell
wsl --install
```

3. Asegúrate de instalar:
    - WSL
    - Linux Kernel
    - Ubuntu (distribución predeterminada)

4. Reinicia el equipo si es necesario.

**4. Configurar Docker para usar WSL 2**

1. Abre **Docker Desktop**.
2. Ve a:

   **Settings → General**

3. Comprueba que está activada la opción:

    - `Use the WSL 2 based engine`

4. Después ve a:

   **Resources → WSL Integration**

5. Activa tu distribución Linux (por ejemplo, **Ubuntu**).
6. Haz clic en **Apply & Restart**.

**5. Verificar que Docker funciona**

1. Abre **PowerShell**, **CMD** o **Ubuntu (WSL)**.
2. Comprueba la versión instalada:

```bash
docker --version
```

3. Ejecuta la imagen de prueba:

```bash
docker run hello-world
```

> **Nota:** Si aparece el mensaje de bienvenida de Docker, la instalación funciona correctamente.


## 4. Contenedor de MySQL

<span class="mi_h3">4.1. Crear contenedor y BD</span>

**1. Crear el contenedor**

```bash
docker run -d \
  --name mysql-srv \
  -e MYSQL_ROOT_PASSWORD=hola01 \
  -p 3306:3306 \
  mysql:8
```

Explicación de las opciones utilizadas

- `-d`: ejecuta el contenedor en segundo plano (*detached mode*).
- `--name`: asigna un nombre al contenedor.
- `-e`: define variables de entorno (en este caso, la contraseña del usuario root).
- `-p`: realiza el mapeo de puertos `host:contenedor`.

> **Nota:** En este ejemplo se utiliza la contraseña `hola01` porque es un entorno de pruebas. En entornos reales se recomienda utilizar contraseñas más robustas.



**2. Comprobar que el contenedor está funcionando**

Deberías ver un contenedor llamado `mysql-srv` en la lista:

```bash
docker ps -a
```



**3. Abrir una terminal dentro del contenedor**

```bash
docker exec -it mysql-srv bash
```

Si la imagen no dispone de `bash`, utiliza:

```bash
docker exec -it mysql-srv sh
```



**4. Conectarse a MySQL**

Introduce la contraseña configurada en el paso 1:

```bash
mysql -u root -p
```



**5. Consultar las bases de datos existentes**

```sql
SHOW DATABASES;
```



**6. Crear la base de datos**

```sql
CREATE DATABASE florabotanica;
```



**7. Seleccionar la base de datos**

```sql
USE florabotanica;
```



**8. Crear una tabla e insertar datos**

Crear la tabla

```sql
CREATE TABLE plantas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre TEXT NOT NULL,
    tipo TEXT NOT NULL,
    altura DOUBLE
);
```

Insertar registros

```sql
INSERT INTO plantas (nombre, tipo, altura)
VALUES ('Rosa', 'Flor', 1.2);
```

```sql
INSERT INTO plantas (nombre, tipo, altura)
VALUES ('Pino', 'Arbol', 7.2);
```



**9. Comprobar los datos**

```sql
SELECT * FROM plantas;
```



**10. Desconectarse de MySQL**

```sql
EXIT;
```



**11. Salir de la terminal del contenedor**

```bash
exit
```



<span class="mi_h3">4.2. Copiar la BD a otro contenedor</span>

Para llevar la base de datos a otro contenedor (por ejemplo, uno ubicado en otro equipo), es necesario exportarla desde el contenedor de origen e importarla en el contenedor de destino.



**1. Exportar la base de datos (dump) en el contenedor origen**

La siguiente instrucción generará un archivo llamado `florabotanica.sql` en el directorio actual del anfitrión.

> **Nota:** Se solicitará la contraseña del usuario root. Los caracteres introducidos no se mostrarán en pantalla.

```bash
docker exec -i mysql-srv mysqldump --no-tablespaces -u root -p florabotanica > florabotanica.sql
```

Para comprobar que se ha creado el archivo:

```bash
ls -l
```



**2. Copiar el archivo al contenedor destino**

Se asume que el contenedor de destino se llama `mysql-srv2`.

```bash
docker cp florabotanica.sql mysql-srv2:/tmp/florabotanica.sql
```

Para verificar que el archivo se ha copiado correctamente:

```bash
docker exec mysql-srv2 ls -l /tmp/florabotanica.sql
```



**3. Abrir una terminal dentro del segundo contenedor**

```bash
docker exec -it mysql-srv2 bash
```



**4. Conectarse a MySQL**

Introduce la contraseña del usuario root cuando se solicite:

```bash
mysql -u root -p
```



**5. Comprobar si la base de datos existe**

```sql
SHOW DATABASES;
```

Si no existe, créala:

```sql
CREATE DATABASE florabotanica;
```



**6. Restaurar la copia de seguridad**

Selecciona la base de datos:

```sql
USE florabotanica;
```

Importa el archivo SQL:

```sql
SOURCE /tmp/florabotanica.sql;
```



**7. Comprobar los datos**

```sql
SELECT * FROM plantas;
```




## 5. Contenedor de MongoDB



<span class="mi_h3">5.1. Crear contenedor y BD</span>



**1. Crear el contenedor**

```bash
docker run -d \
  --name mongo-srv \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=hola01 \
  -p 27017:27017 \
  mongo:6
```

**Explicación de las opciones utilizadas**

- **-d**: ejecuta el contenedor en segundo plano.
- **--name**: nombre del contenedor.
- **-e**: variables de entorno (usuario y contraseña root).
- **-p**: mapeo de puertos `host:contenedor`.

> **Nota:** En este ejemplo se utiliza la contraseña `hola01` porque es un entorno de pruebas. Utiliza contraseñas más robustas en entornos reales.



**2. Comprobar que el contenedor está funcionando**

Deberías ver un contenedor llamado `mongo-srv` en la lista:

```bash
docker ps -a
```



**3. Abrir una terminal dentro del contenedor**

```bash
docker exec -it mongo-srv bash
```

Si la imagen no dispone de `bash`, utiliza:

```bash
docker exec -it mongo-srv sh
```



**4. Conectarse a MongoDB**

Utiliza las credenciales definidas en el paso 1:

```bash
mongosh "mongodb://admin:hola01@127.0.0.1:27017/admin"
```



**5. Listar las bases de datos existentes**

```javascript
show dbs
```



**6. Crear y seleccionar la base de datos**

Ten en cuenta que MongoDB crea la base de datos cuando se insertan datos por primera vez.

```javascript
use florabotanica
```



**7. Crear una colección e insertar documentos**

```javascript
db.plantas.insertMany([
  { nombre: "Rosa", tipo: "Flor", altura: 1.2 },
  { nombre: "Pino", tipo: "Arbol", altura: 7.2 }
])
```



**8. Comprobar los datos**

```javascript
db.plantas.find().pretty()
```

---

**Ejemplos de consultas útiles**

**Contar documentos**

```javascript
db.plantas.countDocuments()
```

**Filtrar por tipo**

```javascript
db.plantas.find({ tipo: "Flor" }).pretty()
```

**Actualizar un documento (por ejemplo, cambiar la altura de Rosa)**

```javascript
db.plantas.updateOne(
  { nombre: "Rosa" },
  { $set: { altura: 1.3 } }
)
```

**Eliminar un documento**

```javascript
db.plantas.deleteOne({ nombre: "Pino" })
```


<span class="mi_h3">5.2. Copiar la BD a otro contenedor</span>


**1. Exporta la base de datos (dump) en el contenedor origen**
Se asume usuario y contraseña utilizados en la creación del contenedor.

Este comando crea un dump de la DB `florabotanica` y lo escribe en un directorio temporal dentro del contenedor:

```bash
docker exec mongo-srv sh -c 'mongodump --uri="mongodb://admin:hola01@127.0.0.1:27017/florabotanica?authSource=admin" --archive=/tmp/florabotanica.archive --gzip'
```

Este comando copia el fichero al host:

```bash
docker cp mongo-srv:/tmp/florabotanica.archive ./florabotanica.archive
```

Para comprobar que se ha creado el archivo ejecuta el comando `ls -l`.

**2. Copia el archivo al contenedor destino**
Se asume que el contenedor destino se llama `mongo-srv2`.

```bash
docker cp florabotanica.archive mongo-srv2:/tmp/florabotanica.archive
```

Comprueba dentro del contenedor destino:
```bash
docker exec mongo-srv2 ls -l /tmp/florabotanica.archive
```

**3. Abre shell dentro del contenedor destino**
```bash
docker exec -it mongo-srv2 bash
```

**4. Restaura la copia en el contenedor destino**
Restaura la DB `florabotanica` usando `mongorestore` (usa las credenciales root del destino). Esto importará la base de datos desde el archivo archivado y comprimido:

```bash
mongorestore --uri="mongodb://admin:hola01@127.0.0.1:27017" --archive=/tmp/florabotanica.archive --gzip --nsFrom="florabotanica.*" --nsTo="florabotanica.*"
```


**5. Comprueba las bases de datos y los datos**
Conéctate con `mongosh` (desde dentro del contenedor) y verifica:

```javascript
mongosh "mongodb://admin:hola01@127.0.0.1:27017/admin"
```


```javascript
show dbs
```


```javascript
use florabotanica
```


```javascript
db.plantas.find().pretty()
```

---

<span class="mi_h3">Autoría</span>

Obra realizada por Begoña Paterna Lluch. Publicada bajo licencia [Creative Commons Atribución/Reconocimiento-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/)

---