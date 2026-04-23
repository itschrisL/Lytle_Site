---
title: Data Flow Maps
aliases:
  - Request Traces
  - Flow Diagrams
tags:
  - data-flow
  - architecture
  - codebase
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[architecture]]"
  - "[[api-endpoints]]"
  - "[[../backend/utils/email]]"
  - "[[../frontend/stores]]"
---

# Data Flow Maps

End-to-end request traces for the two most important user actions.

---

## Flow 1 — Contact Form Submission

**Trigger:** User fills out `ContactForm.vue` and clicks "Send Message."

```
ContactForm.vue (template)
  │  @submit.prevent="handleSubmit"
  ▼
useContactForm() composable
  │  loading = true
  │  $fetch(POST ${apiBase}/api/contact, body: { name, email, message })
  │
  │  [Nuxt routeRules proxy in dev → localhost:8000]
  ▼
FastAPI — CORSMiddleware
  │  checks Origin header against settings.allowed_origins
  ▼
POST /api/contact  →  submit_contact(payload: ContactRequest)
  │  Pydantic validates: name (str), email (EmailStr), message (str)
  │  Validation failure → 422 returned immediately
  ▼
send_contact_email(payload)   [app/services/email.py]
  │
  ├─ smtp_host empty?
  │   YES → logger.info(body)  →  return (no email sent)
  │   NO  → smtplib.SMTP(host, port)
  │           server.starttls()
  │           server.login(user, password)
  │           server.send_message(msg)
  │           Exception → propagates up
  ▼
submit_contact returns ContactResponse(message="Message sent successfully.")
  │  200 OK
  ▼
useContactForm
  │  success = true
  │  form fields cleared
  ▼
ContactForm.vue renders success message: "Thanks! I'll be in touch soon."
```

**Error path:** SMTP raises → `submit_contact` catches, raises `HTTPException(500)` → `useContactForm` catches, sets `error = e?.data?.detail || "Something went wrong."` → form displays error banner.

---

## Flow 2 — Project Detail Page Load

**Trigger:** User navigates to `/projects/some-slug`.

```
Browser navigates to /projects/[slug]
  ▼
Nuxt file-based router matches pages/projects/[slug].vue
  ▼
[slug].vue script setup
  │  import projects from '~/content/projects.json'   (build-time bundle)
  │  const project = projects.find(p => p.slug === route.params.slug)
  │
  ├─ project found?
  │   YES → useHead({ title, meta }) set
  │         ProjectsProjectDetail component rendered with :project prop
  │   NO  → createError({ statusCode: 404 })
  ▼
ProjectDetail.vue renders:
  - title, description, stack tags
  - optional image
  - role and outcome sections
  - optional liveUrl / repoUrl buttons (UiBaseButton with href)
```

**No backend round-trip.** All data is bundled from the static JSON file at build time. The backend is never contacted for page content.

---

## Flow 3 — Dyslexic Font Toggle

**Trigger:** User clicks `UiDyslexicToggle` in the header.

```
UiDyslexicToggle.vue
  │  @click="toggle"
  ▼
useDyslexicFont() — toggle()
  │  apply(!isDyslexic.value)
  ▼
apply(value)
  │  isDyslexic.value = value          (Nuxt useState — SSR-safe)
  │  document.documentElement.classList.toggle('dyslexic-font', value)
  │  localStorage.setItem('dyslexicFont', value ? '1' : '0')
  ▼
CSS class 'dyslexic-font' on <html> triggers font swap via main.css

On next page load:
  app.vue onMounted → useDyslexicFont().init()
    └─ localStorage.getItem('dyslexicFont') === '1' → apply(true)
```

**No server involvement.** State lives entirely in `localStorage` + `useState` + a CSS class.
