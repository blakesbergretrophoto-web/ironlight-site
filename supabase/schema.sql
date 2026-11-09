-- Run once in Supabase: SQL Editor → New query → paste → Run
create table if not exists public.leads (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz not null default now(),
  name        text not null check (char_length(name) between 1 and 200),
  email       text not null check (char_length(email) between 3 and 320),
  company     text check (char_length(company) <= 200),
  service     text check (char_length(service) <= 100),
  budget      text check (char_length(budget) <= 100),
  message     text check (char_length(message) <= 4000),
  source      text check (char_length(source) <= 500)
);

alter table public.leads enable row level security;

-- Website visitors can submit a lead, but nobody can read, edit or delete
-- leads through the public key. You view them in the Supabase dashboard.
drop policy if exists "Public can submit leads" on public.leads;
create policy "Public can submit leads"
  on public.leads for insert to anon
  with check (true);

grant insert on public.leads to anon;
