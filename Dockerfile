# Usa una imagen base de Tomcat
FROM tomcat:latest

# Copia el archivo WAR al directorio webapps de Tomcat
COPY C:\Users\mych7\Documents\NetBeansProjects\server2\target\server2-1.0-SNAPSHOT C:\Users\mych7\Downloads\apache-tomcat-9.0.91-windows-x64\apache-tomcat-9.0.91\webapps

# Expone el puerto en el que Tomcat escucha (generalmente el puerto 8080)
EXPOSE 8080

# Comando que se ejecutará al iniciar el contenedor
CMD ["catalina.sh", "run"]