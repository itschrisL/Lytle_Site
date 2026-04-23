<template>
  <div class="page resume-page">
    <UiSectionHeading subtitle="A snapshot of my career, skills, and experience.">
      Resume
    </UiSectionHeading>

    <section class="resume-section">
      <h2>Experience</h2>
      <ResumeExperienceTimeline />
    </section>

    <section class="resume-section">
      <h2>Skills</h2>
      <ResumeSkillsGrid />
    </section>

    <ResumeDownloadResume />
  </div>
</template>

<script setup lang="ts">
useSeoMeta({
  title: 'Resume — Chris Lytle',
  description: 'Resume and professional experience of Chris Lytle — software developer, sales engineer, and startup builder.',
  ogTitle: 'Resume — Chris Lytle',
  ogDescription: 'Resume and professional experience of Chris Lytle — software developer, sales engineer, and startup builder.',
  ogImage: '/og-image.png',
  twitterCard: 'summary_large_image',
})
</script>

<style scoped>
.resume-page {
  max-width: var(--max-width-narrow);
  margin: 0 auto;
  padding: 3rem 1.5rem;
}

.resume-section {
  margin-bottom: 3rem;
}

.resume-section h2 {
  font-size: 1.5rem;
  font-weight: 700;
  margin: 0 0 1.5rem;
  color: var(--color-text);
}
</style>
