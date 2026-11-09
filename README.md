# Studio site: setup notes

A single static page (`index.html`) with no build step. It's ready for Cloudflare Pages.

## Deploy (GitHub → Cloudflare Pages)
1. Push this folder to a GitHub repo.
2. In Cloudflare, go to Workers & Pages → Create → Pages → Connect to Git and pick the repo.
   Leave the framework preset at **None**, the build command blank and the output directory at `/`.
3. Every push to `main` now redeploys the site automatically.
4. Add your custom domain under the project's Custom domains tab.

## Lead form (Supabase)
1. Create a Supabase project. Open SQL Editor, paste `supabase/schema.sql` and run it.
2. Copy the Project URL and the anon (publishable) key from Project Settings → API.
   Paste them into `SUPABASE_URL` and `SUPABASE_ANON_KEY` near the bottom of `index.html`.
   Never paste the service_role or secret key into the site.
3. Submissions land in the `leads` table (Table Editor → leads).
4. Optional email alerts: Database → Webhooks → on insert into `leads`, send to Zapier, Make or your CRM.

## What to swap in (search the file for `EDIT`)
- **Name:** replace "Ironlight" (title tag, nav, footer).
- **Hero loop:** a 15–30 s muted MP4 from Cloudflare Stream or Vimeo. Keep it under ~8 MB.
- **Films:** put the Vimeo ID (the number in the URL) in each `data-video="..."` attribute.
- **Stills and photos:** replace each `<div class="placeholder">` with `<img src="img/....jpg" alt="...">`.
  Export at 2000px wide max, as WebP or JPG at ~80% quality. Keep video files out of the repo.
- **Prices:** the `From $X,XXX` lines in Packages.
- **Clients strip:** only list clients you're allowed to name publicly.
- **Calendar:** paste your Calendly or Cal.com link into `CALENDAR_URL` near the bottom.
- **Email, city and socials:** in Book, FAQ and the footer.

## Booking calendar setup (Calendly or Cal.com)
Create one event type:
- **Name:** Discovery Call, 30 min, with an auto-generated Zoom or Google Meet link
- **Buffers:** 15 min before and after. Minimum notice: 24 hrs.
- **Connect** your Google Calendar so busy times are blocked.
- **Intake questions:**
  1. Company name and website (required)
  2. What's the story you want to tell? (required)
  3. What do you need? Brand film / Photography / Both / Not sure
  4. Is there a deadline we should know about?
  5. Budget range: Under $5k / $5–10k / $10–25k / $25k+ / Not sure yet. Adjust the ranges to your pricing.
- **Reminders:** email 24 hrs before and 1 hr before
