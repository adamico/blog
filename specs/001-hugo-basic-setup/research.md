# Research: Hugo Blog Basic Setup

**Date**: 2025-11-11  
**Feature**: Hugo Blog Basic Setup  
**Purpose**: Research Hugo static site generator best practices, Ananke theme configuration, and deployment strategies

## Research Questions

### 1. Hugo Installation and Setup

**Decision**: Use Hugo Extended edition v0.120 or later

**Rationale**:
- Extended edition includes Sass/SCSS processor needed by many themes (including Ananke)
- Version 0.120+ includes latest performance improvements and security patches
- Available via package managers (homebrew, apt, chocolatey) or binary download
- Single binary with no runtime dependencies

**Alternatives Considered**:
- Hugo Standard edition: Lacks Sass/SCSS support needed for theme customization
- Older Hugo versions: Missing performance improvements and bug fixes
- Other static site generators (Jekyll, 11ty, Gatsby): More complex, require runtime dependencies

**Installation Methods**:
```bash
# macOS
brew install hugo

# Linux (Debian/Ubuntu)
sudo apt install hugo

# Or download binary from https://github.com/gohugoio/hugo/releases
```

### 2. Ananke Theme Installation Method

**Decision**: Install Ananke theme as Hugo Module (preferred) with Git submodule as fallback

**Rationale**:
- Hugo Modules (Go modules) provide cleaner dependency management
- Easier updates via `hugo mod get -u`
- No git submodule complexity
- Recommended by Hugo documentation for new projects

**Alternatives Considered**:
- Git submodule: More complex, requires `git submodule update --init --recursive`
- Manual theme download: No update path, harder to maintain
- Vendor theme files directly: Loses connection to upstream updates

**Installation Commands**:
```bash
# Method 1: Hugo Modules (preferred)
hugo mod init github.com/username/blog
hugo mod get github.com/theNewDynamic/gohugo-theme-ananke

# Method 2: Git Submodule (fallback)
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
```

### 3. Content Organization Structure

**Decision**: Use Hugo's default content structure with `content/posts/` for blog posts and `content/` root for pages

**Rationale**:
- Follows Hugo conventions and best practices
- Ananke theme expects this structure
- Clear separation between posts (dated content) and pages (static content)
- Supports future expansion (categories, tags, sections)

**Structure**:
```
content/
├── posts/
│   ├── my-first-post.md
│   └── another-post.md
├── about.md
└── disclaimer.md
```

**Alternatives Considered**:
- Flat structure (all content in root): Harder to organize as blog grows
- Custom section names: Requires theme configuration, less standard

### 4. Post Frontmatter Schema

**Decision**: Use YAML frontmatter with required fields: title, date, draft

**Rationale**:
- YAML is more readable than TOML for non-technical users
- Hugo supports all formats (YAML, TOML, JSON)
- Required fields align with spec requirements (title, date)
- `draft: true` flag prevents accidental publication

**Schema**:
```yaml
---
title: "Post Title"
date: 2025-11-11T10:00:00-05:00
draft: false
description: "Optional meta description for SEO"
---
```

**Alternatives Considered**:
- TOML frontmatter: Less readable for non-technical authors
- JSON frontmatter: Too verbose
- Minimal frontmatter: Missing useful metadata for SEO

### 5. Excerpt Handling Strategy

**Decision**: Use Hugo's `.Summary` variable with custom word-based truncation

**Rationale**:
- Hugo's `.Summary` automatically truncates at 70 words or first `<!--more-->` tag
- Can be customized in config to match spec requirements (150-200 chars)
- Supports manual excerpts via `<!--more-->` marker
- Respects word boundaries by default

**Configuration**:
```toml
# config.toml
[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = false
```

**Implementation**:
- For posts < 150 chars: Show full content
- For posts >= 150 chars: Use Hugo's summary truncation with "..." appended
- Custom shortcode if needed for exact 200-char word-boundary logic

**Alternatives Considered**:
- Character-based truncation: Can break mid-word (spec rejects this)
- First paragraph only: May be too long or too short
- Manual excerpts only: Requires authors to always provide excerpts

### 6. Empty State Message Implementation

**Decision**: Use Hugo conditional in list template to check if posts exist

**Rationale**:
- Simple conditional in `layouts/_default/list.html` or theme override
- No additional dependencies or plugins needed
- Maintainable and testable

**Implementation**:
```go-template
{{ if .Pages }}
  <!-- List posts -->
{{ else }}
  <p>These aren't the posts you're looking for... yet</p>
{{ end }}
```

**Alternatives Considered**:
- JavaScript-based message: Unnecessary complexity, fails without JS
- Custom Hugo shortcode: Overkill for simple conditional

### 7. Navigation Menu Configuration

**Decision**: Define navigation in `config.toml` using Hugo's menu system

