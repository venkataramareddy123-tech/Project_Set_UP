"""Starter helpers that describe the template's supported project profiles."""


def starter_message() -> str:
    """Return the current starter positioning."""
    return "agent-first production starter"


def supported_profiles() -> tuple[str, ...]:
    """Return the bootstrap profiles shipped with the template."""
    return ("library", "cli", "web", "service", "desktop", "sandbox")
