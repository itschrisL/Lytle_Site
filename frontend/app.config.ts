/*
██╗  ██╗   ██╗████████╗██╗     ███████╗
██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
██║   ╚████╔╝    ██║   ██║     █████╗
██║    ╚██╔╝     ██║   ██║     ██╔══╝
███████╗██║      ██║   ███████╗███████╗
╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝
*/

// app.config.ts — single source of truth for site-wide constants.
// Auto-imported by Nuxt everywhere via useAppConfig(). No imports needed.
// ⚠️  Everything here is PUBLIC (bundled into the client). Never put secrets here.

export default defineAppConfig({
  // Personal info
  author: {
    name: 'Chris Lytle',
    email: 'chris97lytle@gmail.com',
    location: 'Bay Area, California',
  },

  // Social / contact links — referenced by SocialLinks.vue, contact banner, etc.
  social: {
    github: 'https://github.com/itschrisL',
    linkedin: 'https://www.linkedin.com/in/christopherslytle/',
    email: 'chris97lytle@gmail.com',
  },

  // Site metadata
  site: {
    title: 'Chris Lytle — Software Developer, Sales Engineer, Startup Builder',
    description: 'Professional portfolio of Chris Lytle — Software Developer, Sales Engineer, and startup-experienced builder.',
    url: 'https://chrislytle.dev', // update when you have your domain
  },

  // Resume download path (relative to /public)
  resumePath: '/Chris_Lytle_Resume.pdf',
})
