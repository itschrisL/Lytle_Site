<template>
  <div class="page about-page">
    <UiSectionHeading subtitle="The intersection of code, business, and building things that matter.">
      About Me
    </UiSectionHeading>

    <div class="about-content">
      <div class="about-text">
        <p>
          I'm Chris Lytle — a software developer, sales engineer, and startup-experienced builder.
          I've spent my career working at the intersection of technology and business, building products
          that solve real problems and helping teams communicate the value of what they've built.
        </p>
        <p>
          My background in sales engineering gives me a unique edge: I don't just build software —
          I understand how users think, how businesses operate, and how to bridge the gap between
          technical capability and real-world impact.
        </p>
        <p>
          Whether it's architecting a backend service, building a polished frontend experience,
          or running a product demo for a key prospect, I bring the same energy: ship something
          that works, iterate based on feedback, and keep the user at the center.
        </p>
      </div>

      <div class="about-highlights">
        <div class="highlight">
          <h3>Developer</h3>
          <p>Full-stack experience spanning Python, JavaScript/TypeScript, Vue, FastAPI, and cloud infrastructure.</p>
        </div>
        <div class="highlight">
          <h3>Sales Engineer</h3>
          <p>Technical storytelling, live demos, POC builds, and translating complex products for business audiences.</p>
        </div>
        <div class="highlight">
          <h3>Startup Builder</h3>
          <p>Hands-on experience in early-stage environments — product ideation, rapid prototyping, and go-to-market.</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
useSeoMeta({
  title: 'About — Chris Lytle',
  description: 'Learn about Chris Lytle — software developer, sales engineer, and startup builder based in the Bay Area.',
  ogTitle: 'About — Chris Lytle',
  ogDescription: 'Learn about Chris Lytle — software developer, sales engineer, and startup builder based in the Bay Area.',
  ogImage: '/og-image.png',
  twitterCard: 'summary_large_image',
})
</script>

<style scoped>
.about-page {
  max-width: var(--max-width-narrow);
  margin: 0 auto;
  padding: 3rem 1.5rem;
}

.about-text p {
  font-size: 1.1rem;
  line-height: 1.8;
  color: var(--color-text-muted);
  margin-bottom: 1.25rem;
}

.about-highlights {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 1.5rem;
  margin-top: 3rem;
}

.highlight {
  padding: 1.5rem;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
}

.highlight h3 {
  font-size: 1.1rem;
  font-weight: 600;
  margin: 0 0 0.5rem;
  color: var(--color-primary);
}

.highlight p {
  font-size: 0.95rem;
  color: var(--color-text-muted);
  line-height: 1.6;
  margin: 0;
}
</style>
