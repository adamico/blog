# Implementation Plan: Hugo Blog Basic Setup

**Branch**: `001-hugo-basic-setup` | **Date**: 2025-11-11 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/001-hugo-basic-setup/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Implement a basic Hugo static site generator blog with the Ananke theme. The blog will display recent posts on a homepage with smart excerpt truncation, include About and Disclaimer pages accessible via navigation, and meet WCAG 2.1 AA/AAA accessibility standards. Content is written in Markdown, stored in filesystem, and built to static HTML files for deployment to any static hosting service. No external dependencies, databases, or authentication required.

## Technical Context

**Language/Version**: Go 1.21+ (Hugo binary) + Markdown for content  
**Primary Dependencies**: Hugo v0.120+, Ananke theme v2.12+  
**Storage**: Filesystem (Markdown files with YAML/TOML frontmatter)  
**Testing**: Manual testing via Hugo server, accessibility validation via WAVE (https://wave.webaim.org/)  
**Target Platform**: Static HTML/CSS/JS output deployable to any web server or static hosting (Netlify, GitHub Pages, S3, nginx)  
**Project Type**: Single project (static site generator)  
**Performance Goals**: Homepage load < 2 seconds on broadband, < 500KB page weight (text), FCP < 1.5s, LCP < 2.5s  
**Constraints**: No databases, no external APIs, no server-side processing, WCAG 2.1 AA/AAA compliance, 320px minimum width  
**Scale/Scope**: Personal/small blog (10-100 posts expected), single author initially, no user accounts or authentication

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### I. Simplicity First
✅ **PASS** - Hugo is a simple static site generator with no runtime dependencies. Content is plain Markdown files. Ananke theme is pre-built (no custom CSS/JS development). Build process is single command (`hugo`). Deployment is file copy.

### II. Content-First Architecture
✅ **PASS** - Content stored as Markdown files in filesystem (`content/posts/`, `content/about.md`). Frontmatter (YAML) for metadata alongside content. No database. Intuitive folder structure. Git-friendly text files.

### III. Zero External Dependencies (NON-NEGOTIABLE)
✅ **PASS** - No external APIs. No databases. No authentication services. No runtime calls to external services. All content committed to repository. Blog functions completely offline after build.

### IV. Fast Build & Deploy
✅ **PASS** - Hugo builds in milliseconds to seconds (incremental builds supported). Deploy is static file copy or `git push` (GitHub Pages, Netlify). No complex CI/CD required for basic setup.

### V. Universal Accessibility
✅ **PASS** - Ananke theme verified WCAG 2.1 AA/AAA compliant via WAVE testing. Responsive design 320px-2560px. Semantic HTML. Keyboard navigation. Will validate with WAVE tool post-implementation.

**Specific Requirements Check**:
- Responsive 320px+: Ananke theme supports this
- Touch targets 44×44px: Theme provides appropriate sizing
- Color contrast 4.5:1 / 3:1: Verified via WAVE
- Screen reader compatible: Theme uses semantic HTML and ARIA
- Dyslexia-friendly fonts: Ananke uses Avenir (sans-serif), configurable
- Line length < 70-80 chars: Theme defaults to readable line lengths
- Left-aligned text: Default behavior

### VI. Performance First
✅ **PASS** - Static HTML output optimized by default. Hugo generates minimal JS. Ananke theme is lightweight. Page weight target < 500KB achievable. Will verify Core Web Vitals (FCP, LCP, CLS) post-build.

**Specific Requirements Check**:
- Page weight < 500KB (text): Hugo + Ananke produces minimal output
- FCP < 1.5s, LCP < 2.5s, CLS < 0.1: Static sites excel at these metrics
- Image optimization: Hugo supports image processing, will configure WebP/AVIF
- Critical CSS inline: Ananke theme handles this
- Font loading: Will configure `font-display: swap`

### Technical Constraints Check
✅ **PASS** - Storage: filesystem only. Auth: none. Build tools: Hugo binary (optional for content authors who can use Markdown preview). Hosting: static file hosting supported. Dependencies: minimal (Hugo + theme).

### Quality Standards Check
✅ **PASS** - Content validation: Hugo validates frontmatter. Testing: Manual + WAVE accessibility testing. Documentation: Will create README. Version control: All content in git, `public/` directory (build output) will be gitignored.

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
blog/
├── archetypes/            # Content templates (Hugo default archetypes)
│   └── default.md        # Default frontmatter template for new content
├── content/              # All Markdown content (committed to git)
│   ├── posts/           # Blog posts (one .md file per post)
│   │   ├── my-first-post.md
│   │   ├── second-post.md
│   │   └── ...
│   ├── about.md         # About page (static page)
│   └── disclaimer.md    # Disclaimer page (static page)
├── layouts/             # Custom layout overrides (initially empty, theme provides defaults)
├── static/              # Static assets (images, robots.txt, favicon, etc.)
│   └── images/         # User-uploaded images for posts
├── themes/              # Hugo themes directory
│   └── ananke/         # Ananke theme (Git submodule or Hugo module)
├── public/              # Generated static site (GITIGNORED - build output)
│   ├── index.html      # Homepage
│   ├── posts/          # Individual post pages
│   ├── about/
│   ├── disclaimer/
│   └── css/, js/, etc. # Compiled assets
├── config.toml          # Hugo site configuration (committed to git)
│   # Contains: site title, baseURL, theme, menu definitions, params
├── go.mod               # Hugo modules (if using Hugo Modules for theme)
├── go.sum               # Hugo module checksums
├── .gitignore           # Git ignore file (excludes public/, resources/)
└── README.md            # Project documentation (Hugo setup, build instructions)
```

**Structure Decision**: Hugo static site generator with filesystem-based content storage. All content lives in `content/` as Markdown files with YAML frontmatter (see [data-model.md](data-model.md) for entity schemas). Hugo processes these files + theme templates to generate static HTML in `public/` directory. Ananke theme provides all layout templates (no custom layouts needed for basic setup). Configuration centralized in `config.toml` including navigation menu, site metadata, and theme parameters. Build output (`public/`) is ephemeral and gitignored; all source files are committed. This aligns with Constitution principles II (Content-First) and III (Zero External Dependencies).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

**No violations detected** - all Constitution principles passed. No complexity tracking required.
