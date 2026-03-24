<template>
  <div class="timeline">
    <div v-for="(job, i) in experience" :key="i" class="timeline__item">
      <div class="timeline__marker" />
      <div class="timeline__content">
        <div class="timeline__header">
          <h3>{{ job.title }}</h3>
          <span class="timeline__company">{{ job.company }}</span>
        </div>
        <span class="timeline__period">{{ job.period }}</span>
        <p class="timeline__description">{{ job.description }}</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import experience from '~/content/experience.json'
</script>

<style scoped>
.timeline {
  position: relative;
  padding-left: 2rem;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 0.5rem;
  top: 0.5rem;
  bottom: 0.5rem;
  width: 2px;
  background: var(--color-border);
}

.timeline__item {
  position: relative;
  padding-bottom: 2rem;
}

.timeline__item:last-child {
  padding-bottom: 0;
}

.timeline__marker {
  position: absolute;
  left: -1.65rem;
  top: 0.4rem;
  width: 12px;
  height: 12px;
  background: var(--color-primary);
  border-radius: 50%;
  border: 2px solid var(--color-bg);
}

.timeline__header {
  display: flex;
  align-items: baseline;
  gap: 0.75rem;
  flex-wrap: wrap;
}

.timeline__header h3 {
  font-size: 1.15rem;
  font-weight: 600;
  margin: 0;
}

.timeline__company {
  color: var(--color-primary);
  font-weight: 500;
  font-size: 0.95rem;
}

.timeline__period {
  font-size: 0.85rem;
  color: var(--color-text-muted);
  display: inline-block;
  margin: 0.25rem 0 0.5rem;
}

.timeline__description {
  color: var(--color-text-muted);
  line-height: 1.7;
  margin: 0;
}
</style>
