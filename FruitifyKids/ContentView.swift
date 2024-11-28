
import SwiftUI

struct ContentView: View {
    @State private var showAdminLogin = false
    
    var body: some View {
        SplashView()
    }
}

// Custom bouncy button style
struct BouncyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == BouncyButtonStyle {
    static var bouncy: BouncyButtonStyle {
        BouncyButtonStyle()
    }
}

#Preview {
    ContentView()
}
