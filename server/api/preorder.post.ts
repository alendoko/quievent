export default defineEventHandler(async (event) => {
  const body = await readBody(event).catch(() => null)
  const email = typeof body?.email === 'string' ? body.email.trim().toLowerCase() : ''
  if (!email || email.length > 254 || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    throw createError({ statusCode: 400, statusMessage: 'Please enter a valid email address.' })
  }
  const config = useRuntimeConfig()
  if (!config.supabaseUrl || !config.supabaseAnonKey) {
    throw createError({ statusCode: 503, statusMessage: 'Reservations are not available yet. Please try again later.' })
  }
  try {
    await $fetch(`${config.supabaseUrl.replace(/\/$/, '')}/rest/v1/quietus_preorders`, {
      method: 'POST',
      headers: { apikey: config.supabaseAnonKey, Authorization: `Bearer ${config.supabaseAnonKey}`, Prefer: 'return=minimal' },
      body: { email }
    })
  } catch {
    throw createError({ statusCode: 503, statusMessage: 'We could not save your reservation. Please try again later.' })
  }
  return { ok: true }
})
