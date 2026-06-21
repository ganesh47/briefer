import SwiftUI

public struct BriefView: View {
    private let state: BriefViewState

    public init(state: BriefViewState) {
        self.state = state
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(state.title)
                        .font(.largeTitle.bold())
                    Text(state.summary)
                        .font(.body)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Example")
                        .font(.headline)
                    Text(state.example)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color.secondary.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 12) {
                    Text("Glossary")
                        .font(.headline)
                    ForEach(state.glossaryTerms) { term in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(term.term)
                                .font(.subheadline.bold())
                            Text(term.definition)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("Brief")
    }
}
