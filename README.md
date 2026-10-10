# RoadWatch – Road Damage Reporting System

Citizens drop a pin on a map, pick severity, add a photo and submit. Others can confirm a report. Authorities open `/?admin=1` to change status (Reported → In Progress → Fixed).

## Files
- `index.html` – the whole app (HTML + CSS + JS)
- `schema.sql` – Supabase table, policies, photo bucket
- Works with no setup in **demo mode** (data stays in your browser) until you add Supabase keys.

## 1. Supabase setup (5 min)
1. Create a project at supabase.com.
2. SQL Editor → paste `schema.sql` → Run.
3. Project Settings → API → copy **Project URL** and **anon public key**.
4. Paste them into `SUPABASE_URL` and `SUPABASE_KEY` at the top of the script in `index.html`.

## 2. Deploy on Vercel
**Option A – GitHub (recommended)**
1. Create a GitHub repo and push this folder (`index.html` at the root).
2. Go to vercel.com → Add New → Project → import the repo.
3. Framework Preset: **Other**. Leave Build Command and Output Directory empty. Click Deploy.
4. Open the `*.vercel.app` URL. Every `git push` redeploys automatically.

**Option B – CLI**
```
npm i -g vercel
cd roadwatch
vercel        # follow prompts, accept defaults
vercel --prod
```

## Notes
- The anon key is meant to be public; security comes from the RLS policies in `schema.sql`.
- Geolocation needs HTTPS, which Vercel provides.
- Admin mode is open to anyone who knows `?admin=1`. Fine for a demo; add Supabase Auth for production.
