# Usa una imagen base de Tomcat 11 con JDK 17
FROM tomcat:11-jdk17

# Establece el directorio de trabajo
WORKDIR /usr/local/tomcat

# Copia tu archivo WAR al directorio webapps de Tomcat
COPY ROOT.war /usr/local/tomcat/webapps/

# Expone el puerto 8080 para acceder a la aplicación
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["catalina.sh", "run"]