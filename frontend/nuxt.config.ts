// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },

  app: {
    head: {
      charset: 'utf-8',
      viewport: 'width=device-width, initial-scale=1',
      title: 'Chris Lytle — Software Developer, Sales Engineer, Startup Builder',
      meta: [
        { name: 'description', content: 'Professional portfolio of Chris Lytle — Software Developer, Sales Engineer, and startup-experienced builder.' },
        { property: 'og:title', content: 'Chris Lytle — Software Developer, Sales Engineer, Startup Builder' },
        { property: 'og:description', content: 'Professional portfolio of Chris Lytle — Software Developer, Sales Engineer, and startup-experienced builder.' },
        { property: 'og:image', content: '/og-image.png' },
        { property: 'og:type', content: 'website' },
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' },
        { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap' },
      ],
    },
  },

  css: ['~/assets/css/main.css'],

  runtimeConfig: {
    public: {
      apiBase: process.env.NUXT_PUBLIC_API_BASE || 'http://localhost:8000',
    },
  },

  routeRules: {
    '/api/**': { proxy: process.env.NUXT_PUBLIC_API_BASE || 'http://localhost:8000/**' },
  },

  compatibilityDate: '2025-01-01',
})
