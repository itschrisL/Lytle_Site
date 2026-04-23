---
title: Design Tokens
aliases:
  - CSS Variables
  - Theming
  - Design System
tags:
  - frontend
  - css
  - design
type: reference
status: active
created: 2026-04-22
updated: 2026-04-22
related:
  - "[[index]]"
  - "[[components]]"
  - "[[../../codebase/conventions]]"
---

# Design Tokens

All visual styling uses CSS custom properties (variables) defined in `frontend/assets/css/main.css`. **Never use hardcoded hex values, pixel values, or inline styles in components.** Always reference a token.

---

## Color Tokens

| Token | Light value | Dark value | Use for |
|-------|------------|-----------|---------|
| `--color-bg` | `#ffffff` | `#0f172a` | Page background |
| `--color-surface` | `#f8f9fa` | `#1e293b` | Cards, panels, elevated surfaces |
| `--color-border` | `#e2e8f0` | `#334155` | Borders, dividers, outlines |
| `--color-text` | `#1a202c` | `#f1f5f9` | Primary body text |
| `--color-text-muted` | `#64748b` | `#94a3b8` | Secondary/subdued text, captions, labels |
| `--color-primary` | `#2563eb` | `#3b82f6` | CTAs, links, active states, focus rings |
| `--color-primary-hover` | `#1d4ed8` | `#60a5fa` | Hover state for primary elements |
| `--color-error` | `#e74c3c` | `#f87171` | Error messages, destructive actions |
| `--color-success` | `#27ae60` | `#4ade80` | Success messages, confirmations |
| `--color-shadow` | `rgba(0,0,0,0.08)` | `rgba(0,0,0,0.3)` | Box shadow values |

---

## Layout Tokens

| Token | Value | Use for |
|-------|-------|---------|
| `--max-width` | `1100px` | Standard full-width content container |
| `--max-width-narrow` | `800px` | Prose/text-heavy sections |

---

## Radius Tokens

| Token | Value | Use for |
|-------|-------|---------|
| `--radius` | `8px` | Default border radius (buttons, inputs, cards) |
| `--radius-lg` | `12px` | Larger cards, modals |

---

## Theme Switching

Dark mode is applied via `html.dark-mode` class, set by `@nuxtjs/color-mode` with `classSuffix: '-mode'`. All color tokens are re-declared inside `html.dark-mode { }` in `main.css` — components do not need any dark-mode logic themselves.

Dyslexic font mode is applied via `html.dyslexic-font` class (set by [[stores#useDyslexicFont|useDyslexicFont]]). It forces `font-family: 'OpenDyslexic'` on body, inputs, textareas, and buttons.

---

## Typography

| Element | Font | Source |
|---------|------|--------|
| Default body | Inter | Google Fonts (loaded via `nuxt.config.ts` head) |
| Dyslexic mode | OpenDyslexic | CDN via `@font-face` in `main.css` |

---

## Anti-Patterns

| ❌ Don't | ✅ Do instead |
|---------|-------------|
| `color: #2563eb` | `color: var(--color-primary)` |
| `background: #f8f9fa` | `background: var(--color-surface)` |
| `border-radius: 8px` | `border-radius: var(--radius)` |
| `style="color: red"` | Add a CSS class using `var(--color-error)` |
| Duplicate a token value | Introduce a new token in `main.css` if the value is reused |
