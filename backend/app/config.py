from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # Set to False in production to hide /api/docs and /api/openapi.json
    debug: bool = False

    # Comma-separated list of allowed origins for CORS
    allowed_origins: list[str] = ["http://localhost:3000"]

    # Email / SMTP settings
    smtp_host: str = ""
    smtp_port: int = 587
    smtp_user: str = ""
    smtp_password: str = ""
    contact_recipient: str = ""

    model_config = {"env_file": ".env", "env_file_encoding": "utf-8"}


settings = Settings()
