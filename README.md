# Quietus preorder

A separate Nuxt project for the Quietus early-access list, ready for Vercel.

## Setup

1. Run `npm install` and copy `.env.example` to `.env`.
2. Set `NUXT_SUPABASE_URL` and `NUXT_SUPABASE_ANON_KEY` to the Nightout production project's URL and publishable/anon key. Do not use a service-role key.
3. Review and run `supabase/quietus_preorders.sql` in that project's SQL editor. This creates one new table and an insert-only policy; it does not modify Nightout tables. The policy allows anonymous public inserts, so add abuse protection before a high-traffic launch.
4. Run `npm run dev` locally. On Vercel, import this project, select Nuxt, and set the same environment variables before deploying.

The form collects email interest only. It does not accept payment or create a binding purchase. Replace placeholder product copy and illustration after product details are confirmed. The SQL is intended to be run once.
