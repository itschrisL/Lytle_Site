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
