# Quickstart: Hugo Blog Basic Setup

**Date**: 2025-11-11  
**Feature**: Hugo Blog Basic Setup  
**Purpose**: Step-by-step guide to build, run, and deploy the Hugo blog

## Prerequisites

- Git installed
- Terminal/command line access
- Text editor (VS Code, Sublime, vim, etc.)
- Web browser for testing

## Installation

### Step 1: Install Hugo Extended

Choose your operating system:

**macOS** (using Homebrew):
```bash
brew install hugo
```

**Linux** (using Homebrew):
```bash
brew install hugo
```

Note: If you don't have Homebrew on Linux, install it first:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Windows** (using Chocolatey):
```bash
choco install hugo-extended
```

**Verify Installation**:
```bash
hugo version
# Should show v0.120.0 or later, with "extended" in the output
```

## Project Setup

### Step 2: Initialize Hugo Site

```bash
# Navigate to your project directory
cd /home/kc00l/blog

# Initialize Hugo site (if not already done)
# Note: This should already be done in the repository
hugo new site . --force  # --force if directory already exists
```

### Step 3: Install Ananke Theme

**Method 1: Hugo Modules** (recommended):
```bash
# Initialize Go modules
hugo mod init github.com/yourusername/blog

# Add Ananke theme as module
hugo mod get github.com/theNewDynamic/gohugo-theme-ananke
```

**Method 2: Git Submodule** (alternative):
```bash
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
git submodule update --init --recursive
```

### Step 4: Configure Hugo

Create or update `config.toml` in the project root:

```toml
baseURL = "http://localhost:1313/"
languageCode = "en-us"
title = "My Hugo Blog"
theme = "ananke"

# Pagination
paginate = 10

# Menu Configuration
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

# Ananke Theme Parameters
[params]
  site_logo = ""
  description = "A static blog built with Hugo"
  facebook = ""
  twitter = ""
  github = ""
  linkedin = ""
  show_reading_time = true
  read_more_copy = "Read more"

# Build Settings
[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = false

# Minification
[minify]
  disableCSS = false
  disableHTML = false
  disableJS = false
```

## Content Creation

### Step 5: Create Required Pages

**About Page**:
```bash
hugo new about.md
```

Edit `content/about.md`:
```markdown
---
title: "About"
description: "Learn about this blog"
---

# About This Blog

Write your about content here...
```

**Disclaimer Page**:
```bash
hugo new disclaimer.md
```

Edit `content/disclaimer.md`:
```markdown
---
title: "Disclaimer"
description: "Legal disclaimer and terms of use"
---

# Disclaimer

Write your disclaimer content here...
```

### Step 6: Create Sample Blog Posts

**First Post**:
```bash
hugo new posts/my-first-post.md
```

Edit `content/posts/my-first-post.md`:
```markdown
---
title: "My First Blog Post"
date: 2025-11-11T10:00:00-05:00
draft: false
description: "Welcome to my new Hugo blog"
---

This is my first blog post! Welcome to my new static blog built with Hugo and the Ananke theme.

## Why Hugo?

Hugo is fast, simple, and perfect for static blogs...
```

**Second Post** (for testing multiple posts):
```bash
hugo new posts/hugo-is-awesome.md
```

Edit accordingly with different content.

## Development Workflow

### Step 7: Run Development Server

```bash
# Start Hugo server with live reload
hugo server -D

# Server starts at http://localhost:1313/
# -D flag includes draft posts (for development)
```

**Expected Output**:
```
Start building sites … 
hugo v0.120.0+extended

                   | EN  
-------------------+-----
  Pages            |  10  
  Paginator pages  |   0  
  Non-page files   |   0  
  Static files     |   0  
  Processed images |   0  
  Aliases          |   0  
  Sitemaps         |   1  
  Cleaned          |   0  

Built in 45 ms
Web Server is available at http://localhost:1313/
Press Ctrl+C to stop
```

### Step 8: Verify Functionality

Open browser to `http://localhost:1313` and verify:

**Homepage Checklist**:
- [ ] Recent posts are listed (newest first)
- [ ] Each post shows title, date, and excerpt
- [ ] Post titles are clickable
- [ ] If no posts exist, message shows: "These aren't the posts you're looking for... yet"
- [ ] Maximum 10 posts displayed

**Navigation Checklist**:
- [ ] Navigation menu visible on all pages
- [ ] "Home" link navigates to homepage
- [ ] "About" link navigates to about page
- [ ] "Disclaimer" link navigates to disclaimer page

**Post Page Checklist**:
- [ ] Clicking post title loads full post
- [ ] Post title displayed
- [ ] Publication date displayed (human-readable format)
- [ ] Full content rendered correctly

**Responsive Design Checklist**:
- [ ] Resize browser to 320px width
- [ ] Content is readable without horizontal scrolling
- [ ] Navigation remains accessible

## Production Build

### Step 9: Build Static Site

```bash
# Clean previous build (optional)
rm -rf public/

# Build for production (excludes drafts)
hugo

# Or with minification
hugo --minify
```

**Output**: Static HTML files generated in `public/` directory

**Verify Build**:
```bash
ls -lh public/
# Should see index.html, posts/, about/, disclaimer/, css/, js/, etc.
```

## Testing

### Step 10: Accessibility Testing

