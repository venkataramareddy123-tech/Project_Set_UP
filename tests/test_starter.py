from src.starter import starter_message


def test_starter_message_marker() -> None:
    assert starter_message() == "replace-me"
