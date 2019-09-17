"""Test sample application."""
from src import app


def test_add_one():
    assert 4 == app.add_one(3)
