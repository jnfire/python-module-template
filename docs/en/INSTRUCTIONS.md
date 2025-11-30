# Python Module Template Usage Guide

This project is a state-of-the-art template for creating an installable Python module. It incorporates community best practices, including:

-   **`pyproject.toml`**: As the single configuration file (PEP 621).
-   **`src` layout**: To prevent import errors and ensure robust tests.
-   **`pytest`**: For simple and powerful testing.
-   **`ruff` and `black`**: For automated code quality and formatting.
-   **`Makefile`**: To simplify common tasks.
-   **`pre-commit`**: To ensure code quality before every commit.

## Project Structure (`src` layout)

```
my-project/
├── src/
│   └── my_package/           <-- Your package's source code lives here
│       ├── __init__.py
│       └── main.py
├── tests/                      <-- Tests for your package
│   └── test_main.py
├── .gitignore
├── LICENSE
├── Makefile                    <-- Shortcuts for common tasks
├── pyproject.toml              <-- The only configuration file you need!
├── .pre-commit-config.yaml     <-- Configuration for pre-commit hooks
└── README.md
```

The advantage of the `src` layout is that it forces you to install the package to test it, ensuring that tests run under the same conditions as they will for the end user.

## Getting Started

### 1. Rename the Module

The source code is located in `src/module_name`. You should rename it to match your package's name.

```bash
mv src/module_name src/my_package
```

### 2. Configure `pyproject.toml`

This file is your project's control center. Open it and edit the `[project]` section:

```toml
[project]
name = "my_package" # <-- Very important! Must match the folder name.
version = "0.0.1"
authors = [
  { name="Your Name", email="your_email@domain.com" },
]
description = "A great description of my package."
```
This file also manages your project's and development dependencies.

### 3. Install the Development Environment

Use the `Makefile` to set up your environment:

```bash
make install
```

This command creates a virtual environment, installs `pytest`, `ruff`, `pre-commit`, etc., and your package in **editable mode** (`-e`). It also **installs the pre-commit hooks automatically**.

---

## Testing with `pytest`

`pytest` is the de facto standard for testing in Python due to its simplicity and power.

**Writing Tests:**
Simply create functions that start with `test_` and use `assert` to check the results.

```python
# tests/test_main.py
from my_package.main import greet # Be sure to use your package name

def test_greet_with_name():
    """Tests that the function greets by name."""
    assert greet("Javi") == "Hello, Javi"
```

**Running Tests:**
Use the `Makefile` shortcut:
```bash
make test
```
Or run `pytest` directly:
```bash
pytest
```

---

## Common Tasks with `Makefile`

Use `make help` to see all available commands.

-   `make install`: Installs the development environment.
-   `make test`: Runs tests with `pytest`.
-   `make lint`: Checks code for style issues and errors with `ruff`.
-   `make format`: Formats all project code with `ruff` and `black`.
-   `make build`: Builds the package for distribution.
-   `make publish-test`: Publishes the package to TestPyPI.
-   `make publish`: Publishes the package to PyPI.
-   `make clean`: Removes all generated files.

---

## Ensuring Code Quality with `pre-commit`

`pre-commit` is a tool to install and manage Git hooks that run automatically before each `commit`.

**How it works:**
Once installed (with `make install`), every time you try to `git commit`, `pre-commit` will automatically run the configured code quality tools (`ruff` for linting and `black` for formatting).

*   If `ruff` finds linting errors, it will notify you, and the commit will fail until you fix them.
*   If `black` reformats your code, the commit will fail, but your code will already be formatted. You just need to `git add .` the formatted changes and try to commit again.

This ensures that all code in your repository always meets the defined quality and style standards.

**Configuration:**
The hook configuration is located in the `.pre-commit-config.yaml` file.

---

## Semantic Versioning with `bump-my-version`

Versioning (`MAJOR.MINOR.PATCH`) is managed with `bump-my-version`, the modern successor to `bumpversion`. It is configured to update the version directly in `pyproject.toml` and `VERSION.txt`.

**Good practice:** Before bumping the version, make sure all your changes are committed to `git`.

```bash
# Bump a patch (e.g., from 0.0.1 to 0.0.2)
bump-my-version patch

# Bump a minor version (e.g., from 0.0.2 to 0.1.0)
bump-my-version minor
```

---

## Packaging and Distribution

The modern workflow uses the `build` package.

### 1. Build the Package

Use the Makefile command:
```bash
make build
```
Or the direct command:
```bash
python -m build
```
This generates the distribution files (`.whl` and `.tar.gz`) in the `dist/` folder.

### 2. Local Installation from the Artifact

If you want to install your package locally to test the final artifact before publishing, you can use the generated `.whl` file. This is useful for testing the actual package installation in a clean environment.

```bash
# Make sure to activate your virtual environment if you are using one.
pip install dist/your_package-0.0.1-py3-none-any.whl
```
**Note:** Replace `your_package-0.0.1-py3-none-any.whl` with the exact name of the `.whl` file generated in your `dist/` folder.

### 3. Publish to PyPI

The `Makefile` also simplifies publishing.

**Good practice:** Publish to the test environment first.
```bash
make publish-test
```

When everything is correct, publish to the official repository:
```bash
make publish
```

These commands use `twine` to securely upload the artifacts from the `dist/` folder.

---