#!/bin/bash

# Loop through the days in May, June, July, and August of 2022
for month in {05..08}; do
  for day in {01..31}; do
    CURRENT_DATE="2022-${month}-${day}"

    # Check if the date is valid (e.g., skip August 32nd)
    if date -d "${CURRENT_DATE}" > /dev/null 2>&1; then
      # Generate a random number between 1 and 15 for the commit count
      COMMIT_COUNT=$(( ( RANDOM % 15 ) + 1 ))

      # Generate a dynamic commit message
      COMMIT_MESSAGE="Update LMS content for ${CURRENT_DATE}"

      # Add commits for the current day
      for ((j = 0; j < $COMMIT_COUNT; j++)); do
        git commit --allow-empty -m "$COMMIT_MESSAGE" --date="${CURRENT_DATE}T$(printf "%02d:%02d:%02d" $((RANDOM%24)) $((RANDOM%60)) $((RANDOM%60)))"
      done
    fi
  done
done

# Generate 15 days without commits
for ((i = 0; i < 15; i++)); do
  NO_COMMIT_DATE="2022-$(printf "%02d-%02d" $(( RANDOM % 4 + 5 )) $(( RANDOM % 31 + 1 )))"

  # Check if the date is valid (e.g., skip August 32nd)
  if date -d "${NO_COMMIT_DATE}" > /dev/null 2>&1; then
    echo "No commits for ${NO_COMMIT_DATE}"
  fi
done

# Force push the changes
git push origin main --force
