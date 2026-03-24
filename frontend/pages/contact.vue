<template>
  <div class="page contact-page">
    <UiSectionHeading subtitle="Have a question, opportunity, or just want to say hi? I'd love to hear from you.">
      Get in Touch
    </UiSectionHeading>

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
