-- Run after reviewing in the Nightout production Supabase SQL editor.
-- This table is separate from Nightout data. The public key can only insert;
-- it cannot read, update, or delete reservations.
create table if not exists public.quietus_preorders (
  id bigint generated always as identity primary key,
  email text not null check (char_length(email) <= 254 and email ~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'),
  created_at timestamptz not null default now()
);
alter table public.quietus_preorders enable row level security;
grant usage on schema public to anon;
grant insert (email) on public.quietus_preorders to anon;
grant usage on sequence public.quietus_preorders_id_seq to anon;
create policy "Allow Quietus reservations" on public.quietus_preorders for insert to anon with check (true);

