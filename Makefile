# Makefile for Python Module Template (Modern)

.PHONY: help install clean test lint format build

# Colores para la salida
GREEN := \033[0;32m
RESET := \033[0m

# ====================================================================================
# AYUDA
# ====================================================================================

help:
	@echo "Comandos disponibles:"
	@echo "  ${GREEN}install${RESET}  -> Crea venv e instala dependencias de desarrollo."
	@echo "  ${GREEN}test${RESET}     -> Ejecuta las pruebas con unittest."
	@echo "  ${GREEN}lint${RESET}     -> Revisa el estilo y los errores del código con ruff."
	@echo "  ${GREEN}format${RESET}   -> Formatea el código con ruff y black."
	@echo "  ${GREEN}build${RESET}    -> Construye el paquete (wheel y sdist) usando 'build'."
	@echo "  ${GREEN}publish-test${RESET} -> Publica el paquete en TestPyPI."
	@echo "  ${GREEN}publish${RESET}  -> Publica el paquete en PyPI."
	@echo "  ${GREEN}clean${RESET}    -> Elimina los artefactos de construcción y cachés."


# ====================================================================================
# GESTIÓN DE ENTORNO Y DEPENDENCIAS
# ====================================================================================

# Comprobación del sistema operativo para la activación del venv
ifeq ($(OS),Windows_NT)
    VENV_ACTIVATE = .\.venv\Scripts\activate
else
    VENV_ACTIVATE = source .venv/bin/activate
endif

.venv/touchfile:
	python -m venv .venv
	touch .venv/touchfile

install: .venv/touchfile
	@echo "Instalando dependencias de desarrollo y el paquete en modo editable..."
	@$(VENV_ACTIVATE) && pip install --upgrade pip && pip install -e .[dev]


# ====================================================================================
# CALIDAD DE CÓDIGO Y TESTING
# ====================================================================================

test:
	@echo "Ejecutando tests con pytest..."
	pytest

lint:
	@echo "Revisando el código con ruff..."
	ruff check .

format:
	@echo "Formateando el código con ruff y black..."
	ruff format .
	black .


# ====================================================================================
# CONSTRUCCIÓN Y PUBLICACIÓN
# ====================================================================================

build:
	@echo "Construyendo el paquete con 'build'..."
	python -m build

publish-test: build
	@echo "Publicando en TestPyPI..."
	twine upload --repository testpypi dist/*

publish: build
	@echo "Publicando en PyPI..."
	twine upload dist/*


# ====================================================================================
# LIMPIEZA
# ====================================================================================

clean:
	@echo "Limpiando artefactos..."
	rm -rf build dist *.egg-info .pytest_cache .mypy_cache .coverage __pycache__ .venv
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	@echo "Limpieza completada."