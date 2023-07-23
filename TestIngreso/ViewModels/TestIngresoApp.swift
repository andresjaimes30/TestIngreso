import SwiftUI

@main
struct TestIngresoApp: App {
    // @State variable to control if the loading screen should be shown
    @State private var showLoadingScreen = true

    var body: some Scene {
        WindowGroup {
            if showLoadingScreen {
                LoadingView()
                    .onAppear {
                        // Add a delay here to simulate a loading time (optional)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showLoadingScreen = false
                        }
                    }
            } else {
                // Your main ContentView or HomeView (the actual content of the app)
                ContentView()
            }
        }
    }
}
