from fastapi import APIRouter, HTTPException, Request

from app.limiter import limiter
from app.schemas.contact import ContactRequest, ContactResponse
from app.services.email import send_contact_email

router = APIRouter(tags=["contact"])


@router.post("/contact", response_model=ContactResponse)
@limiter.limit("5/minute")
async def submit_contact(request: Request, payload: ContactRequest):
    try:
        await send_contact_email(payload)
    except Exception:
        raise HTTPException(status_code=500, detail="Failed to send message. Please try again later.")
    return ContactResponse(message="Message sent successfully.")
