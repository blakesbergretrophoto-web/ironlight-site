# Studio site: setup notes

A single static page (`index.html`) with no build step. It's ready for Cloudflare Pages.

## Deploy
1. Create a GitHub repo and add `index.html` (plus an `img/` folder for photos).
2. In Cloudflare, go to Workers & Pages → Create → Pages → Connect to Git and pick the repo.
   Leave the framework preset at **None**, the build command blank and the output directory at `/`.
3. Add your custom domain under the project's Custom domains tab.

## What to swap in (search the file for `EDIT`)
- **Name:** replace "Studio Name" (title tag, nav, footer).
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
