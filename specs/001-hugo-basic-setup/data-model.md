# Data Model: Hugo Blog Basic Setup

**Date**: 2025-11-11  
**Feature**: Hugo Blog Basic Setup  
**Purpose**: Define content structure, entities, and relationships for the blog

## Overview

This blog uses a filesystem-based data model with Markdown files and YAML frontmatter. No database is used. All content is stored in the `content/` directory and version-controlled in Git.

## Entities

### 1. Blog Post

**Description**: An article/post with dated content, displayed on the homepage in reverse chronological order.

**Storage Location**: `content/posts/*.md`

**Attributes**:

| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| title | string | Yes | Post title | Non-empty, max 200 chars recommended |
| date | datetime | Yes | Publication date (ISO 8601) | Format: `2025-11-11T10:00:00-05:00` |
| draft | boolean | No | Draft status (true = not published) | Default: `false` |
| description | string | No | Meta description for SEO | Max 160 chars recommended |
| content | markdown | Yes | Full post content (body) | Valid Markdown |

**Frontmatter Example**:
```yaml
---
title: "My First Blog Post"
date: 2025-11-11T10:00:00-05:00
draft: false
description: "An introduction to my new blog"
---

This is the post content in **Markdown** format.
```

**Relationships**:
- Has no relationships (static content, no comments or tags in basic setup)

**Lifecycle States**:
1. **Draft** (`draft: true`): Not visible on site
2. **Published** (`draft: false` or omitted): Visible on homepage and accessible via URL

**Derivations**:
- **Excerpt**: Automatically generated from content (first 150-200 chars with smart word-boundary truncation, or full content if < 150 chars)
- **URL**: Generated from date and title slug (e.g., `/posts/2025/11/my-first-blog-post/`)
- **Publish Date Display**: Formatted as human-readable (e.g., "November 11, 2025")

---

### 2. Static Page

**Description**: A standalone page with evergreen content (About, Disclaimer), not dated, not listed chronologically.

**Storage Location**: `content/*.md` (root level)

**Attributes**:

| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| title | string | Yes | Page title | Non-empty, max 200 chars recommended |
| description | string | No | Meta description for SEO | Max 160 chars recommended |
| menu | string | No | Menu identifier (e.g., "main") | Hugo menu system |
| content | markdown | Yes | Full page content (body) | Valid Markdown |

**Frontmatter Example**:
```yaml
---
title: "About"
description: "Learn about this blog"
menu: "main"
---

This is the about page content.
```

**Relationships**:
- Linked via navigation menu (configured in `config.toml`)

**Lifecycle States**:
- Pages are always published (no draft concept for static pages)

**Derivations**:
- **URL**: Generated from filename (e.g., `about.md` → `/about/`)

---

### 3. Navigation Menu

**Description**: Site navigation configuration, not a file-based entity but configured in `config.toml`.

**Storage Location**: `config.toml` (Hugo configuration file)

**Structure**:
```toml
[menu]
  [[menu.main]]
    name = "Home"
    url = "/"
    weight = 1
  [[menu.main]]
    name = "About"
    url = "/about/"
    weight = 2
  [[menu.main]]
    name = "Disclaimer"
    url = "/disclaimer/"
    weight = 3
```

**Attributes**:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| name | string | Yes | Display text for menu item |
| url | string | Yes | Link destination |
| weight | integer | No | Sort order (lower = appears first) |

**Relationships**:
- References Static Pages and homepage

---

## Content Directory Structure

```
content/
├── posts/
│   ├── my-first-post.md
│   ├── another-post.md
│   └── hugo-tutorial.md
├── about.md
└── disclaimer.md
```

## Validation Rules

### Blog Post Validation

1. **Title**: Must be present, non-empty
2. **Date**: Must be valid ISO 8601 datetime
3. **Draft**: If omitted, defaults to `false` (published)
4. **Content**: Must be valid Markdown (Hugo will error on parse failures)

