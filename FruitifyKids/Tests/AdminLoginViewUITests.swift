import XCTest

final class AdminLoginViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testLoginWithValidCredentials() {
        // Navigate to AdminLoginView if necessary
        app.buttons["I am Admin"].tap()

        // Enter valid credentials
        let usernameField = app.textFields["Username"]
        XCTAssertTrue(usernameField.exists)
        usernameField.tap()
        usernameField.typeText("admin@admin.com")

        let passwordField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("admin123")

        // Tap Login
        app.buttons["Login"].tap()

        // Check navigation
        let adminView = app.staticTexts["Welcome to Admin Panel"] // Example text in AdminView
        XCTAssertTrue(adminView.waitForExistence(timeout: 5))
    }

    func testLoginWithInvalidCredentials() {
        // Navigate to AdminLoginView if necessary
        app.buttons["I am Admin"].tap()

        // Enter invalid credentials
        let usernameField = app.textFields["Username"]
        XCTAssertTrue(usernameField.exists)
        usernameField.tap()
        usernameField.typeText("invalid@user.com")

        let passwordField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("wrongpassword")

        // Tap Login
        app.buttons["Login"].tap()

        // Verify alert
        let alert = app.alerts["Invalid Credentials"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        alert.buttons["OK"].tap()
    }
}
