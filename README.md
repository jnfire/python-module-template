# Plantilla para Módulo de Python

Este proyecto es una plantilla para crear un módulo de Python instalable. Proporciona una estructura de proyecto básica, gestión de dependencias y configuración para empaquetado.

## Cómo Empezar

Sigue estos pasos para usar esta plantilla y empezar tu propio módulo.

### 1. Clonar el Repositorio

Clona este repositorio en tu máquina local con el nombre que desees para tu nuevo proyecto:

```bash
git clone https://github.com/usuario/plantilla-python.git mi-nuevo-modulo
cd mi-nuevo-modulo
```

### 2. Renombrar el Módulo

El código fuente principal se encuentra en la carpeta `module_name`. Debes renombrarla para que coincida con el nombre de tu paquete Python.

```bash
mv module_name mi_paquete
```

### 3. Actualizar los Metadatos del Paquete

Abre el archivo `mi_paquete/__init__.py` y edita los siguientes campos con tu información:

```python
# mi_paquete/__init__.py

__author__ = "Tu Nombre"
__email__ = "tu_email@dominio.com"
__version__ = "0.0.1"  # O la versión inicial que prefieras

PACKAGE_NAME = "mi_paquete" # Asegúrate que coincida con el nuevo nombre de la carpeta
```

El archivo `setup.py` leerá esta información automáticamente.

### 4. Actualizar la Configuración de Versión

El archivo `setup.cfg` se usa para automatizar el versionado con `bumpversion`. Asegúrate de que la ruta apunte a tu nuevo directorio de paquete.

**Si renombraste `module_name` a `mi_paquete`**, actualiza `setup.cfg` así:

```ini
[bumpversion:file:mi_paquete/__init__.py]
search = __version__ = "{current_version}"
replace = __version__ = "{new_version}"
```

### 5. Elegir una Licencia

Este proyecto incluye por defecto la licencia "The Unlicense" (ver archivo `LICENSE`), que dedica el software al dominio público.

**Importante:** Debes revisar y, si es necesario, reemplazar el contenido del archivo `LICENSE` con la licencia que mejor se adapte a tu proyecto (MIT, GPL, Apache, etc.).

### 6. Instalar Dependencias

Instala las dependencias de desarrollo y del proyecto:

```bash
pip install -r requirements_dev.txt
pip install -r requirements.txt
```

Luego, instala tu paquete en modo editable. Esto te permitirá probar tus cambios localmente de forma inmediata.

```bash
pip install -e .
```

### 7. ¡A Programar!

¡Listo! Ya puedes empezar a desarrollar tu módulo. Añade tu código dentro de la carpeta `mi_paquete` y crea pruebas en la carpeta `tests`.

## Estructura del Proyecto

```
.
├── LICENSE           # Archivo de licencia (¡Debes editarlo!)
├── README.md         # La documentación que estás leyendo
├── requirements.txt  # Dependencias del módulo
├── requirements_dev.txt # Dependencias de desarrollo (testing, etc.)
├── setup.cfg         # Configuración para `bumpversion`
├── setup.py          # Script de empaquetado (usa setuptools)
├── VERSION.txt       # Archivo con la versión actual
├── mi_paquete/       # El código fuente de tu paquete
│   ├── __init__.py   # Metadatos e inicialización del paquete
│   └── main.py       # Un punto de entrada de ejemplo
└── tests/            # Pruebas para tu módulo
    └── __init__.py
```

## Versionado

Para gestionar la versión de tu paquete, puedes usar `bumpversion`. Por ejemplo, para pasar de `0.0.1` a `0.1.0`:

```bash
bumpversion minor
```

Este comando actualizará automáticamente la versión en `VERSION.txt` y en `mi_paquete/__init__.py`.