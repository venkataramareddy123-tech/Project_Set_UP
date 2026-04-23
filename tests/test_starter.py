from src.starter import starter_message, supported_profiles


def test_starter_message_marker() -> None:
    assert starter_message() == "agent-first production starter"


def test_supported_profiles_include_service() -> None:
    assert "service" in supported_profiles()
