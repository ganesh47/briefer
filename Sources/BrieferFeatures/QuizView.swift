import SwiftUI

public struct QuizView: View {
    private let state: QuizViewState
    @State private var selectedChoiceID: String?

    public init(state: QuizViewState) {
        self.state = state
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(state.prompt)
                .font(.title2.bold())

            VStack(spacing: 12) {
                ForEach(state.choices) { choice in
                    Button {
                        selectedChoiceID = choice.id
                    } label: {
                        HStack {
                            Text(choice.text)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            if selectedChoiceID == choice.id {
                                Image(systemName: choice.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundStyle(choice.isCorrect ? .green : .red)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(choiceBackground(for: choice), in: RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                }
            }

            if let selectedChoice {
                AnswerFeedbackView(
                    isCorrect: selectedChoice.isCorrect,
                    explanation: state.explanation
                )
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Quiz")
    }

    private var selectedChoice: QuizChoiceState? {
        state.choices.first { $0.id == selectedChoiceID }
    }

    private func choiceBackground(for choice: QuizChoiceState) -> Color {
        guard selectedChoiceID == choice.id else {
            return Color.secondary.opacity(0.12)
        }

        return choice.isCorrect ? Color.green.opacity(0.18) : Color.red.opacity(0.18)
    }
}

public struct AnswerFeedbackView: View {
    private let isCorrect: Bool
    private let explanation: String

    public init(isCorrect: Bool, explanation: String) {
        self.isCorrect = isCorrect
        self.explanation = explanation
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(isCorrect ? "Correct" : "Review This", systemImage: isCorrect ? "checkmark.circle" : "exclamationmark.circle")
                .font(.headline)
                .foregroundStyle(isCorrect ? .green : .orange)
            Text(explanation)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondary.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
    }
}

public struct CompletionFeedbackView: View {
    private let reviewedCount: Int
    private let nextReviewLabel: String

    public init(reviewedCount: Int, nextReviewLabel: String) {
        self.reviewedCount = reviewedCount
        self.nextReviewLabel = nextReviewLabel
    }

    public var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "flag.checkered")
                .font(.system(size: 44))
                .foregroundStyle(.blue)
            Text("Session Complete")
                .font(.title.bold())
            Text("\(reviewedCount) items reviewed")
                .foregroundStyle(.secondary)
            Text(nextReviewLabel)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}
