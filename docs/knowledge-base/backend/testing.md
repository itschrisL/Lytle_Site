---
title: Backend Testing
aliases:
  - Test Patterns
  - pytest
  - AsyncClient
tags:
  - backend
  - testing
  - pytest
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[index]]"
  - "[[utils/config]]"
  - "[[../../codebase/api-endpoints]]"
---

# Backend Testing

All backend tests use `pytest` with `httpx.AsyncClient` + `ASGITransport`. No live server is needed — the app is tested directly in-process.

**Run tests:** `cd backend && pytest`

---

## Test Stack

| Package | Role |
|---------|------|
| `pytest` | Test runner |
| `pytest-anyio` | Async test support — provides `@pytest.mark.anyio` |
| `httpx` | Async HTTP client with `ASGITransport` for in-process testing |

---

## Required Fixtures

### `anyio_backend` (in `tests/conftest.py`)

```python
import pytest

@pytest.fixture(params=["asyncio"])
def anyio_backend(request):
    return request.param
```

This fixture is **mandatory** — without it `@pytest.mark.anyio` tests will fail with a scope mismatch or "no event loop" error. It is already defined in `tests/conftest.py`; do not remove it.

### `client` fixture pattern

```python
from httpx import ASGITransport, AsyncClient
from app.main import app

@pytest.fixture
def client():
    transport = ASGITransport(app=app)
    return AsyncClient(transport=transport, base_url="http://test")
```

The `client` fixture returns an `AsyncClient` — **not** a context manager itself. Wrap it with `async with client as c:` inside each test.

---

## Test Skeleton — New Endpoint

Copy this when adding a test for a new route:

```python
import pytest
from httpx import ASGITransport, AsyncClient
from app.main import app


@pytest.fixture
def client():
    transport = ASGITransport(app=app)
    return AsyncClient(transport=transport, base_url="http://test")


@pytest.mark.anyio
async def test_<resource>_valid(client):
    async with client as c:
        resp = await c.post(
            "/api/<resource>",
            json={"field": "value"},
        )
    assert resp.status_code == 200
    assert resp.json()["key"] == "expected"


@pytest.mark.anyio
async def test_<resource>_invalid_payload(client):
    async with client as c:
        resp = await c.post("/api/<resource>", json={})
    assert resp.status_code == 422  # Pydantic validation failure
```

---

## What to Test for Every New Endpoint

| Scenario | Expected status |
|----------|----------------|
| Valid payload — happy path | `200` |
| Missing required field | `422` |
| Invalid field value (wrong type, bad email, etc.) | `422` |
| Downstream service failure (mock the service) | `500` |

---

## Mocking Services

To test error paths without a real SMTP server, monkeypatch the service:

```python
import pytest

@pytest.mark.anyio
async def test_contact_smtp_failure(client, monkeypatch):
    async def broken_send(payload):
        raise Exception("SMTP down")

    monkeypatch.setattr(
        "app.routers.contact.send_contact_email", broken_send
    )
    async with client as c:
        resp = await c.post(
            "/api/contact",
            json={"name": "X", "email": "x@x.com", "message": "hi"},
        )
    assert resp.status_code == 500
```

---

## Anti-Patterns

| ❌ Don't | ✅ Do instead |
|---------|-------------|
| Mix `pytest-asyncio` and `pytest-anyio` in the same project | Use `pytest-anyio` only — it's already in `requirements.txt` |
| Use `asyncio.run()` inside a test | Mark the test `@pytest.mark.anyio` and make it `async def` |
| Test against a live `uvicorn` server | Use `ASGITransport` — faster, isolated, no port conflicts |
| Assert on response text with string search | Use `resp.json()` and assert on the parsed dict |
| Run `pytest` from the repo root | Run from `backend/` so `conftest.py` and `app/` are on the path |
