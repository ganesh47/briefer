import Foundation

public enum ReviewItemKind: String, Codable, Equatable, Sendable {
    case concept
    case question
}

public enum ConfidenceRating: Int, Codable, CaseIterable, Equatable, Sendable {
    case forgot = 1
    case unsure = 2
    case solid = 3
    case easy = 4
}

public struct ReviewOutcome: Codable, Equatable, Sendable {
    public var isCorrect: Bool
    public var confidence: ConfidenceRating
    public var answeredAt: Date

    public init(
        isCorrect: Bool,
        confidence: ConfidenceRating,
        answeredAt: Date
    ) {
        self.isCorrect = isCorrect
        self.confidence = confidence
        self.answeredAt = answeredAt
    }
}

public struct ReviewSchedule: Codable, Equatable, Identifiable, Sendable {
    public var id: String
    public var itemKind: ReviewItemKind
    public var itemID: String
    public var dueAt: Date
    public var intervalDays: Int
    public var easeFactor: Double
    public var consecutiveCorrectCount: Int
    public var lapseCount: Int
    public var lastReviewedAt: Date?

    public init(
        id: String,
        itemKind: ReviewItemKind,
        itemID: String,
        dueAt: Date,
        intervalDays: Int = 0,
        easeFactor: Double = ReviewScheduler.defaultEaseFactor,
        consecutiveCorrectCount: Int = 0,
        lapseCount: Int = 0,
        lastReviewedAt: Date? = nil
    ) {
        self.id = id
        self.itemKind = itemKind
        self.itemID = itemID
        self.dueAt = dueAt
        self.intervalDays = intervalDays
        self.easeFactor = easeFactor
        self.consecutiveCorrectCount = consecutiveCorrectCount
        self.lapseCount = lapseCount
        self.lastReviewedAt = lastReviewedAt
    }

    public var isDueReferenceScore: Double {
        Double(lapseCount + 1) / max(easeFactor, 0.1)
    }
}

public struct ReviewScheduler: Sendable {
    public static let defaultEaseFactor = 2.5

    public init() {}

    public func schedule(
        _ current: ReviewSchedule,
        after outcome: ReviewOutcome
    ) -> ReviewSchedule {
        let nextEase = adjustedEase(
            currentEase: current.easeFactor,
            isCorrect: outcome.isCorrect,
            confidence: outcome.confidence
        )
        let nextInterval = nextIntervalDays(
            current: current,
            isCorrect: outcome.isCorrect,
            confidence: outcome.confidence,
            easeFactor: nextEase
        )

        var next = current
        next.easeFactor = nextEase
        next.intervalDays = nextInterval
        next.lastReviewedAt = outcome.answeredAt
        next.dueAt = dueDate(
            from: outcome.answeredAt,
            isCorrect: outcome.isCorrect,
            confidence: outcome.confidence,
            intervalDays: nextInterval
        )

        if outcome.isCorrect {
            next.consecutiveCorrectCount += 1
        } else {
            next.consecutiveCorrectCount = 0
            next.lapseCount += 1
        }

        return next
    }

    private func adjustedEase(
        currentEase: Double,
        isCorrect: Bool,
        confidence: ConfidenceRating
    ) -> Double {
        guard isCorrect else {
            return max(1.3, currentEase - 0.25)
        }

        let quality = qualityScore(for: confidence)
        let penalty = Double(5 - quality)
        let adjusted = currentEase + (0.1 - penalty * (0.08 + penalty * 0.02))
        return max(1.3, adjusted)
    }

    private func nextIntervalDays(
        current: ReviewSchedule,
        isCorrect: Bool,
        confidence: ConfidenceRating,
        easeFactor: Double
    ) -> Int {
        guard isCorrect else {
            return 1
        }

        switch current.consecutiveCorrectCount {
        case 0:
            return firstCorrectInterval(for: confidence)
        case 1:
            return max(firstCorrectInterval(for: confidence) + 1, 3)
        default:
            let multiplier = confidenceMultiplier(for: confidence)
            let proposed = Double(max(current.intervalDays, 1)) * easeFactor * multiplier
            return max(Int(proposed.rounded()), current.intervalDays + 1)
        }
    }

    private func dueDate(
        from answeredAt: Date,
        isCorrect: Bool,
        confidence: ConfidenceRating,
        intervalDays: Int
    ) -> Date {
        if !isCorrect, confidence == .forgot {
            return answeredAt.addingTimeInterval(12 * 60 * 60)
        }

        return answeredAt.addingTimeInterval(TimeInterval(intervalDays) * 24 * 60 * 60)
    }

    private func firstCorrectInterval(for confidence: ConfidenceRating) -> Int {
        switch confidence {
        case .forgot, .unsure:
            return 1
        case .solid:
            return 2
        case .easy:
            return 3
        }
    }

    private func confidenceMultiplier(for confidence: ConfidenceRating) -> Double {
        switch confidence {
        case .forgot:
            return 0.75
        case .unsure:
            return 0.9
        case .solid:
            return 1.0
        case .easy:
            return 1.2
        }
    }

    private func qualityScore(for confidence: ConfidenceRating) -> Int {
        switch confidence {
        case .forgot:
            return 3
        case .unsure:
            return 3
        case .solid:
            return 4
        case .easy:
            return 5
        }
    }
}

public struct ReviewQueueBuilder: Sendable {
    public init() {}

    public func dueItems(
        from schedules: [ReviewSchedule],
        now: Date,
        limit: Int? = nil
    ) -> [ReviewSchedule] {
        let sorted = schedules
            .filter { $0.dueAt <= now }
            .sorted { lhs, rhs in
                if lhs.isDueReferenceScore != rhs.isDueReferenceScore {
                    return lhs.isDueReferenceScore > rhs.isDueReferenceScore
                }

                if lhs.dueAt != rhs.dueAt {
                    return lhs.dueAt < rhs.dueAt
                }

                return lhs.itemID < rhs.itemID
            }

        guard let limit else {
            return sorted
        }

        return Array(sorted.prefix(limit))
    }
}
