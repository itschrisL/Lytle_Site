---
title: Code Templates
aliases:
  - Templates
  - Starters
tags:
  - templates
  - frontend
  - backend
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[../codebase/conventions]]"
  - "[[../frontend/design-tokens]]"
  - "[[../backend/index]]"
  - "[[../backend/testing]]"
---

# Code Templates

Copy-paste starters for the three most common file types in this project. Each template enforces the project's conventions — see [[../codebase/conventions|conventions.md]] for the rules behind them.

Raw files (for direct copy-paste into your editor) live alongside this file as `new-component.vue`, `new-composable.ts`, and `new-endpoint.py`.

---

## Vue Component — `new-component.vue`

**When to use:** Creating any new Vue component in `frontend/components/`.

**Placement rule:** File must live at `components/<domain>/<Name>.vue` — Nuxt auto-imports it as `<DomainName>`. See [[../codebase/conventions#Frontend — Components|conventions]].

```vue
<template>
  <div class="component-name">
    <slot />
  </div>
</template>

<script setup lang="ts">
// Props — define all inputs here
withDefaults(defineProps<{
  // propName?: string
}>(), {
  // propName: 'default',
})

// Emits — define all outputs here
// const emit = defineEmits<{
//   eventName: [value: string]
// }>()

// Composable imports — Nuxt auto-imports, no explicit import needed
// const { state, action } = useComposableName()
</script>

<style scoped>
/*
  RULES:
  - Use CSS variables only — never hardcode hex, rgb, or pixel values
  - Scoped styles only — no global side effects
  - Reference docs/knowledge-base/frontend/design-tokens.md for all available tokens

  Available tokens (quick ref):
    Colors:     --color-bg, --color-surface, --color-border,
                --color-text, --color-text-muted,
                --color-primary, --color-primary-hover,
                --color-error, --color-success, --color-shadow
    Layout:     --max-width, --max-width-narrow
    Radius:     --radius, --radius-lg
*/

.component-name {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  color: var(--color-text);
}
</style>
```

---

## Composable — `new-composable.ts`

**When to use:** Creating any new composable in `frontend/composables/`.

**Naming rule:** File must be `use<PascalCase>.ts`. Always return named exports. Use `useState` for SSR-safe global state; use `ref` for local state recreated per call.

```typescript
// File: frontend/composables/use<Name>.ts

// For composables that call the backend API:
// const config = useRuntimeConfig()
// const apiBase = config.public.apiBase  → e.g. http://localhost:8000

// --- State ---
// Replace with useState for global/SSR-safe state, or ref for local state
// const value = useState<string>('unique-key', () => '')

// --- Actions ---
// const doSomething = () => {
//   // implementation
// }

// --- Exports ---
export function use<Name>() {
  return {
    // value,
    // doSomething,
  }
}
```

---

## FastAPI Endpoint — `new-endpoint.py`

**When to use:** Adding a new API route to `backend/app/routers/`.

**Registration rule:** Every new router must be registered in `create_app()` in `app/main.py` with the `/api` prefix. See [[../backend/index|backend/index.md]].

**Test rule:** Every new endpoint needs tests in `backend/tests/test_<resource>.py`. See [[../backend/testing|backend/testing.md]].

```python
"""
File: backend/app/routers/<resource>.py

Flow: Router → Schema validation → Service → Response
"""
import logging
from fastapi import APIRouter, HTTPException

from app.schemas.<resource> import <Resource>Request, <Resource>Response
from app.services.<service> import <service_function>

logger = logging.getLogger(__name__)
router = APIRouter()


@router.post("/<resource>", response_model=<Resource>Response)
async def submit_<resource>(payload: <Resource>Request) -> <Resource>Response:
    """POST /api/<resource>"""
    try:
        await <service_function>(payload)
        return <Resource>Response(message="<Action> successful.")
    except Exception:
        logger.exception("Failed to process /<resource> request")
        raise HTTPException(status_code=500, detail="Internal server error.")


# --- Registration (add to app/main.py) ----
#
# from app.routers.<resource> import router as <resource>_router
# app.include_router(<resource>_router, prefix="/api")
```
