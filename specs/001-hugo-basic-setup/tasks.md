# Tasks: Hugo Blog Basic Setup

**Input**: Design documents from `/specs/001-hugo-basic-setup/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md

**Tests**: No explicit test tasks included (manual validation via Hugo server and WAVE/Lighthouse tools as specified in plan.md)

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Project Initialization)

**Purpose**: Initialize Hugo project structure and install dependencies

- [x] T001 Install Hugo Extended v0.120+ via Homebrew: `brew install hugo`
- [x] T002 Verify Hugo installation and version: `hugo version` (must show "extended")
- [x] T003 Initialize Hugo site in project root: `hugo new site . --force`
- [x] T004 Initialize Go modules for Hugo Modules: `hugo mod init github.com/kc00l/blog`
- [x] T005 Install Ananke theme as Hugo Module: `hugo mod get github.com/theNewDynamic/gohugo-theme-ananke`
- [x] T006 Create or update .gitignore file in project root with Hugo build artifacts: `/public/`, `/resources/_gen/`, `.hugo_build.lock`
- [x] T007 Create archetypes/default.md with default frontmatter template for posts

**Checkpoint**: Hugo project structure created, theme installed, ready for configuration

---

## Phase 2: Foundational (Core Configuration)

**Purpose**: Configure Hugo site, theme, and navigation menu (MUST be complete before content creation)

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T008 Configure config.toml with site metadata (baseURL, languageCode, title, theme, paginate=10)
- [x] T009 Configure navigation menu in config.toml with Home, About, Disclaimer links
- [x] T010 Configure Ananke theme parameters in config.toml (description, show_reading_time, read_more_copy)
- [x] T011 Configure markup settings in config.toml (Goldmark renderer, unsafe=false)
- [x] T012 Configure minification settings in config.toml (CSS, HTML, JS minification enabled)
- [x] T013 Test Hugo server runs without errors: `hugo server -D`

**Checkpoint**: Foundation ready - content creation can now begin

---

## Phase 3: User Story 1 - View Recent Blog Posts (Priority: P1) 🎯 MVP

**Goal**: Display homepage with recent blog posts, smart excerpts, and empty state handling

**Independent Test**: Start Hugo server (`hugo server`), navigate to `http://localhost:1313/`, verify posts are listed with titles, dates, excerpts, and clickable links to full posts. If no posts exist, verify empty state message displays.

### Implementation for User Story 1

- [x] T014 [P] [US1] Create content/posts/ directory for blog posts
- [x] T015 [P] [US1] Create first sample blog post: `hugo new posts/my-first-post.md` with title, date, draft=false, description, and content (>200 chars to test excerpt truncation)
- [x] T016 [P] [US1] Create second sample blog post: `hugo new posts/hugo-is-awesome.md` with different content (<150 chars to test full content display)
- [x] T017 [P] [US1] Create third sample blog post: `hugo new posts/static-sites-rock.md` for pagination testing
- [x] T018 [US1] Verify homepage displays posts in reverse chronological order via Hugo server
- [x] T019 [US1] Verify post excerpts follow smart truncation rules (full if <150 chars, truncated at word boundary before 200 chars with "..." if longer)
- [x] T020 [US1] Verify post titles are clickable and navigate to full post pages
- [x] T021 [US1] Verify publication dates display in human-readable format (e.g., "November 11, 2025")
- [x] T022 [US1] Test empty state: temporarily remove all posts from content/posts/, verify message "These aren't the posts you're looking for... yet" appears (if not supported by Ananke theme, create theme override in layouts/_default/list.html with conditional: {{ if .Pages }}...{{ else }}<p>These aren't the posts you're looking for... yet</p>{{ end }})
- [x] T023 [US1] Verify maximum 10 posts display on homepage (create 11+ posts if needed for testing)
- [x] T024 [US1] Verify full post page displays title, date, and complete content when clicking post title
- [x] T024a [US1] Verify Markdown rendering works correctly (test bold, italic, links, lists, code blocks, headings in sample posts)

**Checkpoint**: User Story 1 (View Recent Blog Posts) is fully functional - homepage displays posts, excerpts work, navigation works, empty state works

