# 8020 Skills

Cursor Agent Skills for Webflow and related workflows. Each skill is a self-contained package of instructions that gives the AI specialized capabilities for specific tasks.

> Structure and conventions follow [Anthropic's Claude cookbooks skills best practices](https://github.com/anthropics/claude-cookbooks/tree/main/skills).

## What are Skills?

Skills are organized packages of instructions (and optional scripts/resources) that the agent discovers and loads when relevant. They provide:

- **Progressive disclosure** – Load only when the user's request matches the skill's scope
- **Domain expertise** – Webflow CMS, blog setup, migrations, audits
- **Consistent behavior** – Repeatable processes with phases, validation, and error handling

## Project Structure

```
8020-skills/
├── blog-structure-creator/    # Blog CMS (Categories, Tags, Authors, Blog Posts)
│   └── SKILL.md
├── scripts/
│   └── link-to-cursor.sh     # Symlink skills into ~/.cursor/skills/
├── CLAUDE.md                  # AI code guide (context, gotchas)
├── .gitignore
└── README.md                  # This file
```

## Skills Index

| Skill | Description |
|-------|-------------|
| **blog-structure-creator** | Create complete blog CMS structure in Webflow: Blog Posts, Categories, Tags, Authors. Includes SEO fields, taxonomies, and proper field relationships. Use when setting up blog infrastructure. |

## Skill Format

Each skill lives in its own directory with:

- **SKILL.md** (required) – Instructions for the agent:
  - YAML frontmatter: `name`, `description`
  - Clear capabilities, process phases, and example usage
  - Common issues & solutions, notes, and limitations

Optional (cookbook pattern):

- **scripts/** – Executable code (e.g. Python/JS) if the skill needs it
- **resources/** – Templates or sample data

## Adding these skills to Cursor (always up to date)

**Best approach:** Put this repo on GitHub, clone it on each machine, then **symlink** skills into Cursor. When you `git pull`, Cursor automatically sees the latest version (no copy step).

### 1. Put the repo on GitHub (one-time)

```bash
cd /path/to/8020-skills
git remote add origin https://github.com/YOUR_USERNAME/8020-skills.git
git push -u origin main
```

### 2. On each machine: clone and link (one-time per machine)

```bash
# Clone somewhere you’ll keep it (e.g. ~/Dev or 8020 Projects)
git clone https://github.com/YOUR_USERNAME/8020-skills.git
cd 8020-skills

# Make the script executable and run it (creates symlinks in ~/.cursor/skills/)
chmod +x scripts/link-to-cursor.sh
./scripts/link-to-cursor.sh
```

Restart Cursor (or reload the window) so it picks up the new skills.

### 3. Keeping skills up to date

When you pull updates (or push from another machine and pull here):

```bash
cd /path/to/8020-skills
git pull
```

No need to run the script again. The symlinks point at the repo, so Cursor always uses the current files.

### Optional: link from an existing clone

If the repo is already cloned (e.g. at `~/Dev/8020 Projects/8020-skills`), just run the script from that directory:

```bash
cd "/Users/cocovega/Dev/8020 Projects/8020-skills"
./scripts/link-to-cursor.sh
```

### Unlinking

To remove only the skills that came from this repo (leave other Cursor skills alone), delete the symlinks that point at this repo:

```bash
CURSOR_SKILLS=~/.cursor/skills
for name in blog-structure-creator; do rm -f "$CURSOR_SKILLS/$name"; done
```

Add any other skill names from this repo as you add them.

---

## Usage

- **In Cursor**: After linking (see above), skills appear in Cursor’s skill list.
- **When to use**: Invoke by describing the task (e.g. “set up a blog CMS in Webflow”); the agent will use the matching skill when applicable.

## Conventions

- **Directory names**: kebab-case (e.g. `blog-structure-creator`).
- **Frontmatter**: Every `SKILL.md` has `name` and `description`; the description is used for discovery and matching.
- **Process**: Skills use phased workflows (e.g. Site Setup → Preview & Confirmation → Creation → Verification) and explicit user confirmation before destructive or impactful steps.

## Resources

- [Claude cookbooks – skills](https://github.com/anthropics/claude-cookbooks/tree/main/skills)
- [Agent Skills best practices](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices) (Anthropic)
- [Create a Cursor skill](https://github.com/anthropics/claude-cookbooks/tree/main/skills) – use the custom skill structure and SKILL.md pattern from the cookbook
