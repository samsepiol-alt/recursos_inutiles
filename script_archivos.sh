#!/bin/bash

# Definir la estructura de directorios y archivos
declare -A structure=(
    ["dir1"]=""
    ["dir1/dir2"]=""
    ["dir1/dir2/dir3"]="file1.txt file2.txt"
    ["dir1/dir4"]="file3.txt"
)

# Crear directorios y archivos
for dir in "${!structure[@]}"; do
    # Verificar si el directorio existe
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "Directorio creado: $dir"
    else
        echo "Directorio ya existe: $dir"
    fi

    # Crear archivos dentro del directorio
    for file in ${structure[$dir]}; do
        if [ ! -f "$dir/$file" ]; then
            touch "$dir/$file"
            echo "Archivo creado: $dir/$file"
        else
            echo "Archivo ya existe: $dir/$file"
        fi
    done
done

# Mostrar la estructura usando tree
if command -v tree &> /dev/null; then
    tree
else
    echo "El comando 'tree' no está instalado. Instalando 'tree'..."
    # Intentar instalar tree si no está disponible
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y tree
    elif command -v yum &> /dev/null; then
        sudo yum install -y tree
    elif command -v pacman &> /dev/null; then
        sudo pacman -S tree
    else
        echo "No se pudo instalar 'tree'. Por favor, instálalo manualmente."
        exit 1
    fi
    tree
fi
