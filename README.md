# My Hugo Blog

A static blog built with [Hugo](https://gohugo.io/) and the [Ananke theme](https://github.com/theNewDynamic/gohugo-theme-ananke), featuring accessible design, fast performance, and simple content management.

## Features

- 📝 Blog posts with smart excerpt truncation
- 📄 About and Disclaimer pages
- ♿ WCAG 2.1 AA/AAA compliant (Ananke theme)
- 🚀 Fast static site generation
- 📱 Responsive design (320px - 2560px)
- 🎨 Clean, minimal design

## Prerequisites

- [Hugo Extended](https://gohugo.io/installation/) v0.120 or higher
- [Go](https://go.dev/dl/) 1.21+ (for Hugo Modules)

### Installation

**macOS/Linux (Homebrew)**:
```bash
brew install hugo
brew install go
```

**Other platforms**: See [Hugo installation guide](https://gohugo.io/installation/)

## Quick Start

### 1. Clone the repository

```bash
git clone <repository-url>
cd blog
```

### 2. Install theme dependencies

```bash
hugo mod get github.com/theNewDynamic/gohugo-theme-ananke/v2
```

### 3. Run development server

```bash
hugo server -D
```

Visit http://localhost:1313/ to view your blog.

## Project Structure

```
blog/
├── archetypes/          # Content templates
│   └── default.md      # Default frontmatter template
├── content/            # All Markdown content
│   ├── posts/         # Blog posts
│   ├── about.md       # About page
│   └── disclaimer.md  # Disclaimer page
├── static/            # Static assets (images, etc.)
├── public/            # Generated site (gitignored)
├── hugo.toml          # Site configuration
├── go.mod             # Hugo modules
└── README.md          # This file
```

## Creating Content

### New blog post

```bash
hugo new posts/my-new-post.md
```

Edit the file in `content/posts/my-new-post.md`:
- Set `draft: false` when ready to publish
- Add a `description` for the excerpt
- Write your content in Markdown

### New page

```bash
hugo new page-name.md
```

## Building for Production

```bash
hugo --minify
```

This generates optimized static files in the `public/` directory.

## Deployment

The `public/` directory contains your complete static site. Deploy to:

- **Netlify**: Connect your git repository and set build command to `hugo --minify`
- **GitHub Pages**: Use GitHub Actions with Hugo setup
- **AWS S3**: Upload `public/` contents to S3 bucket with static hosting
- **Traditional hosting**: Upload `public/` contents via FTP/SFTP

For detailed deployment instructions, see [Hugo deployment documentation](https://gohugo.io/hosting-and-deployment/).

## Configuration

Edit `hugo.toml` to customize:
- Site title and description
- Navigation menu
- Theme parameters
- Pagination settings

## Content Guidelines

### Frontmatter

All content files require YAML frontmatter:

```yaml
---
title: "Post Title"
date: 2025-11-11T10:00:00-05:00
draft: false
description: "Brief description for excerpts and SEO"
---
```

### Excerpt Behavior

- Posts with content < 150 characters: Full content shown on homepage
- Posts with content > 150 characters: Smart truncation at word boundary before 200 characters with "..."

## Performance

- Page weight: < 500KB (text content)
- First Contentful Paint: < 1.5s
- Largest Contentful Paint: < 2.5s
- Cumulative Layout Shift: < 0.1

## Accessibility

- WCAG 2.1 AA/AAA compliant
- Responsive design (320px minimum width)
- Semantic HTML
- Keyboard navigation support
- Screen reader compatible

## License

Content is yours. Hugo is licensed under Apache 2.0. Ananke theme is licensed under MIT.

## Support

For Hugo questions: https://discourse.gohugo.io/
For theme issues: https://github.com/theNewDynamic/gohugo-theme-ananke/issues
