"""Main module."""


def greet(name: str = "World") -> str:
    """
    Returns a greeting string.

    Parameters
    ----------
    name : str, optional
        The name to greet, by default "World"

    Returns
    -------
    str
        The greeting.
    """
    return f"Hello, {name}"


def main():
    """Main function"""
    print(greet())


if __name__ == '__main__':
    main()