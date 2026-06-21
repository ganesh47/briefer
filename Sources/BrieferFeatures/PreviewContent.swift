import Foundation
import LearningCore

public enum PreviewContent {
    public static let now = Date(timeIntervalSince1970: 1_800_000_000)

    public static let home = HomeViewState(
        streakDays: 4,
        dueItems: [
            ReviewCardState(
                id: "review-1",
                title: "Active Recall",
                subtitle: "Concept review",
                dueLabel: "Due now",
                schedule: ReviewSchedule(
                    id: "schedule-1",
                    itemKind: .concept,
                    itemID: "concept-active-recall",
                    dueAt: now
                )
            ),
            ReviewCardState(
                id: "review-2",
                title: "Confidence Rating",
                subtitle: "Question review",
                dueLabel: "Due today",
                schedule: ReviewSchedule(
                    id: "schedule-2",
                    itemKind: .question,
                    itemID: "question-confidence",
                    dueAt: now
                )
            )
        ],
        weakAreaTitles: ["Recall timing", "Explanation quality"]
    )

    public static let emptyHome = HomeViewState(
        streakDays: 4,
        dueItems: [],
        weakAreaTitles: []
    )

    public static let brief = BriefViewState(
        title: "Active Recall",
        summary: "Try to retrieve an idea before rereading it. Retrieval makes the memory easier to find later.",
        example: "After reading a short note, close it and write the main point in one sentence.",
        glossaryTerms: [
            GlossaryChipState(
                id: "term-retrieval",
                term: "Retrieval",
                definition: "The act of bringing a remembered idea back to mind."
            ),
            GlossaryChipState(
                id: "term-cue",
                term: "Cue",
                definition: "A prompt that helps start recall."
            )
        ]
    )

    public static let quiz = QuizViewState(
        prompt: "What should happen before rereading a short brief?",
        choices: [
            QuizChoiceState(id: "choice-1", text: "Try to recall the main point", isCorrect: true),
            QuizChoiceState(id: "choice-2", text: "Skip the review until tomorrow", isCorrect: false),
            QuizChoiceState(id: "choice-3", text: "Only count the time spent reading", isCorrect: false)
        ],
        explanation: "A recall attempt strengthens retrieval even when the answer is imperfect."
    )

    public static let progress = ProgressViewState(
        learnedConceptCount: 12,
        dueReviewCount: 3,
        retentionPercent: 86,
        streakDays: 4,
        weakAreaTitles: ["Recall timing", "Explanation quality"]
    )
}
