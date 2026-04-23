---
title: Composables / State
aliases:
  - Stores
  - Composables
  - State Management
tags:
  - frontend
  - composables
  - state
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[index]]"
  - "[[components]]"
  - "[[../../codebase/data-flow-maps]]"
---

# Composables / State

No Pinia or Vuex — state is managed via Vue 3 composables using `reactive`, `ref`, and Nuxt's `useState`. Two composables exist.

---

## `useContactForm`

**File:** `composables/useContactForm.ts`  
**Used by:** [[components#ContactForm\|ContactForm.vue]]

### State Shape

| Key | Type | Initial | Description |
|-----|------|---------|-------------|
| `form.name` | `string` | `''` | Bound to the name input field |
| `form.email` | `string` | `''` | Bound to the email input field |
| `form.message` | `string` | `''` | Bound to the textarea |
| `loading` | `Ref<boolean>` | `false` | True while the API request is in flight |
| `error` | `Ref<string>` | `''` | Non-empty string when the request fails |
| `success` | `Ref<boolean>` | `false` | True after a successful submission |

### Return Values

| Key | Type | Description |
|-----|------|-------------|
| `form` | `reactive` | Two-way bound form object |
| `loading` | `Ref<boolean>` | Drives "Sending…" button label and disabled state |
| `error` | `Ref<string>` | Drives error banner display |
| `success` | `Ref<boolean>` | Drives success message display |
| `handleSubmit` | `async () => void` | Called by `@submit.prevent` — posts to `/api/contact` |

### Key Actions

| Action | Trigger | Side Effects |
|--------|---------|-------------|
| `handleSubmit()` | Form submit | Sets `loading`, calls `$fetch POST /api/contact`, sets `success` or `error`, clears form on success |

### Why `useRuntimeConfig`?

`apiBase` is read from `runtimeConfig.public.apiBase` so the backend URL can differ between dev (`localhost:8000`) and prod without a code change.

---

## `useDyslexicFont`

**File:** `composables/useDyslexicFont.ts`  
**Used by:** [[components#UiDyslexicToggle\|UiDyslexicToggle.vue]], `app.vue`

### State Shape

| Key | Type | Scope | Description |
|-----|------|-------|-------------|
| `isDyslexic` | `Readonly<Ref<boolean>>` | `useState('dyslexicFont')` — SSR-safe global | Whether OpenDyslexic font is active |

### Return Values

| Key | Type | Description |
|-----|------|-------------|
| `isDyslexic` | `Readonly<Ref<boolean>>` | Read-only — prevents external mutation |
| `toggle()` | `() => void` | Flips current state |
| `init()` | `() => void` | Reads `localStorage` and restores saved preference |

### Key Actions

| Action | Side Effects |
|--------|-------------|
| `apply(value)` | Sets `useState`, toggles `dyslexic-font` class on `<html>`, writes to `localStorage` |
| `init()` | Called in `app.vue` `onMounted` — hydrates state from `localStorage` on every page load |

### Why `useState` instead of `ref`?

`useState` is Nuxt's SSR-safe shared state — it survives hydration and is consistent across components without a global store. `ref` would create a new independent instance per composable call.
