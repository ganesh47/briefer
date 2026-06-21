import BrieferFeatures
import SwiftUI

@main
struct BrieferApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(state: PreviewContent.home)
            }
        }
    }
}
