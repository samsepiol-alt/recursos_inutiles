#!/bin/bash
#primera version de script para instalar django rapido
# Nombre del proyecto y aplicación
PROJECT_NAME="mi_proyecto"
APP_NAME="mi_aplicacion"

# Verificar si Python 3 está instalado
if ! command -v python3 &> /dev/null; then
    echo "Python 3 no está instalado. Instalando Python 3..."
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
fi

# Verificar si virtualenv está instalado
if ! command -v virtualenv &> /dev/null; then
    echo "virtualenv no está instalado. Instalando virtualenv..."
    pip3 install virtualenv
fi

# Crear y activar un entorno virtual
echo "Creando y activando un entorno virtual..."
virtualenv venv
source venv/bin/activate

# Instalar Django
echo "Instalando Django..."
pip install django

# Crear un nuevo proyecto de Django
echo "Creando un nuevo proyecto de Django..."
django-admin startproject $PROJECT_NAME

cd $PROJECT_NAME

# Crear una nueva aplicación dentro del proyecto
echo "Creando una nueva aplicación de Django..."
python manage.py startapp $APP_NAME

# Configurar la aplicación en settings.py
SETTINGS_FILE="$PROJECT_NAME/settings.py"
echo "Configurando la aplicación en settings.py..."
sed -i "s/INSTALLED_APPS = \[/INSTALLED_APPS = \[\n    '$APP_NAME',/" $SETTINGS_FILE

# Crear una vista simple en views.py
echo "Creando una vista simple en views.py..."
VIEWS_FILE="$APP_NAME/views.py"
cat <<EOL > $VIEWS_FILE
from django.http import HttpResponse

def home(request):
    return HttpResponse("¡Hola, mundo!")
EOL

# Configurar la URL para la vista
echo "Configurando la URL para la vista..."
URLS_FILE="$APP_NAME/urls.py"
cat <<EOL > $URLS_FILE
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
]
EOL

# Incluir las URLs de la aplicación en el proyecto
echo "Incluyendo las URLs de la aplicación en el proyecto..."
PROJECT_URLS_FILE="$PROJECT_NAME/urls.py"
sed -i "s/from django.urls import path/from django.urls import path, include/" $PROJECT_URLS_FILE
sed -i "s/urlpatterns = \[/urlpatterns = \[\n    path('', include('$APP_NAME.urls')),\n/" $PROJECT_URLS_FILE

# Configurar las variables de entorno (ejemplo)
echo "Configurando variables de entorno..."
echo "export DJANGO_SECRET_KEY='reemplaza_esto_con_tu_llave_secreta'" >> ~/.bashrc
source ~/.bashrc

# Migrar la base de datos y ejecutar el servidor
echo "Migrando la base de datos..."
python manage.py migrate

echo "Ejecutando el servidor de desarrollo..."
python manage.py runserver

echo "Instalación y configuración de Django completadas. Visita http://127.0.0.1:8000 para ver tu sitio."
