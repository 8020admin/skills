---
name: blog-structure-creator
description: Create complete blog CMS structure in Webflow with Blog Posts, Categories, Tags, and Authors collections. Includes SEO fields, taxonomies, and proper field relationships. Use when setting up blog infrastructure in Webflow.
---

# Blog Structure CMS Setup

Create a complete CMS infrastructure for blogs with proper taxonomies, SEO fields, and content structure.

## Important Note

**CRITICAL: This skill creates collections WITH SEO fields and help text on ALL collections. Do NOT skip Meta Title, Meta Description, and OG Image fields. Do NOT skip helper text on any field.**

**ALWAYS use Webflow MCP tools for all operations:**
- Use Webflow MCP's `webflow_guide_tool` to get best practices before starting
- Use Webflow MCP's `data_sites_tool` with action `list_sites` to identify available sites
- Use Webflow MCP's `data_sites_tool` with action `get_site` to retrieve site details and plan limits
- Use Webflow MCP's `data_cms_tool` with action `get_collection_list` to check for naming conflicts
- Use Webflow MCP's `data_cms_tool` with action `create_collection` to create collections
- Use Webflow MCP's `data_cms_tool` with action `create_collection_static_field` to create static fields
- Use Webflow MCP's `data_cms_tool` with action `create_collection_option_field` to create option fields
- Use Webflow MCP's `data_cms_tool` with action `create_collection_reference_field` to create reference/multi-reference fields
- Use Webflow MCP's `data_cms_tool` with action `get_collection_details` to verify collection creation

**DO NOT use any other tools or methods for Webflow operations.**

All tool calls must include the required `context` parameter (15-25 words, third-person perspective).

## What This Creates

### Collections
1. **Categories** - Hierarchical taxonomy for organizing content with SEO fields
2. **Tags** - Non-hierarchical taxonomy for content tagging with SEO fields  
3. **Authors** - Author profiles with bios and social links
4. **Blog Posts** - Main content collection with comprehensive blog fields

### Key Features
- Complete blog post field coverage (title, slug, content, excerpt, dates, images)
- SEO optimization (meta title, meta description, OG images, robots directives)
- Dual image system (featured images for heroes, thumbnails for cards)
- Proper taxonomy relationships (categories, tags, authors)
- Help text on all fields with best practices and character limits

## Process

### Phase 1: Site Setup

1. **Get site information**: Use Webflow MCP's `data_sites_tool` with action `list_sites`
2. **Confirm site selection**: Ask user to select site if multiple available
3. **Check plan limits**: Use Webflow MCP's `data_sites_tool` with action `get_site` to verify collection limits
4. **List existing collections**: Use Webflow MCP's `data_cms_tool` with action `get_collection_list` to check for conflicts
5. **Validate naming**: Ensure collection names don't conflict with existing collections

### Phase 2: Preview & Confirmation

6. **Show complete structure**: Display all four collections with their fields:
   - Categories: Name, Slug, Description, Meta Title, Meta Description, OG Image
   - Tags: Name, Slug, Meta Title, Meta Description, OG Image
   - Authors: Name, Slug, Bio, Avatar, Email, Meta Title, Meta Description, OG Image
   - Blog Posts: Title, Slug, Content, Excerpt, Featured Image, Featured Image Alt Text, Thumbnail Image, Published Date, Meta Title, Meta Description, OG Image, Robots, plus references to Authors (single), Categories (multi), Tags (multi)

7. **Verify plan compatibility**: Confirm site plan supports 4 collections

8. **Request explicit approval**: Wait for user confirmation before proceeding

### Phase 3: Collection Creation

9. **Create Categories collection**: 
   - Use `create_collection` with displayName "Categories", singularName "Category"
   - Add 6 static fields **with the exact help text specified below** (helpText parameter is REQUIRED):
     - Name (PlainText, required) - helpText: "The display name of the category."
     - Slug (PlainText, required) - helpText: "URL-friendly version of the name (e.g., 'web-development'). Must be unique."
     - Description (RichText) - helpText: "Optional description of the category."
     - Meta Title (PlainText) - helpText: "SEO title for search engines (50-60 characters recommended)."
     - Meta Description (PlainText) - helpText: "SEO description for search engines (150-160 characters recommended)."
     - OG Image (Image) - helpText: "Open Graph image for social sharing (1200x630px recommended)."

