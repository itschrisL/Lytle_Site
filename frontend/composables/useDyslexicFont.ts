/*
██╗  ██╗   ██╗████████╗██╗     ███████╗
██║  ╚██╗ ██╔╝╚══██╔══╝██║     ██╔════╝
██║   ╚████╔╝    ██║   ██║     █████╗
██║    ╚██╔╝     ██║   ██║     ██╔══╝
███████╗██║      ██║   ███████╗███████╗
╚══════╝╚═╝      ╚═╝   ╚══════╝╚══════╝
*/

// useDyslexicFont — toggling fonts since the brain decided letters should stop spinning
const STORAGE_KEY = 'dyslexicFont'
const HTML_CLASS = 'dyslexic-font'

export const useDyslexicFont = () => {
  const isDyslexic = useState<boolean>('dyslexicFont', () => false)

  function apply(value: boolean) {
    isDyslexic.value = value
    if (import.meta.client) {
      document.documentElement.classList.toggle(HTML_CLASS, value)
      localStorage.setItem(STORAGE_KEY, value ? '1' : '0')
    }
  }

  function toggle() {
    apply(!isDyslexic.value)
  }

  function init() {
    const saved = localStorage.getItem(STORAGE_KEY)
    if (saved === '1') {
      apply(true)
    }
  }

  return { isDyslexic: readonly(isDyslexic), toggle, init }
}
