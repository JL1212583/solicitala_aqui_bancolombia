# Copia todos los archivos al contenedor
COPY . /var/www/html/

# Crear carpetas y organizar los archivos
RUN mkdir -p /var/www/html/js \
    && mkdir -p /var/www/html/assets \
    && mv /var/www/html/jquery-3.7.0.min.js /var/www/html/js/ \
    && mv /var/www/html/jquery.jclockNew.js /var/www/html/js/ \
    && mv /var/www/html/backblue.gif /var/www/html/assets/ \
    && mv /var/www/html/fade.gif /var/www/html/assets/

