from fastapi import APIRouter, HTTPException

from app.schemas.contact import ContactRequest, ContactResponse
from app.services.email import send_contact_email

router = APIRouter(tags=["contact"])


@router.post("/contact", response_model=ContactResponse)
async def submit_contact(payload: ContactRequest):
    try:
        await send_contact_email(payload)
    except Exception:
        raise HTTPException(status_code=500, detail="Failed to send message. Please try again later.")
    return ContactResponse(message="Message sent successfully.")
