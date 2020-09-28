import SwiftUI

public struct DarkModeViewModifier: ViewModifier {

    @Environment(\.colorScheme) var colorScheme

    public func body(content: Content) -> some View {
        let isDarkMode = (colorScheme == .dark)
        return content
                .environment(\.colorScheme, (isDarkMode ? .dark : .light))
                .preferredColorScheme(isDarkMode ? .dark : .light) //status bar tint
    }
}
