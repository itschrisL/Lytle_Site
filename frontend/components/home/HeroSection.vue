<template>
  <section class="hero">
    <div class="hero__inner">
      <p class="hero__greeting">Hi, I'm</p>
      <h1 class="hero__name">Chris Lytle</h1>
      <p class="hero__tagline">
        Software Developer · Sales Engineer · Startup Builder
      </p>
      <p class="hero__description">
        I build products that bridge the gap between technology and business.
        With experience spanning software development, sales engineering, and early-stage startups,
        I bring a unique perspective to every project.
      </p>
      <div class="hero__actions">
        <UiBaseButton to="/projects">View My Work</UiBaseButton>
        <UiBaseButton to="/contact" variant="outline">Get in Touch</UiBaseButton>
      </div>
    </div>
  </section>
</template>

<style scoped>
.hero {
  padding: 6rem 1.5rem 4rem;
  max-width: var(--max-width);
  margin: 0 auto;
}

.hero__greeting {
  font-size: 1.1rem;
  color: var(--color-primary);
  font-weight: 600;
  margin: 0 0 0.5rem;
}

.hero__name {
  font-size: clamp(2.5rem, 6vw, 4rem);
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 1rem;
  line-height: 1.1;
}

.hero__tagline {
  font-size: 1.25rem;
  color: var(--color-text-muted);
  margin: 0 0 1.5rem;
  font-weight: 500;
}

.hero__description {
  font-size: 1.1rem;
  color: var(--color-text-muted);
  line-height: 1.7;
  max-width: 600px;
  margin: 0 0 2.5rem;
}

.hero__actions {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}
</style>
