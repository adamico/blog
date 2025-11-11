#!/bin/bash
# Script to fetch images from old Octopress blog (adamico/oraomai)
# and place them in Hugo static directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BLOG_DIR="$(dirname "$SCRIPT_DIR")"
TEMP_DIR="/tmp/fetch-blog-images-$$"
OLD_BLOG_REPO="https://github.com/adamico/oraomai.git"
TARGET_DIR="$BLOG_DIR/static/images"

echo "🖼️  Fetching Blog Images Script"
echo "================================"
echo ""
echo "Source: $OLD_BLOG_REPO"
echo "Target: $TARGET_DIR/"
echo ""

# Create temp directory
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Clone old blog
echo "📥 Cloning old blog repository..."
git clone --depth 1 "$OLD_BLOG_REPO" old-blog
cd old-blog

# Check if images directory exists
if [ ! -d "source/images" ]; then
    echo "❌ Error: source/images directory not found in repository"
    echo "   Available directories:"
    ls -la source/ 2>/dev/null || echo "   source/ directory not found"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Count images
IMAGE_COUNT=$(find source/images -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) 2>/dev/null | wc -l)
echo "✅ Found $IMAGE_COUNT images to copy"
echo ""

# Create target directories
mkdir -p "$TARGET_DIR"

# Copy images preserving directory structure
echo "📸 Copying images..."

# Find all image files and copy them
find source/images -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | while read -r img; do
    # Get relative path from source/images
    rel_path="${img#source/images/}"
    target_path="$TARGET_DIR/$rel_path"
    
    # Create directory if needed
    target_dir=$(dirname "$target_path")
    mkdir -p "$target_dir"
    
    # Copy file
    cp "$img" "$target_path"
    
    # Get file size
    if [ -f "$target_path" ]; then
        size=$(du -h "$target_path" | cut -f1)
        echo "   ✅ $rel_path ($size)"
    fi
done

echo ""
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

echo ""
echo "✨ Image fetch complete!"
echo ""
echo "📁 Images are in: $TARGET_DIR/"
echo ""

# Show directory structure
echo "📂 Directory structure:"
if command -v tree &> /dev/null; then
    tree "$TARGET_DIR" -L 2
else
    find "$TARGET_DIR" -type d | head -10
fi

echo ""
echo "📋 Next steps:"
echo "   1. Review images in static/images/"
echo "   2. Update posts to use proper Markdown image syntax"
echo "   3. Example: ![Alt text](/images/photos/IMGP7959.jpg)"
echo "   4. Run 'hugo server' to preview"
echo "   5. Commit images to git: git add static/images/ && git commit"
echo ""

# Check for specific images referenced in migrated posts
echo "🔍 Checking for images referenced in migrated posts..."
echo ""

check_image() {
    local img_path="$1"
    local post_name="$2"
    if [ -f "$TARGET_DIR/$img_path" ]; then
        echo "   ✅ Found: $img_path (referenced in '$post_name')"
        return 0
    else
        echo "   ❌ Missing: $img_path (referenced in '$post_name')"
        return 1
    fi
}

# Check for images from migrated posts
check_image "photos/IMGP7959.jpg" "5 e 6"
check_image "photos/IMGP8076.jpg" "Oubliettes"

echo ""
echo "💡 To enable images in your posts, edit:"
echo "   - content/posts/5-e-6.md"
echo "   - content/posts/oubliettes.md"
echo ""
echo "   Change HTML comment to Markdown:"
echo "   <!-- Image: /images/photos/IMGP7959.jpg -->"
echo "   To: ![5 e 6](/images/photos/IMGP7959.jpg)"
