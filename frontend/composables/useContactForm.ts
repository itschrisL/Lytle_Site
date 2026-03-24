export function useContactForm() {
  const config = useRuntimeConfig()

  const form = reactive({
    name: '',
    email: '',
    message: '',
  })

  const loading = ref(false)
  const error = ref('')
  const success = ref(false)

  async function handleSubmit() {
    loading.value = true
    error.value = ''
    success.value = false

    try {
      const response = await $fetch(`${config.public.apiBase}/api/contact`, {
        method: 'POST',
        body: {
          name: form.name,
          email: form.email,
          message: form.message,
        },
      })

      success.value = true
      form.name = ''
      form.email = ''
      form.message = ''
    } catch (e: any) {
      error.value = e?.data?.detail || 'Something went wrong. Please try again.'
    } finally {
      loading.value = false
    }
  }

  return { form, loading, error, success, handleSubmit }
}
