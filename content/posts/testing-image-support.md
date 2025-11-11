---
title: "Testing Image Support"
date: 2025-11-11T16:00:00Z
draft: false
description: "Demonstrating embedded images in Hugo blog"
---

## Images Work in Hugo!

Hugo has native support for embedded images stored in your repository.

### Standard Markdown Syntax

You can use standard Markdown image syntax:

```markdown
![Alt text](/images/posts/example.jpg)
```

### HTML for More Control

Or use HTML for custom sizing:

```html
<img src="/images/posts/example.jpg" alt="Description" width="600">
```

### Where to Store Images

- `/static/images/posts/` - For blog post images
- `/static/images/photos/` - For photography posts
- `/static/images/` - For general site images

### Image Best Practices

1. **Compress images** before committing (aim for <200KB)
2. **Use descriptive filenames**: `sunset-beach-2025.jpg` not `IMG_1234.jpg`
3. **Add alt text** for accessibility
4. **Commit to git** - they're part of your content!

### For Your Migrated Posts

Your old Octopress posts ("5 e 6" and "Oubliettes") had images. To restore them:

1. Find the original images (IMGP7959.jpg, IMGP8076.jpg)
2. Copy to `static/images/photos/`
3. Update the posts with: `![Description](/images/photos/IMGP7959.jpg)`

Images will be:
- ✅ Version controlled in git
- ✅ Deployed with your site
- ✅ Served as static files (fast!)
- ✅ Portable across any hosting platform
