# Launch guide

Follow these steps in order. Each one ends with a check, so you know it worked before moving on.
Plan on about an hour, not counting writing copy.

---

## Step 0: Get the project onto your computer
1. Download `studio-site.zip` and unzip it somewhere permanent, like `~/Projects/studio-site`.
2. Open Terminal and go to the folder:
   ```
   cd ~/Projects/studio-site
   ```
3. Start Claude Code in that folder:
   ```
   claude
   ```
4. Paste in the kickoff prompt from the bottom of this file. From there, Claude Code can run every command below for you.

✅ **Check:** `git log --oneline` shows two commits.

---

## Step 1: Put the code on GitHub
1. Go to github.com → **New repository**.
   - Name: `studio-site`. You can rename it once you have a business name.
   - Visibility: **Private** is fine. Cloudflare can still deploy it.
   - **Don't** add a README, .gitignore or license. The repo has to be empty.
2. Copy the repo URL and run:
   ```
   git remote add origin https://github.com/YOUR-USERNAME/studio-site.git
   git push -u origin main
   ```
   If you have the GitHub CLI installed, this one command does both steps:
   `gh repo create studio-site --private --source=. --push`

✅ **Check:** refresh the repo page on GitHub. You should see `index.html`, `README.md`, `LAUNCH.md` and the `supabase` folder.

---

## Step 2: Set up Supabase for the lead form
1. Go to supabase.com → **New project**.
   - Name: `studio-site`
   - Database password: generate one and save it in your password manager
   - Region: the one closest to you (West US for Denver)
   - Wait about 2 minutes for it to finish setting up.
2. Left sidebar → **SQL Editor** → **New query**. Paste the full contents of `supabase/schema.sql` → **Run**.
   You should see "Success. No rows returned."
3. Left sidebar → **Project Settings** → **API**. Copy two values:
   - **Project URL**, which looks like `https://abcdxyz.supabase.co`
   - The **anon / publishable** key, a long string
   - ⚠️ Never use the `service_role` or secret key on the website.
4. Open `index.html`, scroll to the `SETTINGS` block near the bottom, and paste them in:
   ```js
   const SUPABASE_URL = "https://abcdxyz.supabase.co";
   const SUPABASE_ANON_KEY = "eyJhbGciOi...";
   ```
5. Commit and push:
   ```
   git add -A && git commit -m "Connect lead form to Supabase" && git push
   ```

✅ **Check:** do this after Step 3, once the site is live. Submit the form with your own details, then open Supabase → **Table Editor** → `leads`. Your row should be there.

**Optional email alerts for new leads:** Supabase → **Database** → **Webhooks** → Create. Choose table `leads`, event **Insert**, and point it at a Zapier or Make webhook that emails you. Your friend may want to send these into the funnel or CRM instead.

---

## Step 3: Go live on Cloudflare Pages
1. Go to dash.cloudflare.com and create a free account if you don't have one.
2. **Workers & Pages** → **Create** → the **Pages** tab → **Connect to Git**.
3. Authorize GitHub, then pick the `studio-site` repo.
4. Build settings:
   - Framework preset: **None**
   - Build command: *(leave empty)*
   - Build output directory: `/`
5. Click **Save and Deploy**. It takes under a minute.

✅ **Check:** open the `https://studio-site.pages.dev` link Cloudflare gives you. The site should load, and clicking a film tile should play it.

From now on, **every `git push` updates the live site automatically** in about 30 seconds.

---

## Step 4: Set up the booking calendar
Calendly and Cal.com both work. Cal.com's free plan allows more customization.
1. Create an event type:
   - Name: **Discovery Call**, 30 minutes
   - Location: Zoom or Google Meet, with links auto-generated
   - Buffers: 15 minutes before and after. Minimum notice: 24 hours.
   - Connect your Google Calendar so busy times are blocked.
2. Add these intake questions:
   1. Company name and website (required)
   2. What's the story you want to tell? (required)
   3. What do you need? Brand film / Photography / Both / Full brand refresh / Not sure
   4. Is there a deadline we should know about?
   5. Budget range: Under $5k / $5–10k / $10–25k / $25k+ / Not sure yet
3. Copy the event link and paste it into `index.html`:
   ```js
   const CALENDAR_URL = "https://calendly.com/yourname/discovery-call";
   ```
4. Commit and push.

✅ **Check:** the "Tell us your story" section on the live site shows your calendar, and you can book a test call.

---

## Step 5: Fill in the placeholders
Ask Claude Code: *"Find every placeholder in index.html and list them."* It will find all of these:

| What | Where |
|---|---|
| Business name | "Studio Name" in the title, nav and footer |
| Prices | `From $X,XXX` in Packages |
| Turnaround times | `[X] days`, `[2] weeks` in the selling points, Packages and FAQ |
| Film descriptions | `[One line on the story…]` under each film, plus the Pepsi write-up |
| Hero loop | the 15–30 second muted MP4 at the top of the page |
| Reel button | `REEL_VIMEO_ID` (or point it at the Pepsi film for now) |
| Team | names, roles, photos and the About paragraph |
| Contact | `hello@yourdomain.com` (in 4 places), `[City, State]`, social links |
| Photos | the gray placeholder boxes in the Photo section |

**Adding photos:** make an `img/` folder, export each photo at 2000px wide or less as JPG or WebP, and tell Claude Code which file goes where.
**The hero loop:** upload it to Vimeo or Cloudflare Stream and use the direct MP4 link. Never put video files in the repo.

---

## Step 6: Connect your domain (once you have a name)
1. Buy the domain. Cloudflare Registrar sells domains at cost: Cloudflare → **Domain Registration** → **Register Domains**.
2. Your Pages project → **Custom domains** → **Set up a custom domain** → enter `yourdomain.com`. Add `www.yourdomain.com` too.
3. Wait 5–30 minutes for HTTPS to switch on.
4. On each Vimeo video, set **Privacy → Where can this be embedded?** to **Specific domains** and add your domain. That stops other sites from embedding your work.
5. Set up a professional email (Google Workspace or Cloudflare Email Routing) so `hello@yourdomain.com` reaches you.

✅ **Check:** `https://yourdomain.com` loads with the padlock icon in the browser.

---

## Step 7: Pre-launch checklist
- [ ] Every film plays on desktop **and** phone
- [ ] The form submits and the row shows up in Supabase
- [ ] You can book a test call on the calendar
- [ ] No "Studio Name", `[brackets]` or `X,XXX` left anywhere
- [ ] You have permission to show the work and name each client (Pepsi, and Caterpillar once it's approved)
- [ ] You've added a share image (`og:image`) so links look good in texts, Slack and LinkedIn
- [ ] Your friend has what he needs for SEO and analytics. Cloudflare Web Analytics is free: Pages project → **Metrics**.

---

## Kickoff prompt for Claude Code
Paste this when you start Claude Code in the project folder:

> This is the website for my new video and photo production business: brand films, photography, and website and social refreshes for companies. It's a single static `index.html` hosted on Cloudflare Pages from GitHub, with a lead form that saves to a Supabase `leads` table (schema in `supabase/schema.sql`). Read `README.md` and `LAUNCH.md` first. I'm following LAUNCH.md step by step, so walk me through it one step at a time, run the git commands for me, and wait for me to confirm each check before moving on. Keep the existing design (Archivo and Newsreader fonts, concrete/ink/steel/ochre palette, letterbox video frames). Never commit video files or any Supabase secret/service_role key.
