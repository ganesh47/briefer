import Foundation
import Testing
@testable import LearningCore

@Suite("Review scheduler")
struct ReviewSchedulerTests {
    private let scheduler = ReviewScheduler()
    private let now = Date(timeIntervalSince1970: 1_800_000_000)

    @Test("correct answers increase interval and consecutive count")
    func correctAnswerIncreasesInterval() {
        let current = ReviewSchedule(
            id: "schedule-concept-1",
            itemKind: .concept,
            itemID: "concept-1",
            dueAt: now
        )

        let next = scheduler.schedule(
            current,
            after: ReviewOutcome(
                isCorrect: true,
                confidence: .solid,
                answeredAt: now
            )
        )

        #expect(next.intervalDays == 2)
        #expect(next.consecutiveCorrectCount == 1)
        #expect(next.lapseCount == 0)
        #expect(next.dueAt == now.addingTimeInterval(2 * 24 * 60 * 60))
    }

    @Test("easy repeated answers grow faster")
    func easyRepeatedAnswersGrowFaster() {
        let current = ReviewSchedule(
            id: "schedule-question-1",
            itemKind: .question,
            itemID: "question-1",
            dueAt: now,
            intervalDays: 4,
            easeFactor: 2.5,
            consecutiveCorrectCount: 2
        )

        let next = scheduler.schedule(
            current,
            after: ReviewOutcome(
                isCorrect: true,
                confidence: .easy,
                answeredAt: now
            )
        )

        #expect(next.intervalDays == 12)
        #expect(next.easeFactor > current.easeFactor)
        #expect(next.consecutiveCorrectCount == 3)
    }

    @Test("incorrect forgotten answers reset streak and schedule soon")
    func incorrectForgottenAnswerSchedulesSoon() {
        let current = ReviewSchedule(
            id: "schedule-concept-2",
            itemKind: .concept,
            itemID: "concept-2",
            dueAt: now,
            intervalDays: 8,
            easeFactor: 2.2,
            consecutiveCorrectCount: 3
        )

        let next = scheduler.schedule(
            current,
            after: ReviewOutcome(
                isCorrect: false,
                confidence: .forgot,
                answeredAt: now
            )
        )

        #expect(next.intervalDays == 1)
        #expect(next.consecutiveCorrectCount == 0)
        #expect(next.lapseCount == 1)
        #expect(abs(next.easeFactor - 1.95) < 0.0001)
        #expect(next.dueAt == now.addingTimeInterval(12 * 60 * 60))
    }

    @Test("due queue prefers weaker and older due items")
    func dueQueuePrioritizesWeakAndOldItems() {
        let queue = ReviewQueueBuilder()
        let oldStrong = ReviewSchedule(
            id: "old-strong",
            itemKind: .concept,
            itemID: "b",
            dueAt: now.addingTimeInterval(-3 * 24 * 60 * 60),
            easeFactor: 2.8,
            lapseCount: 0
        )
        let weak = ReviewSchedule(
            id: "weak",
            itemKind: .concept,
            itemID: "a",
            dueAt: now.addingTimeInterval(-60),
            easeFactor: 1.4,
            lapseCount: 2
        )
        let future = ReviewSchedule(
            id: "future",
            itemKind: .question,
            itemID: "c",
            dueAt: now.addingTimeInterval(60),
            easeFactor: 1.3,
            lapseCount: 4
        )

        let due = queue.dueItems(from: [oldStrong, weak, future], now: now)

        #expect(due.map(\.id) == ["weak", "old-strong"])
    }

    @Test("due queue limit is applied after prioritization")
    func dueQueueLimit() {
        let queue = ReviewQueueBuilder()
        let schedules = [
            ReviewSchedule(id: "1", itemKind: .concept, itemID: "1", dueAt: now, easeFactor: 1.4, lapseCount: 2),
            ReviewSchedule(id: "2", itemKind: .concept, itemID: "2", dueAt: now, easeFactor: 1.8, lapseCount: 1),
            ReviewSchedule(id: "3", itemKind: .concept, itemID: "3", dueAt: now, easeFactor: 2.5, lapseCount: 0)
        ]

        let due = queue.dueItems(from: schedules, now: now, limit: 2)

        #expect(due.map(\.id) == ["1", "2"])
    }
}
