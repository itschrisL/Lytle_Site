// Composable template
// File: frontend/composables/use<Name>.ts
//
// Naming rules:
//   - File name: use<PascalCase>.ts
//   - Always return named exports (not a single object)
//   - Use useState() for SSR-safe global state shared across components
//   - Use ref() / reactive() for local state recreated per call
//
// See: docs/knowledge-base/codebase/conventions.md

// For composables that call the backend API:
// const config = useRuntimeConfig()
// const apiBase = config.public.apiBase  → e.g. http://localhost:8000

// --- State ---
// Replace with useState for global/SSR-safe state, or ref for local state
// const value = useState<string>('unique-key', () => '')

// --- Actions ---
// const doSomething = () => {
//   // implementation
// }

// --- Exports ---
// export function use<Name>() {
//   return {
//     value,
//     doSomething,
//   }
// }
