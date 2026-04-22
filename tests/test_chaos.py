from src.core.chaos import calculate_wealth

def test_wealth_logic():
    assert calculate_wealth(10) == 20
