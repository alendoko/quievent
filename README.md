# QUIEVENT interest list

QUIEVENT is a separate Nuxt project using the Nightout production Supabase project for one signup table.

1. Review and run `supabase/quievent_interest.sql` in the SQL Editor of the correct Supabase project. It creates a new table with insert-only access for anonymous visitors; the database administrator can view signups in the dashboard.
2. In the QUIEVENT Vercel project, set `NUXT_SUPABASE_URL` and `NUXT_SUPABASE_ANON_KEY` to the project URL and publishable/anon key. Never use the service-role key for this integration.
3. Redeploy after changing environment variables. The same variables may be placed in a local `.env` for development.
4. Test a signup with an address you control, verify it appears in `quievent_interest`, then remove the test row from the dashboard if desired. Verify public reads and updates are denied.

The form records non-binding interest; it does not accept payment. The table permits anonymous inserts directly through Supabase, so it does not include effective rate limiting or bot protection. Add an appropriate server-side abuse-control system before expecting significant traffic.
