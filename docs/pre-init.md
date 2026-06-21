# Briefer Pre-Init Brief

## Goal

Build an iOS app experience for durable learning: brief lessons, quizzes, spaced repetition, progress tracking, and adaptive review.

## Source Boundaries

- GitHub tracks product behavior, architecture, and implementation tasks.
- Private source material, domain-specific knowledge base content, and extracted lesson text do not belong in public issues, pull requests, commits, docs, or review comments.
- App fixtures in this repo should use generic sample content unless an approved public sample set is added later.

## Initial App Experience

1. Home shows today's review queue, learning streak, and weak areas.
2. Briefs present one compact concept with examples and glossary terms.
3. Quiz sessions test recall with explanation after each answer.
4. Spaced repetition schedules the next review based on confidence and correctness.
5. Progress view tracks concepts learned, retention, and pending reviews.

## Early Technical Direction

- Platform: iOS first.
- Likely stack: SwiftUI, local persistence first, sync later.
- Data model: source, lesson, concept, glossary term, question, answer attempt, review schedule.
- First prototype: generic sample learning domain.
- Later expansion: additional brief-based learning domains through private or approved-public content packs.

## Architecture Decision

The first prototype will use an iOS-first SwiftUI architecture with a local-first store, pure domain models, generic seed fixtures, and scheduler logic that can be tested independently from UI. See `docs/architecture.md`.

## Open Decisions

- The first prototype is local-only; sync/API work is deferred.
- Seed content in this repo is bundled as generic fixtures only; private or domain-specific content packs stay outside GitHub.
- Whether the review scheduler should start with a simple Leitner/SM-2 variant or a custom confidence model.