---

## Phase 4: User Story 2 - Learn About the Blog (Priority: P2)

**Goal**: Create About page accessible from navigation

**Independent Test**: Navigate to About page via navigation menu, verify content displays correctly and navigation remains functional

### Implementation for User Story 2

- [x] T025 [US2] Create About page: `hugo new about.md` in content/ root (not in posts/)
- [x] T026 [US2] Add frontmatter to content/about.md (title: "About", description: "Learn about this blog")
- [x] T027 [US2] Add content to content/about.md describing blog purpose and author
- [x] T028 [US2] Verify About page is accessible via navigation menu at http://localhost:1313/about/
- [x] T029 [US2] Verify About page displays content correctly
- [x] T030 [US2] Verify navigation menu remains visible and functional on About page

**Checkpoint**: User Story 2 (Learn About the Blog) is fully functional - About page accessible and displays correctly

---

## Phase 5: User Story 3 - Review Legal Information (Priority: P3)

**Goal**: Create Disclaimer page accessible from navigation

**Independent Test**: Navigate to Disclaimer page via navigation menu, verify legal content displays correctly

### Implementation for User Story 3

- [x] T031 [US3] Create Disclaimer page: `hugo new disclaimer.md` in content/ root (not in posts/)
- [x] T032 [US3] Add frontmatter to content/disclaimer.md (title: "Disclaimer", description: "Legal disclaimer and terms of use")
- [x] T033 [US3] Add legal disclaimer content to content/disclaimer.md
- [x] T034 [US3] Verify Disclaimer page is accessible via navigation menu at http://localhost:1313/disclaimer/
- [x] T035 [US3] Verify Disclaimer page displays content correctly
- [x] T036 [US3] Verify navigation menu remains visible and functional on Disclaimer page

**Checkpoint**: User Story 3 (Review Legal Information) is fully functional - Disclaimer page accessible and displays correctly

---

## Phase 6: Polish & Validation

**Purpose**: Accessibility validation, performance testing, documentation, and production build

