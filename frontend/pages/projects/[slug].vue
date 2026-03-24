<template>
  <div v-if="project">
    <ProjectsProjectDetail :project="project" />
  </div>
  <div v-else class="not-found">
    <h1>Project not found</h1>
    <UiBaseButton to="/projects" variant="secondary">Back to Projects</UiBaseButton>
  </div>
</template>

<script setup lang="ts">
import projects from '~/content/projects.json'

const route = useRoute()
const project = projects.find(p => p.slug === route.params.slug)

if (!project) {
  throw createError({ statusCode: 404, statusMessage: 'Project not found' })
}

useHead({
  title: project ? `${project.title} — Chris Lytle` : 'Not Found',
  meta: project
    ? [{ name: 'description', content: project.description }]
    : [],
})
</script>

<style scoped>
.not-found {
  text-align: center;
  padding: 6rem 1.5rem;
}

.not-found h1 {
  margin-bottom: 1.5rem;
}
</style>
