---
name: cloudflare-pages-connect
description: Connect a webflow-code-kit GitHub repo to Cloudflare Pages using the Cloudflare REST API. Creates a Pages project linked to GitHub, sets main as production branch, creates and pushes the staging branch, and returns the staging and production URLs ready to paste into Webflow. Use when the user says "connect this repo to Cloudflare Pages", "set up deployment", "set up Cloudflare", or "connect to Pages".
---

# Cloudflare Pages Connect

## IMPORTANT

- **Cloudflare account ID (8020):** `5fb7b68caca59af162775b35cf591beb`
- **GitHub org:** `team8020`
- **API token source:** `CLOUDFLARE_API_TOKEN` in the project `.env` file (gitignored, never commit)
- This skill operates on a **webflow-code-kit** project repo. Run from inside that project directory.

---

## Process

### Phase 1 — Setup

1. Read `project.json` → get `cloudflareProjectName` and `clientName`.
2. Read `.env` → get `CLOUDFLARE_API_TOKEN`. If the key is missing:
   - Tell the user: "Add `CLOUDFLARE_API_TOKEN=your_token` to `.env`. Get the token from [Cloudflare Dashboard → My Profile → API Tokens](https://dash.cloudflare.com/profile/api-tokens). It needs **Cloudflare Pages: Edit** permission."
   - Do not proceed until the token is present.
3. Check `.env.example` — if `CLOUDFLARE_API_TOKEN=` is absent, add it (no value, just the key).
4. Confirm the current git remote is `https://github.com/team8020/<cloudflareProjectName>.git` (or SSH equivalent). The repo name must match `cloudflareProjectName` in `project.json`.

### Phase 2 — Preview & Confirm

Show the user:

```
About to create:
  Cloudflare Pages project: <cloudflareProjectName>
  GitHub repo:               team8020/<cloudflareProjectName>
  Production branch:         main
  Staging branch:            staging (will be created and pushed)
  Account:                   8020 (5fb7b68caca59af162775b35cf591beb)

Staging URL:    https://staging.<cloudflareProjectName>.pages.dev
Production URL: https://<cloudflareProjectName>.pages.dev
```

Ask: "Proceed? (yes/no)"

### Phase 3 — Create Pages Project

Call the Cloudflare API to create the project:

```bash
curl -s -X POST \
  "https://api.cloudflare.com/client/v4/accounts/5fb7b68caca59af162775b35cf591beb/pages/projects" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "<cloudflareProjectName>",
    "production_branch": "main",
    "source": {
      "type": "github",
      "config": {
        "owner": "team8020",
        "repo_name": "<cloudflareProjectName>",
        "production_branch": "main",
        "pr_comments_enabled": true,
        "deployments_enabled": true
      }
    }
  }'
```

- On success (`success: true`): proceed to Phase 4.
- On error `8000007` (project name taken): the project already exists — ask the user if they want to continue with the existing project or choose a new name.
- On error `8000013` (GitHub repo not found / integration missing): the GitHub integration for the `team8020` org may not be connected to this Cloudflare account. Direct the user to: Cloudflare Dashboard → Workers & Pages → Connect to Git → authorize the `team8020` GitHub org, then re-run this skill.
- On any other error: show `errors` from the response and stop.

### Phase 4 — Create Staging Branch

```bash
git checkout -b staging 2>/dev/null || git checkout staging
git push -u origin staging
git checkout main
```

If the `staging` branch already exists remotely, skip creation but confirm it's pushed.

### Phase 5 — Verify, Update project.json & Output

1. Fetch the project to confirm it exists:

```bash
curl -s \
  "https://api.cloudflare.com/client/v4/accounts/5fb7b68caca59af162775b35cf591beb/pages/projects/<cloudflareProjectName>" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN"
```

2. Update `project.json`: add (or set) `stagingScriptUrl` and `productionScriptUrl`. Preserve existing keys (`clientName`, `webflowSiteId`, `cloudflareProjectName`). Use these values:
   - `stagingScriptUrl`: `https://staging.<cloudflareProjectName>.pages.dev/global/main.js`
   - `productionScriptUrl`: `https://<cloudflareProjectName>.pages.dev/global/main.js`
   Write the file with consistent formatting (e.g. 2-space indent).

3. Report to the user:

```
✓ Cloudflare Pages project created: <cloudflareProjectName>
✓ Staging branch created and pushed
✓ project.json updated with stagingScriptUrl and productionScriptUrl

Next: Add these <script> tags in Webflow:

STAGING (Site Settings → Custom Code → Footer Code):
  <script src="https://staging.<cloudflareProjectName>.pages.dev/global/main.js" defer></script>

PRODUCTION (add at launch, same location):
  <script src="https://<cloudflareProjectName>.pages.dev/global/main.js" defer></script>

For page-specific scripts, load them in Page Settings → Custom Code → Before </body>:
  <script src="https://staging.<cloudflareProjectName>.pages.dev/pages/[page-slug].js" defer></script>
```

Then proceed to Phase 6.

### Phase 6 — Commit

1. Show what changed: list modified files (e.g. `project.json`, and `.env.example` if it was updated in Phase 1).
2. Prompt: "Commit these changes? (yes/no)"
3. If yes: stage the changed files and commit with message `chore: connect to Cloudflare Pages`. Do not push unless the user asks.
4. If no: remind the user to commit when ready so the project docs stay in sync.

---

## Notes

- The GitHub integration (team8020 org → Cloudflare account) must already be authorized. It is for the 8020 Cloudflare account. If a new org/account is used, authorize it first.
- Cloudflare Pages builds the `staging` branch as a preview deployment at `https://staging.<project>.pages.dev` — this is a stable URL (not a random preview hash), which is why the branch name must be exactly `staging`.
- No build step is needed (static JS files). Cloudflare serves files as-is.
- `CLOUDFLARE_API_TOKEN` needs **Cloudflare Pages: Edit** permission scoped to the 8020 account.
