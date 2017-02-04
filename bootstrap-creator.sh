#!/bin/bash
# Fitxer: bootstrap-creator.sh
# Autor: Víctor Molina Ferreira (victor)
# Data: 17/01/2017
# Versión: 1.1

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

# Mensajes de color
ERROR='\033[0;31m'
OK='\033[0;32m'
WARNING='\033[1;33m'
NC='\033[0m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
ORANGE='\033[0;33m'
CYAN='\033[0;36m'

CURRENTVERSION=$(grep '# Versión:' $0 | cut -d: -f 2 | head -1)
CURRENTVERSION=${CURRENTVERSION//[[:blank:]]/}

# Cogemos los datos del archivo .conf
source $( dirname "${BASH_SOURCE[0]}" )/user.conf

# Si están activadas las actualizaciones automáticas
# Doy permiso al update.sh
chmod +x $( dirname "${BASH_SOURCE[0]}" )/update.sh
# Comprobaré si hay alguna versión nueva del programa autopush
# y lo mostraré en pantalla
#source $( dirname "${BASH_SOURCE[0]}" )/update.sh

function showHelp {
  echo -e "usage: bootstrap-creator name_of_project [--title] [--cdn] - Script que te permite poner un bootstrap los archivos necesarios para tener un bootstrap en un solo comando."

  echo -e "\n${CYAN}name_of_project${NC}"
  echo -e "\tEs donde se guardará el bootstrap. Este parámetro es de uso obligatorio."
  echo -e "\tTambién puedes añadir una ruta."

  echo -e "\n${CYAN}[--title] nombre_del_title${NC}"
  echo -e "\tSi pones este parámetro seguido de un nombre de título, te pondrá ese título entre los tags <title> del html"
  echo -e "\tSi no pones este parámetro, el tag <title> estará vacío."

  echo -e "\n${CYAN}[--cdn]${NC}"
  echo -e "\tSi pones este parámetro, en vez de los archivos locales de css y js, tendrás un enlace a los archivos en CDN"
  echo -e "\tSi no pones este parámetro, se te pondrán los archivos de bootstrap localmente."

  echo -e "\n${CYAN}[-file] [-f]${NC}"
  echo -e "\tSi pones este parámetro te creará en el directorio actual, un archivo con el nombre que le pases"

}

# Hacer con array associativo
function parseOption {
  if [ -z $1 ]
  then
    echo -e "${ERROR}[ERROR] ${NC}Por favor, mínimo tiene que poner un parámetro."
    echo "Puedes ver la ayuda del scrip con --help"
  else
    if [ "$1" == "--help" ] || [ "$1" == "-h" ]
    then
      showHelp
    elif [ "$1" == "-file" ] || [ "$1" == "-f" ]
    then
      createFile $2
      echo -e "${OK}[OK] ${NC}Se ha creado el archivo $2 correctamente."
    elif [ "$1" == "-v" ]
    then
        echo $CURRENTVERSION
    elif [ "$1" == "--conf" ]
    then
      echo -e "Abriendo archivo de configuración."
      $default_editor $( dirname "${BASH_SOURCE[0]}" )/user.conf
      exit 0
    else
      fileName="index"
      if [ "$2" == "--title" ]
      then
        parseTitle $2 $3
      elif [ "$1" == "--title" ]
      then
        parseTitle $1 $2
      elif [ "$3" == "--title" ]
      then
        parseTitle $3 $4
      fi
      mkdir -p $1
      cp $( dirname "${BASH_SOURCE[0]}" )/bootstrap-files/template.html $1/$fileName.html
      fillTemplate $1 $fileName
      copyDate $1
      echo -e "${OK}[OK] ${NC}Se ha creado tu proyecto $1 correctamente."
      if $open_editor
      then
        if command -v $text_editor $1 >/dev/null 2>&1
        then
          $text_editor $1 &
        else
          echo -e "${ERROR}[ERROR] ${NC}Por favor, ponga un editor que suela usar en el archivo user.conf."
          echo "Por ejemplo: text_editor=atom"
          echo "Se va a abrir por defecto el index.html creado con gedit"
          gedit $1/$fileName.html &
        fi
      fi
    fi
  fi
}

function createFile {
  cp $( dirname "${BASH_SOURCE[0]}" )/bootstrap-files/template_with_css_js.html $1
  #
  if [ -z $title ]
  then
    sed -i 's/<titulo>//g'  $1
  else
    sed -i "s/<titulo>/$title/g" $1
  fi
}

function fillTemplate {
  if $cdn
  then
    sed "/<\/title>/ r $( dirname "${BASH_SOURCE[0]}" )/bootstrap-files/header_cdn.html" $1/index.html > $1/tmp.html
    mv $1/tmp.html $1/$2.html
  else
    sed "/<\/title>/ r $( dirname "${BASH_SOURCE[0]}" )/bootstrap-files/header_local.html" $1/index.html > $1/tmp.html
    mv $1/tmp.html $1/$2.html
  fi
  #
  if [ -z $title ]
  then
    sed -i 's/<titulo>//g'  $1/$2.html
  else
    sed -i "s/<titulo>/$title/g" $1/$2.html
  fi
}

function copyDate {
  cp -R $( dirname "${BASH_SOURCE[0]}" )/bootstrap-files/$version_bootstrap/* $1
}

# Dados dos argumentos --title y "Nombre del <title>"
function parseTitle {
  if [ "$1" == "--title" ]
  then
    project_name=$(echo "$2" | grep "^--")
    if [ -z $project_name ]
    then
      title=$2
    else
      echo -e "${ERROR}[ERROR] ${NC}Por favor, si pone el parámetro --title, le hará falta poner el título de la página."
      echo "Si no quiere ningún title por defecto, no ponga el parámetro --title"
      echo "Uso: --title \"Titulo del <title>\""
      exit
    fi
  fi
}

function cdn {
  for var in "$@"
  do
    if [ "$var" == "--cdn" ]
    then
      cdn=true
    fi
  done
}
IFS=''
directorio_actual=$(pwd)
title=""
cdn $*
parseOption $*