10. **Create Tags collection**:
    - Use `create_collection` with displayName "Tags", singularName "Tag"
    - Add 5 static fields **with the exact help text specified below** (helpText parameter is REQUIRED):
      - Name (PlainText, required) - helpText: "The display name of the tag."
      - Slug (PlainText, required) - helpText: "URL-friendly version of the name (e.g., 'javascript'). Must be unique."
      - Meta Title (PlainText) - helpText: "SEO title for search engines (50-60 characters recommended)."
      - Meta Description (PlainText) - helpText: "SEO description for search engines (150-160 characters recommended)."
      - OG Image (Image) - helpText: "Open Graph image for social sharing (1200x630px recommended)."

11. **Create Authors collection**:
    - Use `create_collection` with displayName "Authors", singularName "Author"
    - Add 8 static fields **with the exact help text specified below** (helpText parameter is REQUIRED):
      - Name (PlainText, required) - helpText: "The author's full name."
      - Slug (PlainText, required) - helpText: "URL-friendly version of the name (e.g., 'john-smith'). Must be unique."
      - Bio (RichText) - helpText: "Author biography."
      - Avatar (Image) - helpText: "Author profile photo."
      - Email (Email) - helpText: "Author's email address (optional)."
      - Meta Title (PlainText) - helpText: "SEO title for search engines (50-60 characters recommended)."
      - Meta Description (PlainText) - helpText: "SEO description for search engines (150-160 characters recommended)."
      - OG Image (Image) - helpText: "Open Graph image for social sharing (1200x630px recommended)."

12. **Create Blog Posts collection**:
    - Use `create_collection` with displayName "Blog Posts", singularName "Blog Post"
    - Add 12 static fields **with the exact help text specified below** (helpText parameter is REQUIRED):
      - Title (PlainText, required) - helpText: "The main title of the blog post."
      - Slug (PlainText, required) - helpText: "URL-friendly version of the title (e.g., 'getting-started-with-webflow'). Must be unique."
      - Content (RichText, required) - helpText: "The main body content of the blog post."
      - Excerpt (PlainText) - helpText: "Short summary of the post (150-200 characters recommended). Used in post listings and previews."
      - Featured Image (Image) - helpText: "Main hero image for the post."
      - Featured Image Alt Text (PlainText) - helpText: "Descriptive alt text for the featured image for accessibility and SEO."
      - Thumbnail Image (Image) - helpText: "Smaller image for use in cards and listings."
      - Published Date (DateTime, required) - helpText: "Publication date of the post. Important for SEO and content chronology."
      - Meta Title (PlainText) - helpText: "SEO title for search engines (50-60 characters recommended). Include target keywords."
      - Meta Description (PlainText) - helpText: "SEO description for search engines (150-160 characters recommended). Should encourage clicks and include target keywords naturally."
      - OG Image (Image) - helpText: "Open Graph image for social sharing (1200x630px recommended)."
      - Robots (PlainText) - helpText: "Search engine indexing directive (e.g., 'index, follow', 'noindex, nofollow'). Leave empty for default behavior (index, follow). Use 'noindex' for thin or duplicate content."
    - Add 3 reference fields **with the exact help text specified below** (helpText parameter is REQUIRED):
      - Author (Reference to Authors, required) - helpText: "The author of this post. Each post must have one author."
      - Categories (MultiReference to Categories) - helpText: "Primary categories for this post. Used for main navigation and filtering."
      - Tags (MultiReference to Tags) - helpText: "Tags for this post. Used for secondary categorization and related post suggestions."

### Phase 4: Verification

13. **Verify each collection**: Use `get_collection_details` for each created collection to confirm structure
14. **Report collection IDs**: Provide user with all collection IDs for their records
15. **Confirm completion**: Display success message with next steps for data import

## Real-World Example

This skill creates a complete blog infrastructure as demonstrated in production implementations. Here's what the structure looks like:

### Created Collections

**1. Categories Collection**
- **Name** (PlainText, required) - The display name of the category.
- **Slug** (PlainText, required) - URL-friendly version of the name (e.g., 'web-development'). Must be unique.
- **Description** (RichText) - Optional description of the category.
- **Meta Title** (PlainText) - SEO title for search engines (50-60 characters recommended).
- **Meta Description** (PlainText) - SEO description for search engines (150-160 characters recommended).
- **OG Image** (Image) - Open Graph image for social sharing (1200x630px recommended).

