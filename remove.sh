#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Display all existing tags
echo "Existing tags:"
git tag

# Prompt the user to enter the tag to delete
read -p "Enter the tag you want to delete: " tag_to_delete

# Check if the tag exists
if git rev-parse "$tag_to_delete" >/dev/null 2>&1; then
	# Confirm deletion
	read -p "Are you sure you want to delete the tag '$tag_to_delete' locally and on GitHub? (y/n): " confirmation
	if [[ "$confirmation" =~ ^[Yy]$ ]]; then
		# Delete the tag locally
		git tag -d "$tag_to_delete"
		echo "Deleted tag '$tag_to_delete' locally."

		# Delete the tag on GitHub
		git push --delete origin "$tag_to_delete"
		echo "Deleted tag '$tag_to_delete' on GitHub."
	else
		echo "Tag deletion canceled."
		exit 0
	fi
else
	echo "Tag '$tag_to_delete' does not exist." >&2
	exit 1
fi