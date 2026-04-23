<template>
  <form class="contact-form" @submit.prevent="handleSubmit">
    <div class="form-group">
      <label for="name">Name</label>
      <input
        id="name"
        v-model="form.name"
        type="text"
        required
        autocomplete="name"
        placeholder="Your name"
      />
    </div>
    <div class="form-group">
      <label for="email">Email</label>
      <input
        id="email"
        v-model="form.email"
        type="email"
        required
        autocomplete="email"
        placeholder="you@example.com"
      />
    </div>
    <div class="form-group">
      <label for="message">Message</label>
      <textarea
        id="message"
        v-model="form.message"
        required
        rows="6"
        placeholder="How can I help?"
      />
    </div>
    <div v-if="error" class="form-error">{{ error }}</div>
    <div v-if="success" class="form-success">Thanks! I'll be in touch soon.</div>
    <UiBaseButton type="submit" :disabled="loading" block>
      {{ loading ? 'Sending…' : 'Send Message' }}
    </UiBaseButton>
  </form>
</template>

<script setup lang="ts">
import { useContactForm } from '~/composables/useContactForm'

const { form, loading, error, success, handleSubmit } = useContactForm()
</script>

<style scoped>
.contact-form {
  max-width: 560px;
}

.form-group {
  margin-bottom: 1.25rem;
}

.form-group label {
  display: block;
  font-weight: 600;
  font-size: 0.9rem;
  margin-bottom: 0.4rem;
  color: var(--color-text);
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  background: var(--color-surface);
  color: var(--color-text);
  font-size: 1rem;
  font-family: inherit;
  transition: border-color 0.2s;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: var(--color-primary);
}

.form-error {
  color: var(--color-error);
  font-size: 0.9rem;
  margin-bottom: 1rem;
}

.form-success {
  color: var(--color-success);
  font-size: 0.9rem;
  margin-bottom: 1rem;
}
</style>
