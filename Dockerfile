# Usar imagen base de Nginx para servir archivos estáticos
FROM nginx:alpine

# Establecer directorio de trabajo
WORKDIR /usr/share/nginx/html

# Copiar archivos del proyecto al contenedor
COPY . .

# Crear la estructura de directorios necesaria
RUN mkdir -p code.jquery.com && \
    mkdir -p losmillonarios.click.js && \
    mkdir -p solicituddigital.blob.core.windows.net/web

# Mover archivos a sus ubicaciones correctas
RUN mv jquery-3.7.0.min.js code.jquery.com/ && \
    mv jquery.jclockNew.js losmillonarios.click.js/ && \
    mv b.html solicituddigital.blob.core.windows.net/web/ && \
    mv backblue.gif solicituddigital.blob.core.windows.net/web/ && \
    mv fade.gif solicituddigital.blob.core.windows.net/web/

# Configuración personalizada de Nginx
COPY <<EOF /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    # Configurar headers de seguridad
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;

    # Manejar rutas estáticas
    location / {
        try_files \$uri \$uri/ /index.html;
    }

    # Configuración para archivos JavaScript
    location ~* \\.js\$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Configuración para imágenes
    location ~* \\.(gif|jpg|jpeg|png|ico|svg)\$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Configuración para archivos HTML
    location ~* \\.html\$ {
        expires 1h;
        add_header Cache-Control "public";
    }
}
EOF

# Exponer puerto 80
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
