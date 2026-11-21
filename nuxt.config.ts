export default defineNuxtConfig({
  compatibilityDate: '2025-05-15',
  runtimeConfig: { supabaseUrl: '', supabaseAnonKey: '' },
  app: { head: { title: 'Quietus — A quieter kind of cool', meta: [{ name: 'description', content: 'Be among the first to hear about the Quietus cooling pad.' }, { name: 'viewport', content: 'width=device-width, initial-scale=1' }] } }
})
