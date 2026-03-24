<template>
  <div class="section-heading">
    <h2 class="section-heading__title">
      <slot />
    </h2>
    <p v-if="subtitle" class="section-heading__subtitle">{{ subtitle }}</p>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  subtitle?: string
}>()
</script>

<style scoped>
.section-heading {
  margin-bottom: 2.5rem;
}

.section-heading__title {
  font-size: 2rem;
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 0.5rem;
}

.section-heading__subtitle {
  font-size: 1.1rem;
  color: var(--color-text-muted);
  margin: 0;
  max-width: 600px;
}
</style>
