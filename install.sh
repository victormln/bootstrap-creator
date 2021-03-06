#!/bin/bash
# Hace una instalación del script

# Mensajes de color
ERROR='\033[0;31m'
BLUE='\033[0;34m'
OK='\033[0;32m'
NC='\033[0m'

# Creo un alias para que se pueda ejecutar el script
actualDir=$(pwd)
chmod +x bootstrap-creator.sh
echo "alias strap=\"$actualDir/bootstrap-creator.sh\"" >> ~/.bashrc
echo -e "${OK}[OK]${NC} Instalación finalizada."
echo -e "Reinicie este terminal y ejecute ${BLUE}strap -v${NC} para comprobar que se ha instalado correctamente."
exit
