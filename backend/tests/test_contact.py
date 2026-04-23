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


@pytest.mark.anyio
async def test_contact_rate_limited(client):
    """After 5 successful submissions from the same IP the 6th should receive 429."""
    # Use a dedicated IP not used by any other test — keeps counters isolated
    headers = {"X-Forwarded-For": "192.168.99.99"}
    payload = {"name": "Spam Bot", "email": "spam@test.com", "message": "Hello!"}
    async with client as c:
        for i in range(5):
            resp = await c.post("/api/contact", json=payload, headers=headers)
            assert resp.status_code == 200, f"Request {i + 1}/5 should succeed, got {resp.status_code}"
        # The 6th request over the limit — should bounce like a bad check
        resp = await c.post("/api/contact", json=payload, headers=headers)
    assert resp.status_code == 429
