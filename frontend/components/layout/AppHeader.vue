<template>
  <header class="site-header">
    <div class="header-inner">
      <NuxtLink to="/" class="logo">Chris Lytle</NuxtLink>
      <div class="header-actions">
        <nav :class="['main-nav', { open: menuOpen }]">
          <NuxtLink to="/" @click="menuOpen = false">Home</NuxtLink>
          <NuxtLink to="/about" @click="menuOpen = false">About</NuxtLink>
          <NuxtLink to="/projects" @click="menuOpen = false">Projects</NuxtLink>
          <NuxtLink to="/blog" @click="menuOpen = false">Blog</NuxtLink>
          <NuxtLink to="/resume" @click="menuOpen = false">Resume</NuxtLink>
          <NuxtLink to="/contact" class="nav-cta" @click="menuOpen = false">Contact</NuxtLink>
        </nav>
        <UiDyslexicToggle />
        <UiThemeToggle />
        <button
          class="mobile-toggle"
          :aria-expanded="menuOpen"
          aria-label="Toggle navigation"
          @click="menuOpen = !menuOpen"
        >
          <span class="hamburger" />
        </button>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
const menuOpen = ref(false)

const route = useRoute()
watch(() => route.path, () => { menuOpen.value = false })
</script>

<style scoped>
.site-header {
  position: sticky;
  top: 0;
  z-index: 100;
  background: var(--color-bg);
  border-bottom: 1px solid var(--color-border);
  backdrop-filter: blur(8px);
}

.header-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 1rem 1.5rem;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.logo {
  font-weight: 700;
  font-size: 1.25rem;
  color: var(--color-text);
  text-decoration: none;
}

.main-nav {
  display: flex;
  gap: 2rem;
  align-items: center;
}

.main-nav a {
  color: var(--color-text-muted);
  text-decoration: none;
  font-size: 0.95rem;
  font-weight: 500;
  transition: color 0.2s;
}

.main-nav a:hover,
.main-nav a.router-link-active {
  color: var(--color-primary);
}

.nav-cta {
  background: var(--color-primary);
  color: var(--color-bg) !important;
  padding: 0.5rem 1.25rem;
  border-radius: var(--radius);
  font-weight: 600;
}

.nav-cta:hover {
  opacity: 0.9;
}

.mobile-toggle {
  display: none;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0.5rem;
}

.hamburger,
.hamburger::before,
.hamburger::after {
  display: block;
  width: 24px;
  height: 2px;
  background: var(--color-text);
  position: relative;
  transition: 0.3s;
}

.hamburger::before,
.hamburger::after {
  content: '';
  position: absolute;
}

.hamburger::before { top: -7px; }
.hamburger::after  { top: 7px; }

@media (max-width: 768px) {
  .mobile-toggle {
    display: block;
  }

  .main-nav {
    display: none;
    flex-direction: column;
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: var(--color-bg);
    padding: 1rem 1.5rem;
    border-bottom: 1px solid var(--color-border);
    gap: 1rem;
  }

  .main-nav.open {
    display: flex;
  }

  .nav-cta {
    text-align: center;
  }
}
</style>
