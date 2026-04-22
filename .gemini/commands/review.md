# /review

Act as a Senior Staff Engineer and QA Lead. Review the staged changes against the active task requirements.

## Workflow

1. Run \`git diff --staged\` to see the changes.
2. Read \`docs/ACTIVE_TASK.md\` to understand the requirements.
3. Verify that all requirements are met and no edge cases or security flaws are introduced.
4. If issues are found, provide a list of fixes and DO NOT proceed to commit.
5. If the code is perfect, confirm that the user can proceed to \`/commit\`.
