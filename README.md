# Bootstrap-creator

Hay ocasiones que estamos creando constantemente proyectos con bootstrap y no queremos tener bower o parecidos para instalar un simple bootstrap. Con este script podremos crear una página .html con boostrap integrado (archivos css y js incluidos). Además podemos escoger por parámetros si queremos que nuestro .html apunte a los archivos bootstrap CDN o a los archivos locales.
También podemos crear simplemente un .html con una plantilla básica de bootstrap (en el caso que ya tengamos los archivos bootstrap)

Ejemplo para ejecutar el script
```shell
strap proyecto/test --title "Hola mundo"
```

## Instalación

La instalación es muy básica, añade un alias a tu .bashrc

```shell
git clone https://github.com/victormln/bootstrap-creator.git
cd bootstrap-creator
./install.sh
```

## Configuración

Se pueden configurar varios parámetros. Por ejemplo que no busque actualizaciones automáticas, modificar el editor con el que se abrirá tu proyecto creado y otras configuraciones. Si se abre el archivo **user.conf** se podrán acceder a todas las configuraciones.

## Uso / Ejemplos

Este script se puede ejecutar de varias maneras, una de ellas (la más simple):
```shell
strap proyecto/test
```

Esto te creará en el directorio actual, una carpeta llamada proyecto y dentro otra llamada test.

La estructura de archivos que te quedaría sería una así:

![alt tag](https://s29.postimg.org/ac9ua0qbr/directorios.png)

Otro ejemplo: si quiero crear el proyecto Testing con el titulo del index.html "Hola mundo" y que tenga los links de css y js de CDN, haré:

```shell
strap Testing --title "Hola mundo" --cdn
```

Y el encabezado del index.html quedaría así:

![alt tag](https://s27.postimg.org/a6yezywpf/head.png)

## Todos los argumentos disponibles

|Argumento           |Abreviado|Significado                                   |Uso|
| ------------- | ---- | ---------------------------------------- |----------|
|`nombreProyecto/testing`       |     | Se creará la carpeta nombreProyecto y dentro la carpeta testing que contiene un .html y los archivos bootstrap (css y js)        |`strap nombreProyecto/testing`  |
|`-file`     |  | Creará tan solo un archivo con los links a los css y js de Bootstrap (no creará ni una carpeta, ni te pondrá los archivos css/js).  |`strap -file test.html`      |
|`--conf`     |  | Abre/edita el archivo de configuración del script  |`strap --conf`      |
|`--cdn`     |  | Usará los links a los css y js de CDN.  |`gp proyecto --cdn`      |
|`--title`     |  | Puedes escoger que título tendrá tu página (lo que irá dentro del tag html <title>.  |`strap proyecto --title "Hola mundo"`      |
|     |`-v`  | Muestra la versión instalada del script.  |`gp -v`      |
|`--help`     | `-h` | Muestra que comandos puedes ejecutar con el script y una breve descripción de ellos  |`strap --help`      |
