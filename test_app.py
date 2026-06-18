"""doing unit and integrated testing here """
import pytest
from app import calculate_tax, add_user_to_db

# 1. UNIT TESTING (Testing a single function in isolation)
def test_calculate_tax_low():
    assert calculate_tax(10000) == 500

def test_calculate_tax_high():
    assert calculate_tax(60000) == 6000

# 2. INTEGRATION TESTING (Testing interaction between component and DB)
def test_integration_add_user():
    fake_database = []
    result = add_user_to_db(fake_database, "Cris")
    assert result is True
    assert "Cris" in fake_database


