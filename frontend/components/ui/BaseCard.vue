<template>
  <div :class="['card', { 'card--hoverable': hoverable }]">
    <div v-if="$slots.image" class="card__image">
      <slot name="image" />
    </div>
    <div class="card__body">
      <slot />
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  hoverable?: boolean
}>()
</script>

<style scoped>
.card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  overflow: hidden;
  transition: transform 0.2s, box-shadow 0.2s;
}

.card--hoverable:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 32px var(--color-shadow);
}

.card__image {
  width: 100%;
  aspect-ratio: 16 / 9;
  overflow: hidden;
  background: var(--color-border);
}

.card__image :deep(img) {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.card__body {
  padding: 1.5rem;
}
</style>
