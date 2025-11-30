# Plantilla Moderna para Módulo de Python (src layout + pytest)

Este proyecto es una plantilla de última generación para crear un módulo de Python instalable. Incorpora las mejores prácticas de la comunidad, incluyendo:

-   **`pyproject.toml`**: Como único archivo de configuración (PEP 621).
-   **Estructura `src`**: Para evitar errores de importación y asegurar tests robustos.
-   **`pytest`**: Para escribir tests de forma simple y potente.
-   **`ruff` y `black`**: Para calidad y formato de código automatizado.
-   **`Makefile`**: Para simplificar las tareas más comunes.

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
└── README.md
```

La ventaja de la estructura `src` es que te obliga a instalar el paquete para probarlo, asegurando que los tests se ejecutan en las mismas condiciones que tendrá el usuario final.

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

Este comando crea un entorno virtual, instala `pytest`, `ruff`, etc., y tu paquete en **modo editable** (`-e`).

---

## Testing con `pytest`

`pytest` es el estándar de facto para testing en Python por su simplicidad y potencia.

**Escribir Tests:**
Simplemente crea funciones que empiecen con `test_` y usa `assert` para comprobar los resultados.

```python
# tests/test_main.py
from module_name.main import greet

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
