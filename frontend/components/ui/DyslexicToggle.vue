<!--
██╗  ██╗   ██╗████████╗██╗     ███████╗
██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
██║   ╚████╔╝    ██║   ██║     █████╗
██║    ╚██╔╝     ██║   ██║     ██╔══╝
███████╗██║      ██║   ███████╗███████╗
╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝
-->
<template>
  <button
    class="dyslexic-toggle"
    :class="{ active: isDyslexic }"
    :aria-label="isDyslexic ? 'Disable dyslexic font' : 'Enable dyslexic font'"
    :aria-pressed="isDyslexic"
    :title="isDyslexic ? 'Disable dyslexic font' : 'Enable dyslexic font'"
    @click="toggle"
  >
    <!-- Letter A — because fonts are just letters doing their best -->
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2.5"
      stroke-linecap="round"
      stroke-linejoin="round"
      aria-hidden="true"
    >
      <path d="M4 20L12 4L20 20" />
      <path d="M7 14H17" />
    </svg>
  </button>
</template>

<script setup lang="ts">
const { isDyslexic, toggle } = useDyslexicFont()
</script>

<style scoped>
.dyslexic-toggle {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  background: var(--color-surface);
  color: var(--color-text-muted);
  cursor: pointer;
  transition: color 0.2s, border-color 0.2s, background 0.2s;
}

.dyslexic-toggle:hover {
  color: var(--color-primary);
  border-color: var(--color-primary);
}

.dyslexic-toggle.active {
  color: var(--color-primary);
  border-color: var(--color-primary);
  background: color-mix(in srgb, var(--color-primary) 10%, var(--color-surface));
}
</style>
