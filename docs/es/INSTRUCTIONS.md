# Guía de Uso de la Plantilla de Módulo de Python

Este proyecto es una plantilla de última generación para crear un módulo de Python instalable. Incorpora las mejores prácticas de la comunidad, incluyendo:

-   **`pyproject.toml`**: Como único archivo de configuración (PEP 621).
-   **Estructura `src`**: Para evitar errores de importación y asegurar tests robustos.
-   **`pytest`**: Para escribir tests de forma simple y potente.
-   **`ruff` y `black`**: Para calidad y formato de código automatizado.
-   **`Makefile`**: Para simplificar las tareas más comunes.
-   **`pre-commit`**: Para asegurar la calidad del código antes de cada commit.

## Estructura del Proyecto (`src` layout)

```
mi-proyecto/
├── src/
│   └── mi_paquete/         <-- El código fuente de tu paquete vive aquí
│       ├── __init__.py
│       └── main.py
├── tests/                  <-- Tests para tu paquete
│   └── test_main.py
├── .gitignore
├── LICENSE
├── Makefile                <-- Atajos para tareas comunes
├── pyproject.toml          <-- ¡El único archivo de configuración que necesitas!
├── .pre-commit-config.yaml <-- Configuración de los hooks de pre-commit
└── README.md
```

La ventaja de la estructura `src` es que te obliga a instalar el paquete para probarlo, asegurando que los tests se ejecutan en las mismas condiciones que tendrá el usuario final.

### El Rol de `__init__.py`: Exponiendo tu API

El archivo `src/mi_paquete/__init__.py` no solo define el directorio como un paquete de Python, sino que también te permite crear una API pública limpia para tu módulo.

Por ejemplo, en lugar de que los usuarios tengan que importar funciones desde la estructura interna de tu proyecto, así:

```python
# Menos ideal, acopla al usuario a tu estructura interna
from mi_paquete.main import greet
```

Puedes exponer la función `greet` directamente en el `__init__.py`:

```python
# src/mi_paquete/__init__.py
"""Top-level package for mi_paquete."""

from .main import greet

__all__ = ["greet"]
```

De esta forma, el usuario final puede importar `greet` de una manera mucho más limpia e intuitiva:

```python
# Ideal, la API es más limpia y desacoplada de la estructura
from mi_paquete import greet
```

Esta plantilla ya viene configurada con este patrón para la función `greet` de ejemplo. ¡Aprovéchalo para ofrecer una gran experiencia a los usuarios de tu módulo!

## Cómo Empezar

### 1. Renombrar el Módulo

El código fuente se encuentra en `src/module_name`. Renómbralo para que coincida con el nombre de tu paquete.

```bash
mv src/module_name src/mi_paquete
```

### 2. Configurar `pyproject.toml`

Este archivo es el centro de control. Ábrelo y edita la sección `[project]`:

```toml
[project]
name = "mi_paquete" # <-- ¡Muy importante! Debe coincidir con el nombre de la carpeta.
version = "0.0.1"
authors = [
  { name="Tu Nombre", email="tu_email@dominio.com" },
]
description = "Una descripción genial de mi paquete."
```
Este archivo también gestiona las dependencias de tu proyecto y las de desarrollo.

### 3. Instalar el Entorno de Desarrollo

Usa el `Makefile` para preparar tu entorno:

```bash
make install
```

Este comando crea un entorno virtual, instala `pytest`, `ruff`, `pre-commit`, etc., y tu paquete en **modo editable** (`-e`). Además, **instala los hooks de pre-commit automáticamente**.

---

## Testing con `pytest`

`pytest` es el estándar de facto para testing en Python por su simplicidad y potencia.

**Escribir Tests:**
Simplemente crea funciones que empiecen con `test_` y usa `assert` para comprobar los resultados.

```python
# tests/test_main.py
from mi_paquete.main import greet # Asegúrate de usar el nombre de tu paquete

def test_greet_with_name():
    """Prueba que la función saluda por nombre."""
    assert greet("Javi") == "Hello, Javi"
```

**Ejecutar Tests:**
Usa el atajo del `Makefile`:
```bash
make test
```
O ejecuta `pytest` directamente:
```bash
pytest
```

---

## Tareas Comunes con `Makefile`

Usa `make help` para ver todos los comandos.

