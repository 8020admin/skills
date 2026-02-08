# 8020 Skills – Code Guide

## Project Overview

This repo holds **Cursor Agent Skills** for Webflow (blog CMS, migrations, etc.). Each skill is a directory with a single required file `SKILL.md` containing instructions the agent follows when the task matches.

## Quick Reference

### Directory Structure

```
8020-skills/
├── <skill-name>/     # One directory per skill, kebab-case
│   └── SKILL.md      # Required: frontmatter (name, description) + instructions
├── CLAUDE.md         # This file – context for AI working in the repo
├── .gitignore
└── README.md
```

### Skill Layout (Best Practices)

1. **Frontmatter** – Every `SKILL.md` must have:
   - `name`: kebab-case identifier
   - `description`: One sentence for when to use this skill (used for matching)

2. **Sections** – Include as appropriate:
   - Important Note / CRITICAL (tools, MCP, context parameter)
   - What This Creates / Capabilities
   - Process (phased: Setup → Preview/Confirmation → Creation → Verification)
   - Example usage or real-world example
   - Common Issues & Solutions
   - Notes / Limitations

3. **Webflow skills** – All Webflow operations must use Webflow MCP tools only; every tool call must include the required `context` parameter (15–25 words, third-person).

## Common Tasks

### Adding a New Skill

1. Create a new directory: `kebab-case-skill-name/`
2. Add `SKILL.md` with YAML frontmatter and full instructions
3. Update `README.md` Skills Index table
4. Optionally add `scripts/` or `resources/` under the skill directory if needed

### Editing an Existing Skill

1. Edit the skill’s `SKILL.md` only (or files under its directory)
2. Keep frontmatter and phase structure consistent with other skills
3. If you change when the skill should be used, update `description` and README

### Testing

- Run through the skill’s process in a real (or test) Webflow site
- Confirm phases (e.g. list_sites → get_site → get_collection_list → create_collection → …) and that confirmation is requested before creating collections

## Gotchas

- **Webflow MCP only** – Skills that touch Webflow must not use other tools or methods for Webflow operations.
- **Context parameter** – Webflow MCP tool calls require a `context` parameter (15–25 words, third-person).
- **Creation order** – For blog-style CMS: create taxonomy collections (Categories, Tags, Authors) first, then Blog Posts with reference fields.
- **Help text** – Blog-structure-creator requires `helpText` on every field; do not skip.
- **SEO on all collections** – Categories, Tags, and Authors must have Meta Title, Meta Description, and OG Image fields, not just Blog Posts.

## Resources

- **Repo README**: See `README.md` for structure and skill index
- **Cookbook**: [claude-cookbooks/skills](https://github.com/anthropics/claude-cookbooks/tree/main/skills)
- **Skills best practices**: [Anthropic docs](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)
