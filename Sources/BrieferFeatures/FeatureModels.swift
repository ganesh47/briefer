import Foundation
import LearningCore

public struct ReviewCardState: Identifiable, Equatable, Sendable {
    public var id: String
    public var title: String
    public var subtitle: String
    public var dueLabel: String
    public var schedule: ReviewSchedule

    public init(
        id: String,
        title: String,
        subtitle: String,
        dueLabel: String,
        schedule: ReviewSchedule
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.dueLabel = dueLabel
        self.schedule = schedule
    }
}

public struct HomeViewState: Equatable, Sendable {
    public var streakDays: Int
    public var dueItems: [ReviewCardState]
    public var weakAreaTitles: [String]

    public init(
        streakDays: Int,
        dueItems: [ReviewCardState],
        weakAreaTitles: [String]
    ) {
        self.streakDays = streakDays
        self.dueItems = dueItems
        self.weakAreaTitles = weakAreaTitles
    }
}

public struct GlossaryChipState: Identifiable, Equatable, Sendable {
    public var id: String
    public var term: String
    public var definition: String

    public init(id: String, term: String, definition: String) {
        self.id = id
        self.term = term
        self.definition = definition
    }
}

public struct BriefViewState: Equatable, Sendable {
    public var title: String
    public var summary: String
    public var example: String
    public var glossaryTerms: [GlossaryChipState]

    public init(
        title: String,
        summary: String,
        example: String,
        glossaryTerms: [GlossaryChipState]
    ) {
        self.title = title
        self.summary = summary
        self.example = example
        self.glossaryTerms = glossaryTerms
    }
}

public struct QuizChoiceState: Identifiable, Equatable, Sendable {
    public var id: String
    public var text: String
    public var isCorrect: Bool

    public init(id: String, text: String, isCorrect: Bool) {
        self.id = id
        self.text = text
        self.isCorrect = isCorrect
    }
}

public struct QuizViewState: Equatable, Sendable {
    public var prompt: String
    public var choices: [QuizChoiceState]
    public var explanation: String

    public init(
        prompt: String,
        choices: [QuizChoiceState],
        explanation: String
    ) {
        self.prompt = prompt
        self.choices = choices
        self.explanation = explanation
    }
}

public struct ProgressViewState: Equatable, Sendable {
    public var learnedConceptCount: Int
    public var dueReviewCount: Int
    public var retentionPercent: Int
    public var streakDays: Int
    public var weakAreaTitles: [String]

    public init(
        learnedConceptCount: Int,
        dueReviewCount: Int,
        retentionPercent: Int,
        streakDays: Int,
        weakAreaTitles: [String]
    ) {
        self.learnedConceptCount = learnedConceptCount
        self.dueReviewCount = dueReviewCount
        self.retentionPercent = retentionPercent
        self.streakDays = streakDays
        self.weakAreaTitles = weakAreaTitles
    }
}
