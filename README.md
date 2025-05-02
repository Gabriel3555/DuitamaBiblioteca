# DuitamaBiblioteca

## Descripción

**DuitamaBiblioteca** es una aplicación web desarrollada con Jakarta EE 11, orientada a la gestión de bibliotecas. Su objetivo es facilitar la administración de libros, usuarios y préstamos, digitalizando los procesos tradicionales y permitiendo un control eficiente de los recursos bibliotecarios.

---

## Características principales

- Gestión de libros: registro, consulta, actualización y eliminación.
- Administración de usuarios de la biblioteca.
- Control de préstamos y devoluciones.
- Interfaz web intuitiva (según implementación).
- Despliegue sencillo en servidores compatibles con Jakarta EE 11, como Tomcat 11.
- Contenedorización mediante Docker para facilitar el despliegue.

---

## Tecnologías utilizadas

- **Jakarta EE 11** (plataforma para aplicaciones empresariales Java)
- **Apache Tomcat 11** (servidor de aplicaciones compatible con Jakarta EE 11)
- **Maven** (gestión de dependencias y construcción)
- **Docker** (contenedorización y despliegue)
- **WAR** (Web Application Archive para despliegue en servidores)

---

## Estructura del proyecto

- `/src/main`: Código fuente principal de la aplicación.
- `/Dockerfile`: Archivo para construir la imagen Docker.
- `/ROOT.war`: Archivo WAR generado para despliegue.
- `/pom.xml`: Archivo de configuración de Maven.
- Archivos de soporte para ejecución y configuración.

---

## Instalación y ejecución local

1. Clona el repositorio:
git clone https://github.com/Gabriel3555/DuitamaBiblioteca.git

2. Construye el proyecto con Maven:
./mvnw clean package

3. Despliega el archivo `ROOT.war` generado en el directorio `target/` dentro del directorio `webapps` de tu instalación de Tomcat 11.
4. (Opcional) Para ejecutar con Docker:
- Construye la imagen:
  ```
  docker build -t duitama-biblioteca .
  ```
- Ejecuta el contenedor:
  ```
  docker run -p 8080:8080 duitama-biblioteca
  ```
5. Accede a la aplicación desde tu navegador en [http://localhost:8080](http://localhost:8080).

---

## Despliegue

El proyecto está preparado para desplegarse en cualquier servidor compatible con Jakarta EE 11, como Tomcat 11. También puede ejecutarse en un contenedor Docker para facilitar la portabilidad y el despliegue en diferentes entornos.

---

## Contribuciones

¡Las contribuciones son bienvenidas! Si deseas mejorar DuitamaBiblioteca, por favor abre un issue o un pull request.

---

## Licencia

Este proyecto se distribuye bajo una licencia de código abierto. Consulta el archivo `LICENSE` para más detalles.

---
