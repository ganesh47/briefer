import SwiftUI

public struct HomeView: View {
    private let state: HomeViewState
    private let onStartReview: (ReviewCardState) -> Void

    public init(
        state: HomeViewState,
        onStartReview: @escaping (ReviewCardState) -> Void = { _ in }
    ) {
        self.state = state
        self.onStartReview = onStartReview
    }

    public var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today")
                        .font(.largeTitle.bold())
                    Text("\(state.streakDays) day streak")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }

            Section("Review Queue") {
                if state.dueItems.isEmpty {
                    ContentUnavailableView(
                        "Nothing Due",
                        systemImage: "checkmark.circle",
                        description: Text("New reviews appear here when they are ready.")
                    )
                } else {
                    ForEach(state.dueItems) { item in
                        Button {
                            onStartReview(item)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.subtitle)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(item.dueLabel)
                                    .font(.caption)
                                    .foregroundStyle(.blue)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }

            Section("Weak Areas") {
                if state.weakAreaTitles.isEmpty {
                    Text("No weak areas yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(state.weakAreaTitles, id: \.self) { title in
                        Label(title, systemImage: "target")
                    }
                }
            }
        }
        .navigationTitle("Briefer")
    }
}