-   `make install`: Instala el entorno de desarrollo.
-   `make test`: Ejecuta las pruebas con `pytest`.
-   `make lint`: Revisa el código con `ruff`.
-   `make format`: Formatea el código con `ruff` y `black`.
-   `make build`: Construye el paquete para su distribución.
-   `make publish-test`: Publica el paquete en TestPyPI.
-   `make publish`: Publica el paquete en PyPI.
-   `make clean`: Elimina todos los archivos generados.

---

## Asegurando la Calidad del Código con `pre-commit`

`pre-commit` es una herramienta para instalar y gestionar ganchos de Git que se ejecutan automáticamente antes de cada `commit`.

**¿Cómo funciona?**
Una vez instalado (con `make install`), cada vez que intentes hacer un `git commit`, `pre-commit` ejecutará automáticamente las herramientas de calidad de código configuradas (`ruff` para linting y `black` para formateo).

*   Si `ruff` encuentra errores de linting, te avisará y el commit fallará hasta que los corrijas.
*   Si `black` reformatea tu código, el commit fallará, pero tu código ya estará formateado. Simplemente necesitas hacer un `git add .` de los cambios formateados y volver a intentar el `commit`.

Esto asegura que todo el código en tu repositorio siempre cumple con los estándares de calidad y estilo definidos.

**Configuración:**
La configuración de los hooks se encuentra en el archivo `.pre-commit-config.yaml`.

---

## Versionado Semántico con `bump-my-version`

El versionado (`MAYOR.MENOR.PARCHE`) se gestiona con `bump-my-version`, el sucesor moderno de `bumpversion`. Está configurado para actualizar la versión directamente en `pyproject.toml` y `VERSION.txt`.

**Buena práctica:** Antes de subir la versión, asegúrate de que todos tus cambios están en `git`.

```bash
# Sube un parche (e.g., de 0.0.1 a 0.0.2)
bump-my-version patch

# Sube una versión menor (e.g., de 0.0.2 a 0.1.0)
bump-my-version minor
```

---

## Empaquetado y Distribución

El flujo de trabajo moderno utiliza el paquete `build`.

### 1. Construir el Paquete

Usa el comando del Makefile:
```bash
make build
```
O el comando directo:
```bash
python -m build
```
Esto genera los archivos de distribución (`.whl` y `.tar.gz`) en la carpeta `dist/`.

### 2. Instalación Local desde el Artefacto

Si quieres instalar tu paquete localmente para probar el artefacto final antes de publicarlo, puedes usar el archivo `.whl` generado. Esto es útil para probar la instalación real del paquete en un entorno limpio.

```bash
# Asegúrate de activar tu entorno virtual si estás usando uno.
pip install dist/tu_paquete-0.0.1-py3-none-any.whl
```
**Nota:** Reemplaza `tu_paquete-0.0.1-py3-none-any.whl` con el nombre exacto del archivo `.whl` generado en tu carpeta `dist/`.

### 3. Publicar en PyPI

El `Makefile` también simplifica la publicación.

**Buena práctica:** Publica primero en el entorno de pruebas.
```bash
make publish-test
```

Cuando todo esté correcto, publica en el repositorio oficial:
```bash
make publish
```

Estos comandos usan `twine` para subir de forma segura los artefactos de la carpeta `dist/`.

---

## Próximos Pasos: Haz Tuyo el Proyecto

Una vez que hayas configurado y probado la plantilla, es hora de hacerla tuya. Aquí hay algunos pasos para limpiar el contenido de ejemplo y empezar con tu propio código:

1.  **Elimina el código de ejemplo (`src/mi_paquete/main.py`):**
    *   La función `greet()` y el punto de entrada `main()` son solo ejemplos. Bórralos y empieza a escribir la funcionalidad real de tu módulo.

2.  **Borra los tests de ejemplo (`tests/test_main.py`):**
    *   Este archivo contiene tests para la función `greet()`. Borra este archivo o vacía su contenido para empezar a escribir tus propios tests.

3.  **Actualiza tu registro de cambios (`CHANGELOG.md`):**
    *   El archivo `CHANGELOG.md` está vacío, listo para que añadas tu primera entrada.
    *   Puedes empezar con algo como: `0.0.1 - YYYY-MM-DD: Initial project setup from template.`

4.  **Revisa la licencia (`LICENSE`):**
    *   Aunque ya lo mencionamos, asegúrate de que el archivo `LICENSE` contenga la licencia final que deseas usar para tu proyecto.
