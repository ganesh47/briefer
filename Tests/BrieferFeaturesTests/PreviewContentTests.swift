import Testing
@testable import BrieferFeatures

@Suite("Preview content")
struct PreviewContentTests {
    @Test("home screen includes due review state")
    func homeScreenIncludesDueReviewState() {
        #expect(PreviewContent.home.dueItems.count == 2)
        #expect(PreviewContent.emptyHome.dueItems.isEmpty)
    }

    @Test("quiz has exactly one correct answer and an explanation")
    func quizHasOneCorrectAnswer() {
        let correctAnswers = PreviewContent.quiz.choices.filter(\.isCorrect)

        #expect(correctAnswers.count == 1)
        #expect(!PreviewContent.quiz.explanation.isEmpty)
    }

    @Test("progress exposes weak areas")
    func progressExposesWeakAreas() {
        #expect(PreviewContent.progress.learnedConceptCount > 0)
        #expect(!PreviewContent.progress.weakAreaTitles.isEmpty)
    }
}
