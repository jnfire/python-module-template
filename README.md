# Python Module Template

A template for creating professional, modern, and installable Python packages.

This template is configured with current best practices to provide a robust and developer-friendly starting point. It's designed to be didactic, easy to use, and highly configurable.

### Features

-   **Single Configuration**: `pyproject.toml` as the single source of truth (PEP 621).
-   **Robust Structure**: `src` layout to prevent common import errors.
-   **Modern Testing**: `pytest` for writing simple and powerful tests.
-   **Automated Quality**: Code linting and formatting with `ruff` and `black`.
-   **Pre-commit Hooks**: Automatic quality checks before every commit with `pre-commit`.
-   **Simplified Versioning**: Semantic versioning with `bump-my-version`.
-   **Easy Task Management**: A `Makefile` with shortcuts for common development tasks (install, test, build, etc.).

---

## Getting Started

For detailed instructions on how to use this template, please choose your preferred language:

-   **[English](./docs/en/INSTRUCTIONS.md)**
-   **[Español](./docs/es/INSTRUCTIONS.md)**

---

### Quick Setup

1.  **Clone the repository:**
    ```bash
    git clone <this-repo-url> my-new-project
    cd my-new-project
    ```

2.  **Install the development environment:**
    This command creates a virtual environment, installs all dependencies, and sets up pre-commit hooks.
    ```bash
    make install
    ```

3.  **Start coding!**
    Your source code lives in `src/module_name`. Follow the detailed instructions linked above to rename the package and configure `pyproject.toml`.
