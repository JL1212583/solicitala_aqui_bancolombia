# Usar imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instalar extensiones necesarias, por ejemplo para bases de datos
RUN docker-php-ext-install pdo pdo_mysql

# Copiar todo el proyecto al directorio de Apache
COPY . /var/www/html/

# Crear carpetas y mover archivos para organizarlos
RUN mkdir -p /var/www/html/js \
    && mkdir -p /var/www/html/assets \
    && mv /var/www/html/jquery-3.7.0.min.js /var/www/html/js/ \
    && mv /var/www/html/jquery.jclockNew.js /var/www/html/js/ \
    && mv /var/www/html/backblue.gif /var/www/html/assets/ \
    && mv /var/www/html/fade.gif /var/www/html/assets/

# Ajustar permisos para que Apache pueda leer los archivos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Exponer puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["apache2-foreground"]
