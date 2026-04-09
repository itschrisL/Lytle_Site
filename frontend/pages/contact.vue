<template>
  <div class="page contact-page">
    <UiSectionHeading subtitle="Have a question, opportunity, or just want to say hi? I'd love to hear from you.">
      Get in Touch
    </UiSectionHeading>

    <div class="wip-banner" role="alert" aria-live="polite">
      <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
      <span>
        The contact form is still a work in progress. In the meantime, reach me directly via
        <a href="mailto:chris@example.com">email</a> or
        <a href="https://www.linkedin.com/in/christopherslytle/" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
      </span>
    </div>

    <div class="contact-layout">
      <ContactContactForm />
      <aside class="contact-aside">
        <h3>Other ways to reach me</h3>
        <UiSocialLinks />
        <p class="contact-note">
          I typically respond within 24 hours. For urgent inquiries, email is best.
        </p>
      </aside>
    </div>
  </div>
</template>

<script setup lang="ts">
useHead({
  title: 'Contact — Chris Lytle',
  meta: [{ name: 'description', content: 'Get in touch with Chris Lytle.' }],
})
</script>

<style scoped>
.contact-page {
  max-width: var(--max-width-narrow);
  margin: 0 auto;
  padding: 3rem 1.5rem;
}

/* Warning banner — because the form isn't ready and we'd rather tell you than ghost you */
.wip-banner {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  background: color-mix(in srgb, #f59e0b 10%, var(--color-surface));
  border: 1px solid color-mix(in srgb, #f59e0b 45%, var(--color-border));
  border-radius: var(--radius);
  padding: 0.875rem 1.25rem;
  margin-bottom: 2rem;
  font-size: 0.925rem;
  color: var(--color-text);
  line-height: 1.6;
}

.wip-banner svg {
  flex-shrink: 0;
  margin-top: 2px;
  color: #d97706;
}

.wip-banner a {
  color: #d97706;
  font-weight: 500;
  text-decoration: underline;
  text-underline-offset: 2px;
}

.wip-banner a:hover {
  color: #b45309;
}

.contact-layout {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 4rem;
  align-items: start;
}

.contact-aside h3 {
  font-size: 1rem;
  font-weight: 600;
  margin: 0 0 1rem;
}

.contact-note {
  font-size: 0.9rem;
  color: var(--color-text-muted);
  margin-top: 1.5rem;
  line-height: 1.6;
}

@media (max-width: 768px) {
  .contact-layout {
    grid-template-columns: 1fr;
    gap: 2.5rem;
  }
}
</style>
