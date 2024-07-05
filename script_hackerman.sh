#!/bin/bash
#lindo script para que piensen que podemos jakiar todo lo que se puede jakiar jajaja
# Comandos sin sudo
commands=(
    "apt update"
    "ps aux"
    "top"
    "find / -name \"*.conf\""
    "netstat -tuln"
    "ifconfig"
    "tail -f /var/log/syslog"
    "df -h"
)

# Colores
colors=(
    "31"  # Red
    "32"  # Green
    "34"  # Blue
    "33"  # Yellow
    "36"  # Cyan
    "35"  # Magenta
)

# Función para abrir una nueva terminal y ejecutar el comando
open_terminal() {
    local cmd=$1
    local color=$2
    x-terminal-emulator -e bash -c "echo -e \"\e[1;${color}m\"; $cmd; echo -e \"\e[0m\"; echo 'Press any key to exit'; read -n 1; exec bash"
}

# Iterar sobre los comandos y colores para abrir nuevas terminales
for i in "${!commands[@]}"; do
    cmd=${commands[$i]}
    color_code=${colors[$i % ${#colors[@]}]}
    open_terminal "$cmd" "$color_code"
done

echo "Disfruta de la experiencia"