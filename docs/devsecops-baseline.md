# Briefer DevSecOps Baseline

Status: accepted initial baseline

## Goal

Briefer should use the same lightweight GitHub-native security posture as Mather while staying appropriate for a small public SwiftUI app repo.

## Baseline Controls

Repository controls added:

- `SECURITY.md` for vulnerability intake and public/private content handling
- `.github/CODEOWNERS` for sensitive-path ownership
- `.github/dependabot.yml` for GitHub Actions dependency updates
- Dependency Review on pull requests
- Workflow Lint with `actionlint`
- CodeQL analysis for GitHub Actions workflows
- OSSF Scorecard SARIF publishing
- Tag-driven GitHub release creation
- Explicit workflow `permissions:` blocks
- Pinned third-party and GitHub-owned workflow actions where practical

Build and validation controls:

- `swift test` for package-level domain and feature tests
- iOS simulator app build for the `BrieferApp` Xcode scheme
- No committed private curriculum, source excerpts, or learner-private content in CI fixtures

## GitHub Settings To Keep Aligned With Mather

Enable or keep enabled in repository settings:

- Branch protection or rulesets for `main`
- Required PR review
- Required Code Owner review for sensitive paths
- Required CI checks after the first workflow run establishes check names
- Vulnerability alerts
- Dependabot security updates
- Private vulnerability reporting
- Secret scanning
- Secret scanning push protection
- Code scanning alerts
- Dependency Review on pull requests

## Deferred Controls

Add these once the app grows beyond the current scaffold:

- UI screenshot review workflow after UI tests exist
- OSV or Swift package advisory scanning when external Swift dependencies are introduced
- Artifact attestations once release artifacts are produced
- TestFlight feedback ingestion after App Store Connect credentials and distribution are configured
- A private-content-pack validation workflow outside this public repo
