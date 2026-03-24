<template>
  <article class="project-detail">
    <header class="project-detail__header">
      <NuxtLink to="/projects" class="back-link">&larr; All Projects</NuxtLink>
      <h1>{{ project.title }}</h1>
      <p class="project-detail__summary">{{ project.description }}</p>
      <div class="project-detail__meta">
        <div class="project-detail__tags">
          <span v-for="tag in project.stack" :key="tag" class="tag">{{ tag }}</span>
        </div>
        <div class="project-detail__links">
          <UiBaseButton v-if="project.liveUrl" :href="project.liveUrl" variant="primary">
            Live Site
          </UiBaseButton>
          <UiBaseButton v-if="project.repoUrl" :href="project.repoUrl" variant="outline">
            Source Code
          </UiBaseButton>
        </div>
      </div>
    </header>
    <div v-if="project.image" class="project-detail__hero-image">
      <img :src="project.image" :alt="project.title" />
    </div>
    <div class="project-detail__body">
      <section v-if="project.role">
        <h2>My Role</h2>
        <p>{{ project.role }}</p>
      </section>
      <section v-if="project.outcome">
        <h2>Outcome</h2>
        <p>{{ project.outcome }}</p>
      </section>
    </div>
  </article>
</template>

<script setup lang="ts">
defineProps<{
  project: {
    title: string
    slug: string
    description: string
    stack: string[]
    image?: string
    liveUrl?: string
    repoUrl?: string
    role?: string
    outcome?: string
  }
}>()
</script>

<style scoped>
.project-detail {
  max-width: var(--max-width-narrow);
  margin: 0 auto;
  padding: 3rem 1.5rem;
}

.back-link {
  font-size: 0.9rem;
  color: var(--color-text-muted);
  text-decoration: none;
  display: inline-block;
  margin-bottom: 1.5rem;
}
.back-link:hover {
  color: var(--color-primary);
}

.project-detail__header h1 {
  font-size: 2.25rem;
  font-weight: 700;
  margin: 0 0 0.75rem;
}

.project-detail__summary {
  font-size: 1.15rem;
  color: var(--color-text-muted);
  line-height: 1.7;
  margin: 0 0 1.5rem;
}

.project-detail__meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
  margin-bottom: 2rem;
}

.project-detail__tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.tag {
  font-size: 0.8rem;
  padding: 0.25rem 0.75rem;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: 999px;
  color: var(--color-text-muted);
  font-weight: 500;
}

.project-detail__links {
  display: flex;
  gap: 0.75rem;
}

.project-detail__hero-image {
  border-radius: var(--radius-lg);
  overflow: hidden;
  margin-bottom: 2.5rem;
}
.project-detail__hero-image img {
  width: 100%;
  display: block;
}

.project-detail__body section {
  margin-bottom: 2rem;
}

.project-detail__body h2 {
  font-size: 1.4rem;
  font-weight: 600;
  margin: 0 0 0.75rem;
}

.project-detail__body p {
  color: var(--color-text-muted);
  line-height: 1.7;
}
</style>
