import unittest
from module_name.main import greet


class TestMain(unittest.TestCase):
    """
    Tests for the main module.
    """

    def test_greet_with_name(self):
        """
        Tests the greet function with a name.
        """
        self.assertEqual(greet("Javi"), "Hello, Javi")

    def test_greet_without_name(self):
        """
        Tests the greet function without a name, expecting the default.
        """
        self.assertEqual(greet(), "Hello, World")


if __name__ == '__main__':
    unittest.main()
