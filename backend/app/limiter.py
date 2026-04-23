# ██╗  ██╗   ██╗████████╗██╗     ███████╗
# ██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
# ██║   ╚████╔╝    ██║   ██║     █████╗
# ██║    ╚██╔╝     ██║   ██║     ██╔══╝
# ███████╗██║      ██║   ███████╗███████╗
# ╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝

# Rate limiter singleton — shared across all route handlers.
# Uses in-memory storage; swap storage_uri for Redis in production if needed.

from slowapi import Limiter
from starlette.requests import Request


def _get_client_ip(request: Request) -> str:
    """
    Resolve the real client IP.
    Prefers X-Forwarded-For (set by reverse proxies) over the raw socket host.
    Falls back to 'testclient' for ASGI test transports that have no client info.
    """
    forwarded = request.headers.get("X-Forwarded-For")
    if forwarded:
        # X-Forwarded-For can be a comma-separated list; leftmost is the originating client
        return forwarded.split(",")[0].strip()
    if request.client:
        return request.client.host
    return "testclient"  # only hit in unit tests using ASGITransport


limiter = Limiter(key_func=_get_client_ip, storage_uri="memory://")
