#!/bin/bash
# Migration script to harvest posts from Jekyll blog (adamico/blog)
# Converts Jekyll posts to Hugo format

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BLOG_DIR="$(dirname "$SCRIPT_DIR")"
TEMP_DIR="/tmp/jekyll-migration-$$"
OLD_BLOG_REPO="${1:-https://github.com/adamico/blog.git}"
POSTS_DIR="${2:-_posts}"

echo "🔍 Hugo Blog Migration Script"
echo "============================="
echo ""
echo "Source: $OLD_BLOG_REPO"
echo "Target: $BLOG_DIR/content/posts/"
echo ""

# Create temp directory
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Clone old blog
echo "📥 Cloning old blog from repository..."
git clone --depth 1 "$OLD_BLOG_REPO" old-blog
cd old-blog

# Check if _posts directory exists (support both _posts and source/_posts)
POSTS_PATH=""
if [ -d "_posts" ]; then
    POSTS_PATH="_posts"
elif [ -d "source/_posts" ]; then
    POSTS_PATH="source/_posts"
else
    echo "❌ Error: _posts directory not found in repository"
    echo "   Tried: _posts, source/_posts"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "✅ Found posts in: $POSTS_PATH"

# Count posts
POST_COUNT=$(ls -1 $POSTS_PATH/*.textile $POSTS_PATH/*.md $POSTS_PATH/*.markdown 2>/dev/null | wc -l)
echo "✅ Found $POST_COUNT posts to migrate"
echo ""

# Create migration directory
mkdir -p "$BLOG_DIR/content/posts-migrated"

# Process each post
for post_file in $POSTS_PATH/*; do
    if [ ! -f "$post_file" ]; then
        continue
    fi
    
    filename=$(basename "$post_file")
    echo "📝 Processing: $filename"
    
    # Extract date from filename (Jekyll format: YYYY-MM-DD-title.ext)
    if [[ $filename =~ ^([0-9]{4})-([0-9]{2})-([0-9]{2})-(.+)\.(textile|md|markdown)$ ]]; then
        year="${BASH_REMATCH[1]}"
        month="${BASH_REMATCH[2]}"
        day="${BASH_REMATCH[3]}"
        slug="${BASH_REMATCH[4]}"
        ext="${BASH_REMATCH[5]}"
        
        # Create Hugo filename (without date prefix)
        hugo_filename="${slug}.md"
        hugo_filepath="$BLOG_DIR/content/posts-migrated/$hugo_filename"
        
        echo "   📅 Date: $year-$month-$day"
        echo "   📄 Slug: $slug"
        
        # Read the post content
        content=$(cat "$post_file")
        
        # Extract Jekyll frontmatter (between --- markers)
        if echo "$content" | grep -q "^---"; then
            # Extract frontmatter
            frontmatter=$(echo "$content" | awk '/^---$/{if(++n==2) exit; next} n==1')
            body=$(echo "$content" | awk '/^---$/{if(++n==2) {p=1; next}} p')
            
            # Extract title from frontmatter
            title=$(echo "$frontmatter" | grep "^title:" | sed 's/^title: *//' | sed 's/^"//' | sed 's/"$//')
            
            # Create Hugo frontmatter
            echo "---" > "$hugo_filepath"
            echo "title: \"$title\"" >> "$hugo_filepath"
            echo "date: ${year}-${month}-${day}T12:00:00Z" >> "$hugo_filepath"
            echo "draft: false" >> "$hugo_filepath"
            echo "description: \"Migrated from Jekyll blog\"" >> "$hugo_filepath"
            
            # Add original date as custom field for reference
            echo "# Original Jekyll post from ${year}-${month}-${day}" >> "$hugo_filepath"
            echo "---" >> "$hugo_filepath"
            echo "" >> "$hugo_filepath"
            
            # Convert Textile to Markdown if needed
            if [ "$ext" = "textile" ]; then
                echo "   🔄 Converting Textile to Markdown..."
                # Basic textile to markdown conversion
                # This is a simple conversion - you may need to manually review
                converted_body=$(echo "$body" | \
                    sed 's/h2\. /## /g' | \
                    sed 's/h3\. /### /g' | \
                    sed 's/h4\. /#### /g' | \
                    sed 's/\*\([^*]*\)\*/\*\*\1\*\*/g' | \
                    sed 's/_\([^_]*\)_/\*\1\*/g')
                echo "$converted_body" >> "$hugo_filepath"
                echo "   ⚠️  Textile converted to Markdown (manual review recommended)"
            else
                # Already Markdown, copy as-is
                echo "$body" >> "$hugo_filepath"
            fi
            
            echo "   ✅ Migrated to: $hugo_filename"
        else
            echo "   ⚠️  No frontmatter found, skipping"
        fi
    else
        echo "   ⚠️  Filename doesn't match Jekyll pattern, skipping"
    fi
    echo ""
done

# Cleanup
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

echo ""
echo "✨ Migration complete!"
echo ""
echo "📁 Migrated posts are in: $BLOG_DIR/content/posts-migrated/"
echo ""
echo "📋 Next steps:"
echo "   1. Review migrated posts for formatting issues"
echo "   2. Update descriptions in frontmatter"
echo "   3. Move posts from posts-migrated/ to posts/ when ready"
echo "   4. Run 'hugo server -D' to preview"
echo ""
echo "⚠️  Note: Textile conversion is basic. Please review:"
echo "   - Formatting (bold, italic, headings)"
echo "   - Links and images"
echo "   - Code blocks"
echo "   - Lists"
