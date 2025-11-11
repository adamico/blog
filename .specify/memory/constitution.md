<!--
Sync Impact Report - Constitution v1.1.0

Version Change: 1.0.0 → 1.1.0
Change Type: MINOR (New principle added, existing principle split)
Date: 2025-11-11

Modified Principles:
  - V. "Accessibility & Performance" → separated into two principles:
    - V. "Universal Accessibility" (expanded with responsive design, visual impairments, dyslexia)
    - VI. "Performance First" (focused on page weight and load times)

Added Sections:
  - New Principle VI: Performance First
  - Expanded Principle V with detailed accessibility requirements:
    * Responsive behavior across devices
    * Visual impairment accommodations (screen readers, contrast, focus indicators)
    * Dyslexia-friendly typography and layout
    * Keyboard navigation requirements

Removed Sections:
  - N/A

Templates Status:
  ✅ plan-template.md - Constitution Check section aligns with expanded principles
  ✅ spec-template.md - Requirements structure supports detailed accessibility criteria
  ✅ tasks-template.md - Task organization reflects accessibility and performance as separate concerns
  ✅ checklist-template.md - Quality gates support expanded accessibility validation

Follow-up TODOs:
  - None (all placeholders filled)

Rationale:
  Accessibility and performance are both critical but distinct concerns. Separating them
  allows for more detailed requirements in each area. The expanded accessibility section
  provides concrete, testable criteria for responsive design and support for users with
  visual impairments and dyslexia.
-->

# Static Blog Constitution

## Core Principles

### I. Simplicity First

Every feature MUST be implemented with the simplest approach that meets requirements.
Static files MUST be preferred over dynamic generation. Content MUST be readable without
build tools. No external dependencies UNLESS absolutely justified and documented.

**Rationale**: Static blogs should remain simple, maintainable, and resilient. Complexity
creep leads to fragile systems requiring constant maintenance. Simple solutions are
easier to debug, migrate, and understand.

### II. Content-First Architecture

Content MUST be the source of truth. Markdown files MUST be human-readable and editable
without specialized tools. Content structure MUST be filesystem-based using intuitive
folder hierarchies. Metadata MUST live alongside content (frontmatter, not databases).

**Rationale**: Writers should focus on content, not tooling. Version control works best
with text files. Filesystem organization is universally understood and git-friendly.

### III. Zero External Dependencies (NON-NEGOTIABLE)

No external APIs, no databases, no authentication services. The blog MUST function
completely offline after initial build. All data MUST be committed to the repository.
No runtime calls to external services.

**Rationale**: External dependencies create failure points, increase complexity, and
reduce portability. Static blogs should be self-contained archives that work anywhere.

### IV. Fast Build & Deploy

Build process MUST complete in seconds, not minutes. Incremental builds MUST be
supported where applicable. Deploy process MUST be simple file copy or git push. No
complex CI/CD pipelines unless justified by scale.

**Rationale**: Fast iteration improves content creation experience. Simple deployment
reduces friction and maintenance burden. Writers shouldn't wait for slow builds.

### V. Universal Accessibility

All content MUST be accessible to users with disabilities. Generated HTML MUST be
semantic and follow WCAG 2.1 AA standards minimum. Every interactive element MUST be
keyboard navigable with visible focus indicators. Color MUST NOT be the sole means of
conveying information.

**Responsive Design Requirements**:
- Layout MUST adapt gracefully to viewport widths from 320px to 2560px
- Touch targets MUST be minimum 44×44 CSS pixels on mobile devices
- Text MUST be readable without horizontal scrolling at 320px viewport width
- Breakpoints MUST be content-driven, not device-specific
- Images MUST be responsive using srcset or CSS techniques
- No content or functionality MUST be hidden at any viewport size

**Visual Impairment Accommodations**:
- All images MUST have descriptive alt text (not decorative placeholder text)
- Color contrast MUST meet WCAG AA standards (4.5:1 for normal text, 3:1 for large text)
- Focus indicators MUST have 3:1 contrast ratio against background
- Text MUST be resizable up to 200% without loss of content or functionality
- Screen reader compatibility MUST be tested with NVDA, JAWS, or VoiceOver
- Skip navigation links MUST be provided for keyboard users
- ARIA landmarks MUST be used appropriately (not overused)
- All form inputs MUST have associated labels (visible or aria-label)

