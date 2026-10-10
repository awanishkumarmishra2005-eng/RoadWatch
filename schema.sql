-- Run this in Supabase -> SQL Editor

create table if not exists reports (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),
  lat double precision not null,
  lng double precision not null,
  type text not null,
  severity text not null check (severity in ('Low','Medium','High')),
  description text,
  image_url text,
  status text not null default 'Reported' check (status in ('Reported','In Progress','Fixed')),
  upvotes int not null default 0
);

alter table reports enable row level security;

-- Hackathon-level policies: anyone can read, add and update.
-- For production, restrict UPDATE to authenticated admins.
create policy "read reports"   on reports for select using (true);
create policy "insert reports" on reports for insert with check (true);
create policy "update reports" on reports for update using (true);

-- Safe increment for "Confirm" votes
create or replace function upvote(rid uuid) returns void
language sql security definer as $$
  update reports set upvotes = upvotes + 1 where id = rid;
$$;

-- Public bucket for photos
insert into storage.buckets (id, name, public) values ('road-photos', 'road-photos', true)
on conflict (id) do nothing;

create policy "upload photos" on storage.objects for insert with check (bucket_id = 'road-photos');
create policy "view photos"   on storage.objects for select using (bucket_id = 'road-photos');
