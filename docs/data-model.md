# Briefer Core Learning Data Model

Status: proposed for the first prototype

## Goals

- Represent concise lessons, concepts, glossary terms, questions, answer attempts, review schedules, and learner progress.
- Keep the first model small enough for local persistence.
- Make scheduling and progress logic testable without SwiftUI.
- Support generic seed fixtures only in this public repository.

## Entity Overview

`LearningSource`

- Stable identifier.
- Display title.
- Source kind, such as `genericFixture` or `approvedPublicPack`.
- Import version.
- Created and updated timestamps.

`Lesson`

- Stable identifier.
- Source identifier.
- Title.
- Short summary.
- Ordered concept identifiers.
- Ordered question identifiers.
- Estimated study minutes.

`Concept`

- Stable identifier.
- Lesson identifier.
- Title.
- Brief explanation.
- Optional generic example.
- Related glossary term identifiers.
- Mastery state.

`GlossaryTerm`

- Stable identifier.
- Term.
- Plain-language definition.
- Optional technical definition.
- Related concept identifiers.

`Question`

- Stable identifier.
- Lesson identifier.
- Prompt.
- Question kind, such as multiple choice, true/false, or short recall.
- Answer options when applicable.
- Correct answer key.
- Explanation.
- Related concept identifiers.
- Difficulty.

`AnswerAttempt`

- Stable identifier.
- Question identifier.
- Concept identifiers.
- Submitted answer.
- Correctness.
- Learner confidence.
- Submitted timestamp.
- Elapsed seconds.

`ReviewSchedule`

- Stable identifier.
- Review item kind, such as concept or question.
- Review item identifier.
- Due timestamp.
- Current interval days.
- Ease factor or confidence score.
- Consecutive correct count.
- Last attempted timestamp.

`LearnerProgress`

- Stable identifier.
- Learned concept count.
- Due review count.
- Current streak days.
- Retention estimate.
- Weak concept identifiers.
- Last session timestamp.

## Relationships

- A source owns many lessons.
- A lesson owns ordered concepts and questions.
- Concepts can reference glossary terms.
- Questions can test one or more concepts.
- Answer attempts append immutable learner history.
- Review schedules point at reviewable concepts or questions.
- Learner progress is derived from attempts and schedules where possible.

## Persistence Rules

- Public fixtures must use generic sample content.
- Stable identifiers should be deterministic for fixture records.
- Attempt history should be append-only.
- Derived progress can be rebuilt from attempts and schedules.
- Scheduler inputs should be plain values so unit tests can run without a database.

## First Implementation Shape

Start with plain Swift structs and enums in a domain module. Add persistence annotations or adapters only after the core contracts settle.

Recommended enums:

- `SourceKind`
- `QuestionKind`
- `ReviewItemKind`
- `MasteryState`
- `Difficulty`
- `ConfidenceRating`

Recommended first tests:

- Fixture identifiers are stable.
- Questions always point at known lessons and concepts.
- Answer attempts preserve correctness and confidence.
- Review schedules can be recalculated from a generic attempt history.
