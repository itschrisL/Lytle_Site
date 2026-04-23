<!--
██╗  ██╗   ██╗████████╗██╗     ███████╗
██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
██║   ╚████╔╝    ██║   ██║     █████╗
██║    ╚██╔╝     ██║   ██║     ██╔══╝
███████╗██║      ██║   ███████╗███████╗
╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝
-->
<template>
  <article class="page blog-post">
    <div class="post-header">
      <div class="post-meta">
        <time :datetime="article.date" class="post-date">{{ formatDate(article.date) }}</time>
        <div class="post-tags">
          <span v-for="tag in article.tags" :key="tag" class="tag">{{ tag }}</span>
        </div>
      </div>
      <h1 class="post-title">{{ article.title }}</h1>
      <p class="post-summary">{{ article.summary }}</p>
    </div>

    <div class="post-body">
      <p v-for="(para, i) in article.content" :key="i" class="post-paragraph">
        {{ para }}
      </p>
    </div>

    <div class="post-footer">
      <UiBaseButton to="/blog" variant="secondary">← Back to Blog</UiBaseButton>
    </div>
  </article>
</template>

<script setup lang="ts">
import articles from '~/content/articles.json'

const route = useRoute()
const article = articles.find(a => a.slug === route.params.slug)

if (!article) {
  throw createError({ statusCode: 404, statusMessage: 'Article not found' })
}

useSeoMeta({
  title: `${article.title} — Chris Lytle`,
  description: article.summary,
  ogTitle: `${article.title} — Chris Lytle`,
  ogDescription: article.summary,
  ogImage: '/og-image.png',
  twitterCard: 'summary_large_image',
  twitterTitle: `${article.title} — Chris Lytle`,
  twitterDescription: article.summary,
})

function formatDate(iso: string): string {
  return new Date(iso).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}
</script>

<style scoped>
.blog-post {
  max-width: var(--max-width-narrow);
  margin: 0 auto;
  padding: 3rem 1.5rem;
}

.post-header {
  margin-bottom: 3rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid var(--color-border);
}

.post-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
  margin-bottom: 1.25rem;
}

.post-date {
  font-size: 0.875rem;
  color: var(--color-text-muted);
}

.post-tags {
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

.post-title {
  font-size: 2rem;
  font-weight: 800;
  line-height: 1.25;
  color: var(--color-text);
  margin: 0 0 1rem;
}

.post-summary {
  font-size: 1.15rem;
  color: var(--color-text-muted);
  line-height: 1.7;
  margin: 0;
  font-style: italic;
}

.post-body {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.post-paragraph {
  font-size: 1.05rem;
  line-height: 1.85;
  color: var(--color-text);
  margin: 0;
}

.post-footer {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 1px solid var(--color-border);
}

@media (max-width: 640px) {
  .post-title {
    font-size: 1.5rem;
  }
}
</style>
