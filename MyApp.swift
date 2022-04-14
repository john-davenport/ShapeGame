import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenu()
                .environmentObject(GameData())
        }
    }
}
