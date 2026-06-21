import SwiftUI

public struct ProgressSummaryView: View {
    private let state: ProgressViewState

    public init(state: ProgressViewState) {
        self.state = state
    }

    public var body: some View {
        List {
            Section("Summary") {
                metricRow("Concepts Learned", value: "\(state.learnedConceptCount)", systemImage: "book.closed")
                metricRow("Due Reviews", value: "\(state.dueReviewCount)", systemImage: "calendar")
                metricRow("Retention", value: "\(state.retentionPercent)%", systemImage: "chart.line.uptrend.xyaxis")
                metricRow("Streak", value: "\(state.streakDays) days", systemImage: "flame")
            }

            Section("Focus Next") {
                if state.weakAreaTitles.isEmpty {
                    Text("Keep reviewing to reveal focus areas.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(state.weakAreaTitles, id: \.self) { title in
                        Label(title, systemImage: "scope")
                    }
                }
            }
        }
        .navigationTitle("Progress")
    }

    private func metricRow(_ title: String, value: String, systemImage: String) -> some View {
        HStack {
            Label(title, systemImage: systemImage)
            Spacer()
            Text(value)
                .font(.headline)
        }
    }
}
