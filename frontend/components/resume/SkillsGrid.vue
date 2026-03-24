<template>
  <div class="skills-grid">
    <div v-for="category in skills" :key="category.category" class="skills-grid__group">
      <h3 class="skills-grid__category">{{ category.category }}</h3>
      <div class="skills-grid__tags">
        <span v-for="skill in category.items" :key="skill" class="skill-tag">{{ skill }}</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import skills from '~/content/skills.json'
</script>

<style scoped>
.skills-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 2rem;
}

.skills-grid__category {
  font-size: 1rem;
  font-weight: 600;
  margin: 0 0 0.75rem;
  color: var(--color-text);
}

.skills-grid__tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.skill-tag {
  font-size: 0.85rem;
  padding: 0.3rem 0.85rem;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: 999px;
  color: var(--color-text-muted);
  font-weight: 500;
}
</style>
