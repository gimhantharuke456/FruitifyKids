import XCTest


@testable import FruitifyKids

final class AdminLoginViewTests: XCTestCase {
    
    func testValidateLogin_withValidCredentials_shouldNavigateToAdmin() {
        // Arrang
        let view = AdminLoginView()
        var updatedView = view
        updatedView.username = "admin@admin.com"
        updatedView.password = "admin123"
        
        // Act
        updatedView.validateLogin()
        
        // Assert
        XCTAssertTrue(updatedView.navigateToAdmin, "Valid credentials should set navigateToAdmin to true.")
    }
    
    func testValidateLogin_withInvalidCredentials_shouldShowAlert() {
        // Arrange
        let view = AdminLoginView()
        var updatedView = view
        updatedView.username = "invalid@user.com"
        updatedView.password = "wrongpassword"
        
        // Act
        updatedView.validateLogin()
        
        // Assert
        XCTAssertTrue(updatedView.showAlert, "Invalid credentials should set showAlert to true.")
    }
}