**Dyslexia-Friendly Design**:
- Font families MUST be sans-serif and dyslexia-friendly (e.g., Open Sans, Verdana, Arial)
- Font size MUST be minimum 16px (1rem) for body text, 18px preferred
- Line height MUST be minimum 1.5 for body text, 1.75 preferred
- Line length MUST NOT exceed 70-80 characters (optimal: 50-60 characters)
- Text alignment MUST be left-aligned (not justified, which creates rivers of whitespace)
- Paragraph spacing MUST be at least 1.5× the line height
- Sufficient whitespace MUST be provided around text blocks and interactive elements
- Text MUST NOT use ALL CAPS for extended passages (only sparingly for emphasis)
- Links MUST be distinguishable by more than color alone (underline or weight)

**Rationale**: Accessibility is not optional—it's a legal and ethical requirement.
Approximately 15% of the global population has some form of disability. Dyslexia affects
10-20% of people. Responsive design ensures content works on any device. These
requirements are testable, measurable, and significantly improve usability for everyone.

### VI. Performance First

Generated pages MUST load quickly on slow connections. CSS MUST load progressively
without blocking initial render. Images MUST be optimized with appropriate formats and
sizes. JavaScript MUST be minimal and non-blocking. Client-side frameworks MUST NOT be
used unless justified for specific interactive features requiring them.

**Performance Requirements**:
- Total page weight MUST be < 500KB for text-heavy pages (articles, blog posts)
- Total page weight MUST be < 1MB for media-rich pages (image galleries, multimedia)
- First Contentful Paint (FCP) MUST be < 1.5 seconds on 3G connection
- Largest Contentful Paint (LCP) MUST be < 2.5 seconds
- Cumulative Layout Shift (CLS) MUST be < 0.1
- Images MUST use WebP or AVIF with JPEG fallback
- Images MUST be lazy-loaded below the fold
- Critical CSS MUST be inlined; non-critical CSS loaded asynchronously
- Fonts MUST use font-display: swap to prevent invisible text
- No more than 2-3 web font families; prefer system fonts where appropriate

**Rationale**: Static blogs should be fast by default. Many users access content on
slow or metered connections. Heavy JavaScript frameworks contradict the simplicity
principle and harm performance. Fast sites have better engagement, SEO, and conversion.
Performance is a feature, not an optimization.

## Technical Constraints

**Storage**: Filesystem only. No databases, no key-value stores, no external storage.

**Authentication**: None. If admin features needed, use separate tools or git-based workflows.

**Build Tools**: MUST be optional for content creation. Writers MUST be able to preview
content without running builds (markdown preview, local file:// protocol).

**Hosting**: MUST support static file hosting (S3, Netlify, GitHub Pages, nginx, etc.).
No server-side processing required.

**Dependencies**: If a build tool is used, dependencies MUST be minimal and well-maintained.
Prefer standard library over third-party packages. Document dependency rationale.

## Quality Standards

**Content Validation**: Broken links MUST be detected during build. Required frontmatter
fields MUST be validated. Image references MUST be verified.

**Testing**: Template rendering MUST be testable. Build process MUST have smoke tests.
Generated HTML MUST be valid. Testing infrastructure should be simple (no heavy frameworks).

**Documentation**: README MUST explain content structure, build process, and deployment.
New content authors MUST be able to contribute with minimal instruction.

**Version Control**: All content, configuration, and templates MUST be in git. Generated
files (build output) SHOULD be gitignored unless required for deployment strategy.

## Governance

This constitution is the authority for all architectural and implementation decisions.
All feature specifications, implementation plans, and tasks MUST comply with these
principles. Any deviation MUST be explicitly justified in a Complexity Tracking section
with documented rationale.

**Amendment Process**: Constitution changes require documentation of impact across all
templates and active features. Version bumps MUST follow semantic versioning: MAJOR for
breaking principle changes, MINOR for new principles, PATCH for clarifications.

**Compliance Review**: During `/speckit.plan`, Constitution Check section MUST verify
adherence to all principles. Violations flagged during analysis MUST be resolved before
implementation proceeds.

**Complexity Justification**: If a principle must be violated (e.g., adding external
dependency for critical analytics), document: (1) specific need, (2) why simpler
alternative insufficient, (3) mitigation strategy for introduced complexity.

**Version**: 1.1.0 | **Ratified**: 2025-11-11 | **Last Amended**: 2025-11-11
