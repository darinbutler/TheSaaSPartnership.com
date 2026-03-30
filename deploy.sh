#!/bin/bash
# ──────────────────────────────────────────────────────────
#  The SaaS Partnership — GitHub Pages Deployment Script
#  Run this from the folder containing your site files
#  Repository: https://github.com/butlerdarin/thesaaspartnership
# ──────────────────────────────────────────────────────────

set -e  # Exit on any error

REPO_URL="https://github.com/butlerdarin/thesaaspartnership.git"
BRANCH="main"

echo ""
echo "🚀  The SaaS Partnership — Deploying to GitHub Pages"
echo "────────────────────────────────────────────────────"
echo ""

# Step 1: Check we're in the right directory
if [ ! -f "index.html" ]; then
  echo "❌  Error: index.html not found."
  echo "    Please run this script from the folder containing your site files."
  exit 1
fi

echo "✅  Site files found."

# Step 2: Initialise git if not already done
if [ ! -d ".git" ]; then
  echo "⚙️   Initialising git repository..."
  git init
  git checkout -b main
else
  echo "✅  Git repository already initialised."
fi

# Step 3: Configure git identity (update with your details)
git config user.name  "Darin Butler"
git config user.email "butlerdarin@gmail.com"

# Step 4: Add remote if not already set
if ! git remote get-url origin &>/dev/null; then
  echo "⚙️   Adding remote origin..."
  git remote add origin "$REPO_URL"
else
  echo "✅  Remote origin already set."
fi

# Step 5: Stage and commit all files
echo "📦  Staging files..."
git add index.html services.html why-us.html about.html contact.html CNAME .nojekyll

echo "💾  Creating commit..."
git commit -m "Deploy: The SaaS Partnership website — $(date '+%Y-%m-%d %H:%M')" || echo "Nothing new to commit."

# Step 6: Push to GitHub
echo ""
echo "📤  Pushing to GitHub..."
echo "    (You may be prompted for your GitHub username and a Personal Access Token)"
echo "    Create a token at: https://github.com/settings/tokens (select 'repo' scope)"
echo ""
git push -u origin "$BRANCH"

echo ""
echo "────────────────────────────────────────────────────"
echo "✅  Deployment complete!"
echo ""
echo "Next steps to enable GitHub Pages:"
echo "  1. Go to https://github.com/butlerdarin/thesaaspartnership/settings/pages"
echo "  2. Under 'Source' — select 'Deploy from a branch'"
echo "  3. Select branch: main  |  folder: / (root)"
echo "  4. Click Save"
echo ""
echo "  Your site will be live at:"
echo "  👉  https://butlerdarin.github.io/thesaaspartnership"
echo ""
echo "  To use your custom domain (thesaaspartnership.com):"
echo "  - Add a CNAME DNS record pointing to: butlerdarin.github.io"
echo "  - The CNAME file is already in the repo ✅"
echo "────────────────────────────────────────────────────"
