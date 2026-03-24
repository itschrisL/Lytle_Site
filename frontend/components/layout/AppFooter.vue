<template>
  <footer class="site-footer">
    <div class="footer-inner">
      <div class="footer-left">
        <p>&copy; {{ year }} Chris Lytle. All rights reserved.</p>
      </div>
      <div class="footer-right">
        <UiSocialLinks />
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
const year = new Date().getFullYear()
</script>

<style scoped>
.site-footer {
  border-top: 1px solid var(--color-border);
  padding: 2rem 1.5rem;
  margin-top: 4rem;
}

.footer-inner {
  max-width: var(--max-width);
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
}

.footer-left p {
  color: var(--color-text-muted);
  font-size: 0.875rem;
  margin: 0;
}

@media (max-width: 480px) {
  .footer-inner {
    flex-direction: column;
    text-align: center;
  }
}
</style>
