<template>
  <NuxtLink :to="`/projects/${project.slug}`" class="project-card-link">
    <UiBaseCard hoverable>
      <template #image>
        <img
          :src="project.image || '/og-image.png'"
          :alt="project.title"
          loading="lazy"
        />
      </template>
      <h3 class="project-card__title">{{ project.title }}</h3>
      <p class="project-card__description">{{ project.description }}</p>
      <div class="project-card__tags">
        <span v-for="tag in project.stack" :key="tag" class="tag">{{ tag }}</span>
      </div>
    </UiBaseCard>
  </NuxtLink>
</template>

<script setup lang="ts">
defineProps<{
  project: {
    slug: string
    title: string
    description: string
    image?: string
    stack: string[]
  }
}>()
</script>

<style scoped>
.project-card-link {
  text-decoration: none;
  color: inherit;
}

.project-card__title {
  font-size: 1.2rem;
  font-weight: 600;
  margin: 0 0 0.5rem;
  color: var(--color-text);
}

.project-card__description {
  font-size: 0.95rem;
  color: var(--color-text-muted);
  line-height: 1.6;
  margin: 0 0 1rem;
}

.project-card__tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.tag {
  font-size: 0.8rem;
  padding: 0.25rem 0.75rem;
  background: var(--color-bg);
  border: 1px solid var(--color-border);
  border-radius: 999px;
  color: var(--color-text-muted);
  font-weight: 500;
}
</style>
