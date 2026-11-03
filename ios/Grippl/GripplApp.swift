import SwiftUI

@main
struct GripplApp: App {
    @State private var favoriten = FavoritenSpeicher()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(favoriten)
        }
    }
}
