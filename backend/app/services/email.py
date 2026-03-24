import logging
import smtplib
from email.message import EmailMessage

from app.config import settings
from app.schemas.contact import ContactRequest

logger = logging.getLogger(__name__)


async def send_contact_email(payload: ContactRequest) -> None:
    """Send a contact-form email via SMTP.

    If SMTP is not configured, logs the message instead so local
    development works without a mail server.
    """
    subject = f"New contact from {payload.name}"
    body = (
        f"Name: {payload.name}\n"
        f"Email: {payload.email}\n\n"
        f"{payload.message}"
    )

    if not settings.smtp_host:
        logger.info("SMTP not configured — logging contact message:\n%s", body)
        return

    msg = EmailMessage()
    msg["Subject"] = subject
    msg["From"] = settings.smtp_user
    msg["To"] = settings.contact_recipient
    msg["Reply-To"] = payload.email
    msg.set_content(body)

    with smtplib.SMTP(settings.smtp_host, settings.smtp_port) as server:
        server.starttls()
        server.login(settings.smtp_user, settings.smtp_password)
        server.send_message(msg)
