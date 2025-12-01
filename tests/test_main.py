from module_name import greet


def test_greet_with_name():
    """Tests the greet function with a name."""
    assert greet("Javi") == "Hello, Javi"


def test_greet_without_name():
    """Tests the greet function without a name, expecting the default."""
    assert greet() == "Hello, World"
