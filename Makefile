# Makefile for Python Module Template

.PHONY: help install clean test lint format build

# Shell colors
GREEN  := \033[0;32m
RESET  := \033[0m

# ====================================================================================
# HELP
# ====================================================================================

help:
	@echo "Available commands:"
	@echo "  ${GREEN}install${RESET}       -> Creates venv and installs development dependencies."
	@echo "  ${GREEN}test${RESET}          -> Runs tests with pytest."
	@echo "  ${GREEN}lint${RESET}          -> Checks code style and errors with ruff."
	@echo "  ${GREEN}format${RESET}        -> Formats code with ruff and black."
	@echo "  ${GREEN}build${RESET}         -> Builds the package (wheel and sdist) using 'build'."
	@echo "  ${GREEN}publish-test${RESET}  -> Publishes the package to TestPyPI."
	@echo "  ${GREEN}publish${RESET}       -> Publishes the package to PyPI."
	@echo "  ${GREEN}clean${RESET}         -> Removes all build artifacts and caches."


# ====================================================================================
# ENVIRONMENT AND DEPENDENCY MANAGEMENT
# ====================================================================================

# OS check for venv activation
ifeq ($(OS),Windows_NT)
    VENV_ACTIVATE = .\.venv\Scripts\activate
else
    VENV_ACTIVATE = source .venv/bin/activate
endif

.venv/touchfile:
	python -m venv .venv
	touch .venv/touchfile

install: .venv/touchfile
	@echo "Installing development dependencies and the package in editable mode..."
	@$(VENV_ACTIVATE) && pip install --upgrade pip && pip install -e .[dev]
	@echo "Setting up pre-commit hooks..."
	@$(VENV_ACTIVATE) && pre-commit install


# ====================================================================================
# CODE QUALITY AND TESTING
# ====================================================================================

test:
	@echo "Running tests with pytest..."
	pytest

lint:
	@echo "Checking code with ruff..."
	ruff check .

format:
	@echo "Formatting code with ruff and black..."
	ruff format .
	black .


# ====================================================================================
# BUILD AND PUBLISH
# ====================================================================================

build:
	@echo "Building package with 'build'..."
	python -m build

publish-test: build
	@echo "Publishing to TestPyPI..."
	twine upload --repository testpypi dist/*

publish: build
	@echo "Publishing to PyPI..."
	twine upload dist/*


# ====================================================================================
# CLEANUP
# ====================================================================================

clean:
	@echo "Cleaning up artifacts..."
	rm -rf build dist *.egg-info .pytest_cache .mypy_cache .coverage __pycache__ .venv
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	@echo "Cleanup complete."
