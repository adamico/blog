# Hugo Image Support Guide

Hugo has excellent support for embedded images stored in your GitHub repository!

## How It Works

### 1. **Static Directory** (`/static/`)
- Files in `static/` are copied directly to the site root when Hugo builds
- Example: `static/images/photo.jpg` → `http://yoursite.com/images/photo.jpg`

### 2. **Image Syntax in Markdown**

```markdown
![Alt text](/images/photo.jpg)
![Alt text with title](/images/photo.jpg "Photo Title")
```

### 3. **Directory Structure**

```
blog/
├── static/
│   ├── images/          # Your images here
│   │   ├── posts/      # Post-specific images
│   │   ├── photos/     # Photography
│   │   └── icons/      # Icons, logos
│   ├── favicon.ico
│   └── robots.txt
└── content/
    └── posts/
        └── my-post.md  # Reference: ![Photo](/images/posts/myimage.jpg)
```

## Example Usage

### In a blog post:

```markdown
---
title: "My Photo Post"
date: 2025-11-11
description: "A post with images"
---

Here's my photo:

![Beautiful sunset](/images/photos/sunset.jpg)

You can also use HTML for more control:

<img src="/images/photos/sunset.jpg" alt="Sunset" width="500">
```

### Benefits

✅ **Version controlled**: Images committed to git with your content  
✅ **Self-contained**: No external dependencies or image hosts  
✅ **Fast**: Served as static files alongside your HTML  
✅ **Portable**: Works anywhere you deploy Hugo  
✅ **Safe for public repos**: Only commit images you want public

## Image Optimization Tips

1. **Compress before committing**:
   - Use tools like ImageOptim, TinyPNG, or Hugo's built-in image processing
   - Target: <200KB per image for web

2. **Use appropriate formats**:
   - Photos: JPEG (smaller file size)
   - Graphics/screenshots: PNG (better quality for text)
   - Modern browsers: WebP (best compression)

3. **Responsive images** (Hugo Page Resources):
   ```
   content/
   └── posts/
       └── my-post/
           ├── index.md
           └── image.jpg  # Co-located with post
   ```

## For Your Migrated Posts

Your "5 e 6" and "Oubliettes" posts reference images:
- `/images/photos/IMGP7959.jpg`
- `/images/photos/IMGP8076.jpg`

To add them:
1. Create directory: `mkdir -p static/images/photos`
2. Copy images there
3. Uncomment the image references in the posts
4. Commit to git

## .gitignore Consideration

Your `.gitignore` already excludes:
- Build artifacts (`public/`, `resources/`)
- System files (`.DS_Store`)

But it INCLUDES `static/` - so images you add will be committed! ✅

This is correct for a blog - you want your images in version control.
