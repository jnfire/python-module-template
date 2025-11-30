# Python Module Template (Legacy - setup.py based)

A template for creating Python packages using traditional `setup.py` and `setup.cfg` packaging methods.

This template is configured with robust practices to provide a solid starting point for projects that may need to stick with a `setup.py`-based workflow, while still incorporating modern development tools like `pytest`, `ruff`, and `pre-commit`.

### Features

-   **Traditional Packaging**: `setup.py` and `setup.cfg` for package metadata and build configuration.
-   **Robust Structure**: Conventional project layout.
-   **Modern Testing**: `pytest` for writing simple and powerful tests.
-   **Automated Quality**: Code linting and formatting with `ruff` and `black`.
-   **Pre-commit Hooks**: Automatic quality checks before every commit with `pre-commit`.
-   **Semantic Versioning**: Managed with `bumpversion`.
-   **Easy Task Management**: A `Makefile` with shortcuts for common development tasks (install, test, build, etc.).
-   **CI/CD Neutral**: No lock-in to a specific CI/CD provider.

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
    Your source code lives in the `module_name` directory. Follow the detailed instructions linked above to rename the package and configure your `setup.py`/`setup.cfg`.