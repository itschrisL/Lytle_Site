<template>
  <div class="page projects-page">
    <UiSectionHeading subtitle="Things I've built, shipped, and learned from.">
      Projects
    </UiSectionHeading>

    <div class="projects-grid">
      <ProjectsProjectCard
        v-for="project in projects"
        :key="project.slug"
        :project="project"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import projects from '~/content/projects.json'

useSeoMeta({
  title: 'Projects — Chris Lytle',
  description: 'Browse projects by Chris Lytle — software developer, sales engineer, and startup builder.',
  ogTitle: 'Projects — Chris Lytle',
  ogDescription: 'Browse projects by Chris Lytle — software developer, sales engineer, and startup builder.',
  ogImage: '/og-image.png',
  twitterCard: 'summary_large_image',
})
</script>

<style scoped>
.projects-page {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 3rem 1.5rem;
}

.projects-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 1.5rem;
}
</style>