**2. Tags Collection**
- **Name** (PlainText, required) - The display name of the tag.
- **Slug** (PlainText, required) - URL-friendly version of the name (e.g., 'javascript'). Must be unique.
- **Meta Title** (PlainText) - SEO title for search engines (50-60 characters recommended).
- **Meta Description** (PlainText) - SEO description for search engines (150-160 characters recommended).
- **OG Image** (Image) - Open Graph image for social sharing (1200x630px recommended).

**3. Authors Collection**
- **Name** (PlainText, required) - The author's full name.
- **Slug** (PlainText, required) - URL-friendly version of the name (e.g., 'john-smith'). Must be unique.
- **Bio** (RichText) - Author biography.
- **Avatar** (Image) - Author profile photo.
- **Email** (Email) - Author's email address (optional).
- **Meta Title** (PlainText) - SEO title for search engines (50-60 characters recommended).
- **Meta Description** (PlainText) - SEO description for search engines (150-160 characters recommended).
- **OG Image** (Image) - Open Graph image for social sharing (1200x630px recommended).

**4. Blog Posts Collection**

*Content Fields:*
- **Name/Title** (PlainText, required) - The main title of the blog post.
- **Slug** (PlainText, required) - URL-friendly version of the title (e.g., 'getting-started-with-webflow'). Must be unique.
- **Content** (RichText, required) - The main body content of the blog post.
- **Excerpt** (PlainText) - Short summary of the post (150-200 characters recommended). Used in post listings and previews.
- **Published Date** (DateTime, required) - Publication date of the post. Important for SEO and content chronology.

*Image Fields:*
- **Featured Image** (Image) - Main hero image for the post.
- **Featured Image Alt Text** (PlainText) - Descriptive alt text for the featured image for accessibility and SEO.
- **Thumbnail Image** (Image) - Smaller image for use in cards and listings.

*SEO Fields:*
- **Meta Title** (PlainText) - SEO title for search engines (50-60 characters recommended). Include target keywords.
- **Meta Description** (PlainText) - SEO description for search engines (150-160 characters recommended). Should encourage clicks and include target keywords naturally.
- **OG Image** (Image) - Open Graph image for social sharing (1200x630px recommended).
- **Robots** (PlainText) - Search engine indexing directive (e.g., 'index, follow', 'noindex, nofollow'). Leave empty for default behavior (index, follow). Use 'noindex' for thin or duplicate content.

*Relationship Fields:*
- **Author** (Reference to Authors, required) - The author of this post. Each post must have one author.
- **Categories** (MultiReference to Categories) - Primary categories for this post. Used for main navigation and filtering.
- **Tags** (MultiReference to Tags) - Tags for this post. Used for secondary categorization and related post suggestions.

### What This Enables

This structure provides a complete, production-ready blog CMS that supports:
- **Multiple categorization methods** - Hierarchical categories for main navigation, flexible tags for cross-referencing
- **Comprehensive SEO optimization** - Meta tags, Open Graph images, and robots directives on all content types
- **Flexible image handling** - Separate images optimized for different use cases (heroes vs. thumbnails)
- **Author attribution and profiles** - Full author system with bios, avatars, and social metadata
- **Proper URL structure** - Slug management across all content types for clean, SEO-friendly URLs
- **Content discovery** - Multi-reference fields enable related posts, category archives, and tag-based browsing

## Common Issues & Solutions

**Issue**: Collection creation fails
- **Solution**: Check plan limits with `get_site` - ensure site plan supports multiple collections

**Issue**: Reference field creation fails
- **Solution**: Ensure referenced collection was created first - Categories, Tags, and Authors must exist before Blog Posts references them

**Issue**: Field name conflicts
- **Solution**: Check existing collections with `get_collection_list` before creation

**Issue**: SEO fields missing from Categories, Tags, or Authors
- **Solution**: Verify you're creating Meta Title, Meta Description, and OG Image fields for ALL collections, not just Blog Posts

**Issue**: Helper text not appearing on fields
- **Solution**: Ensure you're passing the helpText parameter when creating each field using create_collection_static_field

## Notes

- This creates 4 collections total - verify site plan supports this
- Collections are created in dependency order: taxonomies first, then Blog Posts with references
- All slugs auto-generate from display names unless specified
- Help text includes character count recommendations for SEO fields
- Robots field uses PlainText for maximum flexibility with directives
- Provides comprehensive blog infrastructure ready for content
- **CRITICAL**: All three taxonomy collections (Categories, Tags, Authors) MUST have SEO fields (Meta Title, Meta Description, OG Image)
- **CRITICAL**: ALL fields MUST have helper text - this is not optional
