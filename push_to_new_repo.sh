#!/bin/bash

# Script to push CRM to a new repository
# Usage: ./push_to_new_repo.sh <YOUR_NEW_REPO_URL>

set -e  # Exit on error

# Check if repository URL is provided
if [ -z "$1" ]; then
    echo "Error: Repository URL is required"
    echo "Usage: ./push_to_new_repo.sh <YOUR_NEW_REPO_URL>"
    echo "Example: ./push_to_new_repo.sh https://github.com/yourusername/your-crm-repo.git"
    exit 1
fi

NEW_REPO_URL=$1
CURRENT_BRANCH=$(git branch --show-current)

echo "========================================="
echo "Pushing CRM to New Repository"
echo "========================================="
echo "Repository URL: $NEW_REPO_URL"
echo "Current Branch: $CURRENT_BRANCH"
echo ""

# Step 1: Check current status
echo "Step 1: Checking git status..."
git status --short
echo ""

# Step 2: Check current remotes
echo "Step 2: Current remotes:"
git remote -v
echo ""

# Step 3: Check if origin already exists
if git remote get-url origin &>/dev/null; then
    echo "Warning: 'origin' remote already exists"
    read -p "Do you want to remove it and add the new one? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git remote remove origin
        echo "Removed existing origin remote"
    else
        echo "Aborting. Please manually handle the origin remote."
        exit 1
    fi
fi

# Step 4: Add new repository as origin
echo "Step 3: Adding new repository as origin..."
git remote add origin "$NEW_REPO_URL"
echo "✓ Added origin remote: $NEW_REPO_URL"
echo ""

# Step 5: Verify remotes
echo "Step 4: Verifying remotes..."
git remote -v
echo ""

# Step 6: Push to new repository
echo "Step 5: Pushing branch '$CURRENT_BRANCH' to origin..."
git push -u origin "$CURRENT_BRANCH"
echo "✓ Successfully pushed $CURRENT_BRANCH to origin"
echo ""

# Step 7: Ask about pushing all branches
read -p "Do you want to push all branches? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Pushing all branches..."
    git push origin --all
    echo "✓ All branches pushed"
fi

# Step 8: Ask about pushing tags
read -p "Do you want to push all tags? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Pushing all tags..."
    git push origin --tags
    echo "✓ All tags pushed"
fi

echo ""
echo "========================================="
echo "✓ Successfully pushed to new repository!"
echo "========================================="
echo "Repository URL: $NEW_REPO_URL"
echo "Branch: $CURRENT_BRANCH"
echo ""
echo "Next steps:"
echo "1. Visit your repository in the browser to verify"
echo "2. Set up branch protection rules if needed"
echo "3. Configure CI/CD if needed"
echo ""
