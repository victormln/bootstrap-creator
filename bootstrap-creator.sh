#!/bin/bash
# Fitxer: bootstrap-creator.sh
# Autor: Víctor Molina Ferreira (victor)
# Data: 17/01/2017
# Versión: 1.0

#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

#  Descripción: Subida de los cambios a un repositorio git (ejecutar el script donde se tenga el .git)

#####################
# Colores de los mensajes
ERROR='\033[0;31m'
OK='\033[0;32m'
WARNING='\033[1;33m'
NC='\033[0m'


# Cogemos los datos del archivo .conf
source $( dirname "${BASH_SOURCE[0]}" )/user.conf

# Si están activadas las actualizaciones automáticas
# Doy permiso al update.sh
chmod +x $( dirname "${BASH_SOURCE[0]}" )/update.sh
# Comprobaré si hay alguna versión nueva del programa autopush
# y lo mostraré en pantalla
source $( dirname "${BASH_SOURCE[0]}" )/update.sh

directorio_actual=$(pwd)

# Hacer con array associativo
function parseOption {
  if [ -z $1 ]
  then
    copyBootstrap
  else
    if [ "$1" == "--title" ]
    then

    elif [ "$1" == "--cdn" ]
    then

    elif [ "$1" == "--" ]
    then

    fi
  fi
}
