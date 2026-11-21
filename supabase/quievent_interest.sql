-- Run once in the nightout-prod SQL editor, after verifying the selected project.
-- This creates only a QUIEVENT table. An existing table with this name causes an error.
begin;
create table public.quievent_interest (
  id uuid primary key default gen_random_uuid(),
  email text not null check (char_length(email) <= 254 and email ~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'),
  created_at timestamptz not null default now()
);
alter table public.quievent_interest enable row level security;
revoke all on table public.quievent_interest from anon, authenticated;
grant usage on schema public to anon;
grant insert (email) on public.quievent_interest to anon;
create policy "QUIEVENT public interest signup" on public.quievent_interest
  for insert to anon with check (true);
commit;
