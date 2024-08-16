#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Function to increment version
increment_version() {
	local IFS='.'
	local -a v=($1)
	v[2]=$((v[2] + 1))
	echo "${v[*]}"
}

# Display all existing tags
echo "Existing tags:"
git tag

# Get the current version, defaulting to 0.1.0 if no tags exist
current_version=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.1.0")

# Remove 'v' prefix if it exists
current_version="${current_version#v}"

# Ask the user for the new version or default to incrementing the current version
read -p "Enter the new version (or press Enter to auto-increment from $current_version): " user_version

if [[ -z "$user_version" ]]; then
	new_version="v$(increment_version "$current_version")"
else
	new_version="v${user_version#v}" # Ensure 'v' prefix is added if not present
fi

# Check if the tag already exists
if git rev-parse "$new_version" >/dev/null 2>&1; then
	echo "Error: Tag $new_version already exists. Please choose a different version." >&2
	exit 1
fi

# Create and push the new tag
if git tag -a "$new_version" -m "Release $new_version" && git push origin "$new_version"; then
	echo "Created and pushed new tag: $new_version"
else
	echo "Failed to create or push tag: $new_version" >&2
	exit 1
fi
