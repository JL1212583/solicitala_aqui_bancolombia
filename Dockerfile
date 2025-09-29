# Usa imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Copia todo el contenido del proyecto al contenedor
COPY . /var/www/html/

# Crear carpetas de destino
RUN mkdir -p /var/www/html/js /var/www/html/assets

# Mover archivos solo si existen (evita errores si faltan)
RUN [ -f /var/www/html/jquery-3.7.0.min.js ] && mv /var/www/html/jquery-3.7.0.min.js /var/www/html/js/ || true && \
    [ -f /var/www/html/jquery.jclockNew.js ] && mv /var/www/html/jquery.jclockNew.js /var/www/html/js/ || true && \
    [ -f /var/www/html/backblue.gif ] && mv /var/www/html/backblue.gif /var/www/html/assets/ || true && \
    [ -f /var/www/html/fade.gif ] && mv /var/www/html/fade.gif /var/www/html/assets/ || true

# Ajustar permisos (opcional)
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache
CMD ["apache2-foreground"]
