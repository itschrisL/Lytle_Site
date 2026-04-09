# Project Todo

## Phase 1 — Content & Positioning

- [ ] Write homepage value proposition (who Chris is, what he does, primary CTA)
- [ ] Write About page copy (background, strengths, startup + sales-engineering angle)
- [ ] Gather headshot / professional photo
- [ ] Compile 3–5 projects with title, description, stack, role, and outcome
- [ ] Update `frontend/content/projects.json` with real project data
- [ ] Update `frontend/content/experience.json` with real work history
- [ ] Update `frontend/content/skills.json` with real skills
- [ ] Prepare resume PDF and replace `frontend/public/Chris_Lytle_Resume.pdf`
- [ ] Update social links in `frontend/components/ui/SocialLinks.vue` (GitHub, LinkedIn, email)

## Phase 2 — Design & Polish

- [ ] Choose final color palette and update CSS variables in `frontend/assets/css/main.css`
- [ ] Add headshot / images to `frontend/assets/images/`
- [ ] Add project screenshots to `frontend/assets/images/`
- [ ] Create or source favicon and replace `frontend/public/favicon.ico`
- [ ] Create social preview image (`frontend/public/og-image.png`)
- [ ] Review typography (Inter font) — confirm or swap
- [ ] Test responsive layout on mobile, tablet, and desktop
- [ ] Verify dark-on-light contrast meets WCAG AA
- [x] Add OpenDyslexic font with toggleable button in header (accessibility)

## Phase 3 — Backend & Contact Flow

- [ ] Configure `.env` with real SMTP credentials (or SendGrid / Resend)
- [ ] Test contact form end-to-end (submit → email received)
- [ ] Add rate limiting to `POST /api/contact` to prevent spam
- [ ] Confirm CORS `allowed_origins` is set for production domain

## Phase 4 — Launch Readiness

- [ ] Upgrade local Node.js to v20 (required by Nuxt 3)
- [ ] Upgrade local Python to 3.14
- [ ] Run `npm run build` / `npm run generate` and verify output
- [ ] Run `pytest` and confirm all backend tests pass
- [ ] Set up hosting (Vercel / Netlify for frontend, Render / Railway / Fly.io for backend)
- [ ] Configure custom domain
- [ ] Set `NUXT_PUBLIC_API_BASE` to production backend URL
- [ ] Verify SEO meta tags, sitemap, and `robots.txt`
- [ ] Add analytics (Plausible, Umami, or Google Analytics)

## Phase 5 — Post-Launch

- [ ] Add blog / articles section
- [ ] Add testimonials or social proof
- [ ] Add services page (if pursuing client work)
- [ ] Richer project case studies with detailed write-ups
- [ ] Newsletter / lead capture integration
- [ ] Dark mode toggle
