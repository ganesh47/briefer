# Briefer Seed-Content Import Boundary

Status: proposed for the first prototype

## Boundary

The public repository may contain product behavior, architecture, model definitions, scheduler logic, UI code, validation tools, and generic fixtures. It must not contain private source material, domain-specific extracted notes, proprietary training text, or sample data copied from private learning content.

Approved public seed content can be added later only when it is explicitly cleared as public. Until then, all committed fixtures should use generic learning examples.

## Allowed In GitHub

- Generic lesson, concept, glossary, and question fixtures.
- JSON schemas or Swift validation code.
- Import adapters that operate on generic payloads.
- Tests that use synthetic records.
- Documentation about process and constraints.

## Not Allowed In GitHub

- Private source documents or excerpts.
- Domain-specific extracted learning material.
- Screenshots or fixtures that reveal private course content.
- Issue, PR, commit, or review text containing private curriculum details.
- Test snapshots copied from private content packs.

## Handoff Path

1. Private source material is processed outside the public repo.
2. A cleared payload is transformed into the public fixture format only if it is generic or approved for public release.
3. The public repo validates structure, identifiers, references, and quality rules.
4. App builds load only bundled generic fixtures unless a separate private distribution path is configured.

## Fixture Format

Use a small versioned payload:

- `schemaVersion`
- `source`
- `lessons`
- `concepts`
- `glossaryTerms`
- `questions`

Each record should include:

- stable `id`
- human-readable `title` or `term`
- relationship identifiers
- updated timestamp or payload version when needed

Question records should include:

- prompt
- kind
- options when applicable
- answer key
- explanation
- related concept identifiers
- difficulty

## Validation Checks

Import validation should reject payloads when:

- identifiers are missing or duplicated
- relationships point at unknown records
- question answer keys do not match available options
- explanations are empty
- due-review defaults are missing for reviewable items
- records include disallowed metadata or source excerpts

Quality checks should warn when:

- a lesson has no questions
- a concept has no related question
- multiple questions share the same prompt
- glossary terms are not referenced by any concept

## Public Sample Policy

Use synthetic topics for fixtures, such as generic study skills or abstract product examples. Do not use a real private domain as placeholder content. A future private content pack can use the same schema without committing its payload to GitHub.