**WAVE Browser Extension**:
1. Install WAVE extension: https://wave.webaim.org/extension/
2. Navigate to `http://localhost:1313`
3. Click WAVE icon in browser
4. Review accessibility report
5. Verify no errors for WCAG 2.1 AA compliance

**Lighthouse Audit**:
1. Open Chrome DevTools (F12)
2. Navigate to "Lighthouse" tab
3. Run audit (select "Accessibility" and "Performance")
4. Verify scores:
   - Accessibility: 100 (or > 90)
   - Performance: > 90
   - FCP < 1.5s
   - LCP < 2.5s

### Step 11: Performance Testing

**Page Weight Check**:
```bash
# Check homepage size
curl -s http://localhost:1313/ | wc -c
# Should be < 500KB (500000 bytes) for text content
```

**Core Web Vitals**:
- Use Lighthouse (Step 10 above)
- Or use https://pagespeed.web.dev/ (after deployment)

## Deployment

### Step 12: Deploy to Static Hosting

**Option 1: GitHub Pages**:
```bash
# 1. Push to GitHub repository
git add .
git commit -m "Add Hugo blog"
git push origin main

# 2. Enable GitHub Pages in repository settings
# Settings → Pages → Source: GitHub Actions
# Use Hugo GitHub Action workflow

# 3. Site available at: https://username.github.io/blog/
```

**Option 2: Netlify**:
```bash
# 1. Sign up at https://netlify.com
# 2. Connect GitHub repository
# 3. Build settings:
#    - Build command: hugo --minify
#    - Publish directory: public
# 4. Deploy

# Or use Netlify CLI:
npm install -g netlify-cli
netlify login
netlify deploy --prod
```

**Option 3: Manual (rsync to server)**:
```bash
# Build
hugo --minify

# Deploy via rsync
rsync -avz --delete public/ user@yourserver.com:/var/www/blog/

# Or via SCP
scp -r public/* user@yourserver.com:/var/www/blog/
```

**Option 4: AWS S3**:
```bash
# Build
hugo --minify

# Sync to S3
aws s3 sync public/ s3://your-bucket-name/ --delete

# Enable static website hosting in S3 bucket settings
```

## Troubleshooting

### Common Issues

**Issue**: Theme not found
```bash
# Solution 1: Verify theme installation
ls themes/ananke

# Solution 2: Check config.toml
# Ensure: theme = "ananke"

# Solution 3: Reinitialize submodule
git submodule update --init --recursive
```

**Issue**: Posts not showing
```bash
# Check if posts are drafts
grep "draft:" content/posts/*.md

# Solution: Set draft: false or omit the field
```

**Issue**: Build errors
```bash
# Run with verbose output
hugo --verbose

# Check for YAML syntax errors in frontmatter
```

**Issue**: Navigation not working
```bash
# Verify menu configuration in config.toml
# Ensure [menu] section exists with [[menu.main]] items
```

## Quick Reference

### Common Commands

```bash
# Development
hugo server -D          # Start server with drafts
hugo server --bind 0.0.0.0  # Allow external access

# Content Creation
hugo new posts/title.md    # Create new post
hugo new about.md          # Create new page

# Building
hugo                       # Build (exclude drafts)
hugo -D                    # Build (include drafts)
hugo --minify             # Build with minification

# Cleanup
rm -rf public/            # Remove build output
hugo mod clean            # Clean module cache
```

### Directory Structure Reference

```
blog/
├── archetypes/          # Content templates
├── content/
│   ├── posts/          # Blog posts
│   ├── about.md        # About page
│   └── disclaimer.md   # Disclaimer page
├── layouts/            # Custom templates (optional)
├── static/             # Static assets (images, etc.)
├── themes/
│   └── ananke/         # Theme files (if using submodule)
├── public/             # Generated site (gitignored)
├── config.toml         # Hugo configuration
└── go.mod              # Hugo modules (if using modules)
```

### Configuration Reference

Key `config.toml` settings:
- `baseURL`: Production site URL
- `title`: Site title
- `theme`: Theme name ("ananke")
- `paginate`: Posts per page (10)
- `[menu]`: Navigation menu
- `[params]`: Theme-specific settings

## Next Steps

1. **Add Content**: Create more blog posts in `content/posts/`
2. **Customize**: Modify `config.toml` parameters (title, description, social links)
3. **Deploy**: Choose hosting provider and deploy
4. **Validate**: Run WAVE and Lighthouse on deployed site
5. **Monitor**: Check Core Web Vitals and accessibility after deployment

## Support Resources

- Hugo Documentation: https://gohugo.io/documentation/
- Ananke Theme Docs: https://github.com/theNewDynamic/gohugo-theme-ananke
- Hugo Quick Start: https://gohugo.io/getting-started/quick-start/
- WAVE Tool: https://wave.webaim.org/
- Hugo Community Forum: https://discourse.gohugo.io/

## Success Criteria Validation

After completing quickstart, verify:

- [x] Homepage loads in < 2 seconds
- [x] Navigation works (2 clicks or fewer to any page)
- [x] Mobile responsive (320px minimum width)
- [x] Page weight < 500KB
- [x] Posts display with smart excerpt truncation
- [x] Empty state message shows when no posts exist
- [x] Accessibility passes WCAG 2.1 AA (WAVE test)
- [x] Build completes without errors
- [x] Static files deployable to any hosting

**Estimated Time**: 30-60 minutes for complete setup and first deployment
