<!--
██╗  ██╗   ██╗████████╗██╗     ███████╗
██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
██║   ╚████╔╝    ██║   ██║     █████╗
██║    ╚██╔╝     ██║   ██║     ██╔══╝
███████╗██║      ██║   ███████╗███████╗
╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝
-->
<template>
  <div class="page blog-page">
    <UiSectionHeading subtitle="Thoughts on software, sales engineering, and building things.">
      Blog
    </UiSectionHeading>

    <div class="articles-list">
      <NuxtLink
        v-for="article in articles"
        :key="article.slug"
        :to="`/blog/${article.slug}`"
        class="article-card"
      >
        <div class="article-meta">
          <time :datetime="article.date" class="article-date">{{ formatDate(article.date) }}</time>
          <div class="article-tags">
            <span v-for="tag in article.tags" :key="tag" class="tag">{{ tag }}</span>
          </div>
        </div>
        <h2 class="article-title">{{ article.title }}</h2>
        <p class="article-summary">{{ article.summary }}</p>
        <span class="read-more">Read more →</span>
      </NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
import articles from '~/content/articles.json'

useSeoMeta({
  title: 'Blog — Chris Lytle',
  description: 'Thoughts on software development, sales engineering, and building things from Chris Lytle.',
  ogTitle: 'Blog — Chris Lytle',
  ogDescription: 'Thoughts on software development, sales engineering, and building things from Chris Lytle.',
  ogImage: '/og-image.png',
  twitterCard: 'summary_large_image',
})

function formatDate(iso: string): string {
  return new Date(iso).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}
</script>

<style scoped>
.blog-page {
  max-width: var(--max-width-narrow);
  margin: 0 auto;
  padding: 3rem 1.5rem;
}

.articles-list {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.article-card {
  display: block;
  padding: 2rem;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  text-decoration: none;
  color: inherit;
  transition: border-color 0.2s, box-shadow 0.2s, transform 0.2s;
}

.article-card:hover {
  border-color: var(--color-primary);
  box-shadow: 0 4px 16px var(--color-shadow);
  transform: translateY(-2px);
}

.article-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
  margin-bottom: 0.75rem;
}

.article-date {
  font-size: 0.875rem;
  color: var(--color-text-muted);
}

.article-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.tag {
  font-size: 0.75rem;
  padding: 0.2rem 0.6rem;
  background: color-mix(in srgb, var(--color-primary) 12%, var(--color-surface));
  color: var(--color-primary);
  border-radius: 999px;
  font-weight: 500;
}

.article-title {
  font-size: 1.35rem;
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 0.75rem;
  line-height: 1.3;
}

.article-summary {
  font-size: 1rem;
  color: var(--color-text-muted);
  line-height: 1.7;
  margin: 0 0 1.25rem;
}

.read-more {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--color-primary);
}
</style>
