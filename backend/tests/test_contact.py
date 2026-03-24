import pytest
from httpx import ASGITransport, AsyncClient

from app.main import app


@pytest.fixture
def client():
    transport = ASGITransport(app=app)
    return AsyncClient(transport=transport, base_url="http://test")


@pytest.mark.anyio
async def test_health(client):
    async with client as c:
        resp = await c.get("/api/health")
    assert resp.status_code == 200
    assert resp.json() == {"status": "ok"}


@pytest.mark.anyio
async def test_contact_valid(client):
    async with client as c:
        resp = await c.post(
            "/api/contact",
            json={"name": "Test User", "email": "test@example.com", "message": "Hello"},
        )
    assert resp.status_code == 200
    assert resp.json()["message"] == "Message sent successfully."


@pytest.mark.anyio
async def test_contact_invalid_email(client):
    async with client as c:
        resp = await c.post(
            "/api/contact",
            json={"name": "Test", "email": "not-an-email", "message": "Hello"},
        )
    assert resp.status_code == 422
