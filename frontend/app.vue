<template>
  <div id="app">
    <LayoutAppHeader />
    <main>
      <NuxtPage />
    </main>
    <LayoutAppFooter />
  </div>
</template>

<script setup lang="ts">
  const { init } = useDyslexicFont()
  onMounted(init)
</script>
