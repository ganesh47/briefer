# Briefer Architecture Decision

Status: accepted for the first prototype

## Decision

Briefer will start as an iOS-first SwiftUI app with local-first persistence and a small domain layer that is independent from the UI. The initial implementation should favor plain Swift models, deterministic scheduling logic, and generic bundled seed data.

The first scaffold should use:

- SwiftUI app target for the learner experience.
- SwiftData or a narrow persistence adapter for local learner state.
- A domain module for lessons, questions, review schedules, answer attempts, and progress calculations.
- A seed-content module that reads generic fixture payloads only.
- Unit tests for scheduling, import validation, and progress calculations before broad UI polish.

## Module Boundaries

`BrieferApp`

- Owns app launch, navigation, and feature composition.
- Depends on feature views and injected stores.

`LearningCore`

- Owns value types for lessons, concepts, glossary terms, questions, answer attempts, review schedules, and learner progress.
- Owns pure functions for scoring, due-review selection, weak-area summaries, and next-review scheduling.
- Does not import SwiftUI.

`LearningStore`

- Owns local persistence adapters.
- Maps stored records into `LearningCore` models.
- Keeps sync/API concerns out of the first prototype.

`SeedContent`

- Owns generic sample fixtures and validation.
- Rejects private source text, domain-specific extracted material, and fixture payloads without stable identifiers.

`BrieferFeatures`

- Owns SwiftUI screens for Home, Brief, Quiz, and Progress.
- Reads view state from small feature view models.

## Initial Flow

1. App launches into Home.
2. Home reads due items and weak-area summaries from local state.
3. A Brief shows one concept with generic examples and related terms.
4. A Quiz records correctness and confidence.
5. The scheduler writes the next review date.
6. Progress summarizes completed concepts, due reviews, streaks, and weak areas.

## Validation

The first scaffold PR should be checked with Xcode on the `studio` host. Local Linux validation is limited to repository hygiene until a Swift toolchain or generated Xcode project exists in this repo.

Minimum checks once scaffolded:

- Build the iOS app target.
- Run unit tests for `LearningCore`.
- Verify generic seed fixtures load without private or domain-specific content.

## Deferred Decisions

- Cloud sync and accounts are out of scope for the first prototype.
- Production content packs are out of scope for this public repo unless explicitly approved as public sample content.
- The scheduler algorithm can start as a minimal confidence-weighted variant and evolve after the core model lands.