- [ ] T037 [P] Build production site: `hugo --minify` (outputs to public/ directory)
- [ ] T038 [P] Create README.md in project root with Hugo setup instructions, build commands, and deployment notes (reference quickstart.md)
- [ ] T039 Run WAVE accessibility test on homepage (http://localhost:1313/) - verify WCAG 2.1 AA/AAA compliance
- [ ] T040 Run WAVE accessibility test on sample blog post page - verify accessibility
- [ ] T041 Run WAVE accessibility test on About page - verify accessibility
- [ ] T042 Run WAVE accessibility test on Disclaimer page - verify accessibility
- [ ] T043 Run Lighthouse audit on homepage - verify Accessibility score ≥90, Performance score ≥90
- [ ] T044 Verify Core Web Vitals targets: FCP < 1.5s, LCP < 2.5s, CLS < 0.1
- [ ] T045 Test responsive design at 320px width (mobile) - verify no horizontal scrolling, content readable
- [ ] T046 Test responsive design at 768px width (tablet) - verify layout adapts correctly
- [ ] T047 Test responsive design at 1920px width (desktop) - verify layout uses available space
- [ ] T048 Verify page weight < 500KB for homepage (text content) using browser DevTools Network tab
- [ ] T049 Verify homepage loads in < 2 seconds on broadband connection
- [ ] T050 Test navigation from homepage to About in ≤2 clicks
- [ ] T051 Test navigation from homepage to Disclaimer in ≤2 clicks
- [ ] T052 Verify all frontmatter fields are valid (title, date in ISO 8601 format, no parse errors)
- [ ] T053 Verify build completes without errors or warnings: `hugo --buildDrafts=false`
- [ ] T054 Commit all source files to git (content/, config.toml, archetypes/, README.md)
- [ ] T055 Verify public/ directory is gitignored and not committed

**Checkpoint**: All validation complete, production build successful, ready for deployment

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup (Phase 1) completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational (Phase 2) completion
  - User stories can proceed sequentially in priority order (P1 → P2 → P3)
  - User stories are independent (creating About page doesn't affect blog posts functionality)
- **Polish (Phase 6)**: Depends on all user stories (Phases 3-5) being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Independent of US1 (About page doesn't depend on blog posts)
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Independent of US1/US2 (Disclaimer page is standalone)

### Within Each User Story

- **US1**: Sample posts (T015-T017) can be created in parallel, then verification tasks (T018-T024) run sequentially
- **US2**: Content creation (T025-T027) before verification (T028-T030)
- **US3**: Content creation (T031-T033) before verification (T034-T036)

### Parallel Opportunities

- **Phase 1**: T007 can run independently after T003
- **Phase 2**: T008-T012 can be done together (all editing config.toml), T013 must run last
- **Phase 3 (US1)**: T014, T015, T016, T017 marked [P] - can create all sample posts in parallel
- **Phase 6**: T037, T038 marked [P] - production build and README can happen in parallel; T039-T042 (WAVE tests) can run in parallel after build complete

---

## Parallel Example: User Story 1

```bash
# Launch all content creation for User Story 1 together:
Task T014: "Create content/posts/ directory"
Task T015: "Create first sample blog post: hugo new posts/my-first-post.md"
Task T016: "Create second sample blog post: hugo new posts/hugo-is-awesome.md"
Task T017: "Create third sample blog post: hugo new posts/static-sites-rock.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001-T007)
2. Complete Phase 2: Foundational (T008-T013) - **CRITICAL**
3. Complete Phase 3: User Story 1 (T014-T024)
4. **STOP and VALIDATE**: Test homepage with posts independently
5. Optional: Complete minimal polish (T037 production build, T039 WAVE test, T043 Lighthouse)
6. Deploy MVP (functioning blog with posts)

### Incremental Delivery

1. Complete Setup + Foundational (Phases 1-2) → Foundation ready (T001-T013)
2. Add User Story 1 (Phase 3: T014-T024) → Test independently → Deploy/Demo (MVP! - functioning blog)
3. Add User Story 2 (Phase 4: T025-T030) → Test independently → Deploy/Demo (blog + about page)
4. Add User Story 3 (Phase 5: T031-T036) → Test independently → Deploy/Demo (blog + about + disclaimer)
5. Complete Polish (Phase 6: T037-T055) → Production-ready deployment
6. Each story adds value without breaking previous stories

### Single Developer Strategy

Work sequentially by priority:

1. Phase 1: Setup (initialize Hugo, install theme)
2. Phase 2: Foundational (configure Hugo, navigation, theme)
3. Phase 3: User Story 1 (create blog posts, verify homepage)
4. Phase 4: User Story 2 (create About page)
5. Phase 5: User Story 3 (create Disclaimer page)
6. Phase 6: Polish (accessibility validation, performance testing, production build)

---

## Success Criteria Validation

After completing all phases, verify against spec success criteria:

- **SC-001**: Homepage loads in < 2 seconds (T049)
- **SC-002**: Navigate homepage → About in ≤2 clicks (T050)
- **SC-003**: Navigate homepage → Disclaimer in ≤2 clicks (T051)
- **SC-004**: Readable without horizontal scrolling at 320px (T045)
- **SC-005**: Page weight < 500KB (T048)
- **SC-006**: Post titles clickable to full post (T020, T024)
- **SC-007**: Smart excerpt truncation (T019)
- **SC-008**: Build to static files without errors (T037, T053)
- **SC-009**: Consistent navigation on all pages (T030, T036)
- **SC-010**: New post appears on homepage after rebuild (verified by T018)

---

## Notes

- All tasks use file paths relative to project root (`/home/kc00l/blog`)
- Hugo commands assume working directory is project root
- [P] tasks = different files or independent operations, no blocking dependencies
- [Story] label maps task to specific user story for traceability
- Each user story is independently completable and testable
- Manual validation via Hugo server (`hugo server`) and browser testing (no automated test suite)
- Accessibility validation via WAVE browser extension (https://wave.webaim.org/) and Lighthouse
- Commit after completing each phase or logical group of tasks
- Stop at any checkpoint to validate story independently before proceeding
- Constitution compliance verified in plan.md (all 6 principles PASS)