### Static Page Validation

1. **Title**: Must be present, non-empty
2. **Content**: Must be valid Markdown

### Global Validation

- All files must have `.md` extension
- Filenames should use kebab-case (lowercase with hyphens)
- No special characters in filenames (Hugo will sanitize URLs)

## Excerpt Generation Logic

**Requirement**: Smart truncation per spec clarification

**Algorithm**:
1. If post content length < 150 characters: Show full content (no truncation)
2. If post content length ≥ 150 characters:
   - Find the last complete word before 200 characters
   - Truncate at that word boundary
   - Append "..." to indicate truncation

**Implementation**: Hugo's `.Summary` variable with custom configuration or template logic

**Example**:
- Post with 100 chars: Full content shown
- Post with 250 chars: "This is a long post about Hugo and static site generators. It covers many topics including themes and deployment..." (truncated at ~200 chars at word boundary)

## Empty State Handling

**Requirement**: Display message when no posts exist

**Logic**:
```go-template
{{ if .Pages }}
  <!-- Display posts -->
{{ else }}
  <p>These aren't the posts you're looking for... yet</p>
{{ end }}
```

**Location**: `layouts/_default/list.html` or theme override

## Date Formatting

**Requirement**: Human-readable date format

**Formats Supported**:
- "November 11, 2025" (preferred)
- "Nov 11, 2025" (acceptable)
- ISO format in frontmatter (required for Hugo parsing)

**Hugo Template**:
```go-template
{{ .Date.Format "January 2, 2006" }}  <!-- Full month name -->
{{ .Date.Format "Jan 2, 2006" }}      <!-- Abbreviated month -->
```

## State Transitions

### Blog Post States

```
[Created] → draft: true → [Draft State]
    ↓
[Edit & Review]
    ↓
Set draft: false → [Published State]
    ↓
Visible on homepage
Accessible via URL
Included in RSS feed
```

No state transitions for Static Pages (always published).

## Data Integrity

**Git as Source of Truth**:
- All content files are version-controlled
- Changes tracked via git commits
- No external database to sync

**Build-Time Validation**:
- Hugo validates frontmatter syntax at build time
- Invalid YAML causes build error
- Missing required fields cause build error

**No Runtime State**:
- Static files generated at build time
- No database, no session state
- Each build is deterministic from source files

## Scalability Considerations

**Current Scope**: 10-100 posts expected

**Hugo Performance**:
- Handles thousands of posts efficiently
- Incremental builds for fast iteration
- No performance concerns at current scale

**Future Extensions** (not in current scope):
- Tags/Categories: Add `tags` field to frontmatter
- Authors: Add `author` field for multi-author blogs
- Featured images: Add `image` field
- Comments: External service (Disqus, Commento) or static alternative
- Search: Client-side JS search (lunr.js) or external (Algolia)

## Schema Summary

| Entity | Storage | Fields | Relationships |
|--------|---------|--------|---------------|
| Blog Post | `content/posts/*.md` | title, date, draft, description, content | None |
| Static Page | `content/*.md` | title, description, menu, content | Referenced by Navigation |
| Navigation Menu | `config.toml` | name, url, weight | References Pages |

## Constraints

1. **No Database**: All data in filesystem (Markdown + YAML)
2. **No External APIs**: Content is self-contained
3. **Git Version Control**: All content changes tracked
4. **Read-Only at Runtime**: Static HTML, no updates without rebuild
5. **UTF-8 Encoding**: All Markdown files must be UTF-8

## Validation Checklist

- [ ] All posts have `title` and `date` fields
- [ ] All dates are valid ISO 8601 format
- [ ] All Markdown files are valid and parse correctly
- [ ] Filenames use kebab-case with `.md` extension
- [ ] Content directory structure matches `content/posts/` and `content/*.md`
- [ ] Navigation menu configured in `config.toml`
- [ ] Build succeeds without errors: `hugo --buildDrafts=false`
