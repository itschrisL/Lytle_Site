<template>
  <section class="featured-projects">
    <div class="featured-projects__inner">
      <UiSectionHeading subtitle="A selection of things I've built and shipped.">
        Featured Projects
      </UiSectionHeading>
      <div class="projects-grid">
        <ProjectsProjectCard
          v-for="project in featured"
          :key="project.slug"
          :project="project"
        />
      </div>
      <div class="featured-projects__more">
        <UiBaseButton to="/projects" variant="secondary">View All Projects</UiBaseButton>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import projects from '~/content/projects.json'

const featured = projects.filter(p => p.featured).slice(0, 3)
</script>

<style scoped>
.featured-projects {
  padding: 4rem 1.5rem;
  max-width: var(--max-width);
  margin: 0 auto;
}

.projects-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 1.5rem;
}

.featured-projects__more {
  text-align: center;
  margin-top: 2.5rem;
}
</style>
