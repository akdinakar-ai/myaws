# Branch protection guidance

Recommended branch protection rules for `main`:

- Require pull requests for all changes (no direct pushes)
- Require at least one approving review before merge
- Require passing status checks (CI) before merge
- Optionally enforce signed commits and restrict who can push

Enable via GitHub UI:

1. Go to the repository on GitHub → Settings → Branches → Add rule.
2. Enter `main` as the branch name pattern.
3. Check `Require pull request reviews before merging` and set approvals.
4. Check `Require status checks to pass before merging` and select the CI job (e.g. `Format & Validate`).
5. Save changes.

Enable via `gh` CLI (example):

```bash
# Install GitHub CLI and authenticate: gh auth login
gh api --method PUT repos/OWNER/REPO/branches/main/protection -f required_status_checks='{"strict":true,"contexts":["Format & Validate"]}' -f enforce_admins=true -f required_pull_request_reviews='{"required_approving_review_count":1}'
```

Or use the REST API (replace `OWNER`, `REPO`, and set `GITHUB_TOKEN`):

```bash
curl -X PUT -H "Authorization: token $GITHUB_TOKEN" -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/OWNER/REPO/branches/main/protection \
  -d '{"required_status_checks":{"strict":true,"contexts":["Format & Validate"]},"enforce_admins":true,"required_pull_request_reviews":{"required_approving_review_count":1},"restrictions":null}'
```

Notes:
- Replace `OWNER/REPO` and CI context names with your values.
- Using `gh` or the API requires repository admin permissions.
