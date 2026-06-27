# Security Policy

## Supported Scope

This repository is a public implementation repo for `Briefer`, an iOS spaced-repetition learning app. The public repo tracks app mechanics, architecture, generic fixtures, and automation only.

Supported security reporting scope:

- GitHub Actions workflows in `.github/workflows/`
- Repository automation and scripts
- Dependency and supply-chain issues
- Secrets accidentally committed to the repository
- Swift application code and local learner-state handling
- Public fixture validation and content-boundary enforcement

Out of scope for urgent security handling:

- Private curriculum/source-material quality issues outside this repo
- Personal device setup issues unrelated to the repository
- App Store policy topics before a distribution pipeline exists

## Reporting a Vulnerability

Please use GitHub's private vulnerability reporting flow for this repository when possible.

If private vulnerability reporting is unavailable, open a GitHub issue only for non-sensitive concerns. Do not post exploit details, secrets, tokens, private source material, or learner data in a public issue.

## Response Expectations

- Initial triage target: within 7 days
- Remediation target for confirmed high-severity issues: as quickly as practical for a solo-maintained early-stage project
- Public disclosure: after a fix is available or the issue is otherwise mitigated

## Data Handling Notes

Briefer's public repo must not contain private learning source material, extracted curriculum text, proprietary notes, or learner-private data.

- Public fixtures should remain generic unless explicitly cleared for public release
- Local learner state should stay device-local unless a future sync design explicitly changes that
- Reports involving private material should share only the minimum metadata needed to reproduce the issue
