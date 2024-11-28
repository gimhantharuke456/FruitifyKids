
import SwiftUI
struct AdminLoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var navigateToAdmin = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Admin Login")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .padding(.bottom, 30)
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                validateLogin()
            }) {
                Text("Login")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue)
                    )
            }
            
            NavigationLink(destination: AdminView(), isActive: $navigateToAdmin) {
                EmptyView()
            }
        }
        .padding()
        .alert("Invalid Credentials", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func validateLogin() {
        if username == "admin@admin.com" && password == "admin123" {
            navigateToAdmin = true
        } else {
            showAlert = true
        }
    }
}
