import SwiftUI

struct SplashView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // Splash Image
                Image("fuirty_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Fruity")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                // Title Text
                Text("Discover Fruits and Veggies in a Fun Way!")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                // Get Started Button
                NavigationLink(destination: IdentifierView()) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40)
            }
        }
     
    }
}


#Preview {
    SplashView()
}
