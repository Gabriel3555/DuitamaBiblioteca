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
