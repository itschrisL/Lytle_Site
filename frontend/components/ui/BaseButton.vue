<template>
  <component
    :is="to ? resolveComponent('NuxtLink') : 'button'"
    :to="to"
    :href="href"
    :target="href ? '_blank' : undefined"
    :rel="href ? 'noopener noreferrer' : undefined"
    :class="['btn', `btn--${variant}`, { 'btn--block': block }]"
    v-bind="$attrs"
  >
    <slot />
  </component>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  variant?: 'primary' | 'secondary' | 'outline'
  to?: string
  href?: string
  block?: boolean
}>(), {
  variant: 'primary',
})
</script>

<style scoped>
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.75rem 1.75rem;
  border-radius: var(--radius);
  font-weight: 600;
  font-size: 1rem;
  text-decoration: none;
  cursor: pointer;
  border: 2px solid transparent;
  transition: all 0.2s;
}

.btn--primary {
  background: var(--color-primary);
  color: #fff;
}
.btn--primary:hover {
  opacity: 0.9;
}

.btn--secondary {
  background: var(--color-surface);
  color: var(--color-text);
  border-color: var(--color-border);
}
.btn--secondary:hover {
  border-color: var(--color-primary);
  color: var(--color-primary);
}

.btn--outline {
  background: transparent;
  color: var(--color-primary);
  border-color: var(--color-primary);
}
.btn--outline:hover {
  background: var(--color-primary);
  color: #fff;
}

.btn--block {
  width: 100%;
}
</style>