**Rationale**:
- Centralized menu configuration
- Theme-agnostic (works with any Hugo theme)
- Easy to maintain and update
- Supports nested menus and external links if needed later

**Configuration**:
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

**Alternatives Considered**:
- Hardcoded navigation in templates: Not maintainable
- Frontmatter-based: Less centralized
- Custom data files: Unnecessarily complex

### 8. Accessibility Validation Process

**Decision**: Use WAVE browser extension + Lighthouse in Chrome DevTools

**Rationale**:
- WAVE (https://wave.webaim.org/) provides detailed WCAG compliance reports
- Lighthouse includes accessibility audits with actionable recommendations
- Both tools are free and well-maintained
- Covers automated accessibility testing comprehensively

**Testing Process**:
1. Build site: `hugo server`
2. Run WAVE extension on each page type (home, post, about, disclaimer)
3. Run Lighthouse audit
4. Document any issues in implementation
5. Fix and re-test

**Alternatives Considered**:
- axe DevTools: Good but less detailed than WAVE
- Pa11y: Requires Node.js setup, command-line only
- Manual testing only: Misses automated checks

### 9. Build and Deployment Strategy

**Decision**: Local build with `hugo` command, deploy static output from `public/` directory

**Rationale**:
- Simplest deployment model (file copy)
- Works with any static hosting (Netlify, GitHub Pages, S3, nginx)
- No build pipeline required initially
- Can add CI/CD later if needed

**Build Process**:
```bash
# Development
hugo server -D  # includes drafts

# Production build
hugo  # outputs to public/

# Deploy (example)
rsync -avz --delete public/ user@server:/var/www/blog/
# or
git push  # for GitHub Pages
# or
netlify deploy --prod
```

**Git Configuration**:
```gitignore
/public/
/resources/_gen/
.hugo_build.lock
```

**Alternatives Considered**:
- CI/CD from start: Premature optimization, adds complexity
- Server-side Hugo builds: Violates constitution (static files only)
- Hugo hosting on server: Unnecessary, static files sufficient

### 10. Performance Optimization

**Decision**: Use Hugo's built-in asset processing and configure Ananke theme for optimal performance

**Rationale**:
- Hugo's asset pipeline handles minification, fingerprinting
- Ananke theme is already optimized
- Can add image processing later if needed
- Focus on achieving performance goals from spec (<500KB, FCP<1.5s, LCP<2.5s)

**Configuration**:
```toml
[minify]
  disableCSS = false
  disableHTML = false
  disableJS = false
  disableJSON = false
  disableSVG = false
  disableXML = false
```

**Image Optimization** (future enhancement):
- Hugo can resize and convert images to WebP
- Will implement if page weight exceeds 500KB threshold

**Alternatives Considered**:
- External build tools (webpack, parcel): Unnecessary complexity
- CDN from start: Premature, assess after deployment
- Image optimization plugins: Add only if needed

## Technology Stack Summary

| Component | Technology | Version | Rationale |
|-----------|-----------|---------|-----------|
| Static Site Generator | Hugo Extended | v0.120+ | Fast, simple, single binary, well-documented |
| Theme | Ananke | v2.12+ | WCAG AA/AAA compliant, official Hugo theme, responsive |
| Content Format | Markdown + YAML | Standard | Human-readable, git-friendly, widely supported |
| Build Output | Static HTML/CSS/JS | N/A | No server-side processing, constitution compliant |
| Deployment Target | Static file hosting | N/A | Netlify, GitHub Pages, S3, nginx - any works |
| Accessibility Testing | WAVE + Lighthouse | Latest | Free, comprehensive, actionable reports |
| Version Control | Git | Any | Constitution requires git for all content |

## Dependencies

- **Hugo Extended** (v0.120+): Static site generator
- **Ananke Theme** (v2.12+): Pre-built accessible theme
- **Git**: Version control (already required by project)

No runtime dependencies, no databases, no external services.

## Performance Targets Verification

From spec and constitution:

| Metric | Target | Hugo/Ananke Capability |
|--------|--------|------------------------|
| Homepage load time | < 2 seconds | ✅ Static files load in milliseconds |
| Page weight (text) | < 500KB | ✅ Hugo generates minimal HTML, Ananke lightweight |
| Mobile responsive | 320px+ | ✅ Ananke supports 320px-2560px |
| FCP | < 1.5s | ✅ Static HTML renders immediately |
| LCP | < 2.5s | ✅ No server processing, instant content |
| CLS | < 0.1 | ✅ Static layout, no dynamic shifts |
| WCAG 2.1 AA/AAA | Pass | ✅ Ananke verified via WAVE |

## Open Questions

None - all technical decisions resolved through research.

## Next Steps

1. Proceed to Phase 1: Design & Contracts
2. Create data-model.md (content structure)
3. Document API contracts (if applicable - likely N/A for static site)
4. Generate quickstart.md (build and run instructions)
5. Update agent context with Hugo + Ananke
