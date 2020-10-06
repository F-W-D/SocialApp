import SwiftUI
import Firebase

@main
struct SocialApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    Auth.auth().canHandle(url)
                })
                .modifier(DarkModeViewModifier())
        }
    }
}
