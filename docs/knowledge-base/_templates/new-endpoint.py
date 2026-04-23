"""
New API Endpoint Template
File: backend/app/routers/<resource>.py

Flow: Router → Schema validation → Service → Response
ALWAYS register this router in create_app() in app/main.py with the /api prefix.

See: docs/knowledge-base/backend/index.md
     docs/knowledge-base/codebase/conventions.md
"""
import logging
from fastapi import APIRouter, HTTPException

from app.schemas.<resource> import <Resource>Request, <Resource>Response
from app.services.<service> import <service_function>

logger = logging.getLogger(__name__)
router = APIRouter()


@router.post("/<resource>", response_model=<Resource>Response)
async def submit_<resource>(payload: <Resource>Request) -> <Resource>Response:
    """
    POST /api/<resource>

    Accepts a validated payload, delegates to the service layer,
    and returns a structured response.
    """
    try:
        await <service_function>(payload)
        return <Resource>Response(message="<Action> successful.")
    except Exception:
        logger.exception("Failed to process /<resource> request")
        raise HTTPException(status_code=500, detail="Internal server error.")


# --- Registration (add to app/main.py) ----------------------------------------
#
# from app.routers.<resource> import router as <resource>_router
# app.include_router(<resource>_router, prefix="/api")
#
# -------------------------------------------------------------------------------
