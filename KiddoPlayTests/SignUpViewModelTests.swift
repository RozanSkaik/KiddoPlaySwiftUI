//
//  SignUpViewModelTests.swift
//  KiddoPlayTests
//

import Testing
@testable import KiddoPlay

// MARK: - Mocks

private final class MockAuthService: AuthService {
    var shouldFail = false
    var createCalled = false

    func createUserAccount(withEmail email: String, password: String, name: String) async throws -> UserInfo {
        createCalled = true
        if shouldFail { throw MockError.generic }
        return UserInfo(uid: "test-uid", email: email, displayName: name)
    }

    func loginWithEmail(email: String, password: String) async throws -> UserInfo {
        throw MockError.generic
    }
}

private enum MockError: Error { case generic }

// MARK: - Tests

@MainActor
struct SignUpViewModelTests {

    // MARK: Validation

    @Test func emptyNameSetsNameError() async {
        let vm = makeVM()
        vm.name = ""
        vm.email = "test@example.com"
        vm.password = "password123"
        vm.confirmPassword = "password123"

        await vm.signUp()

        #expect(vm.nameError != nil)
        #expect(vm.didSignUp == false)
    }

    @Test func invalidEmailSetsEmailError() async {
        let vm = makeVM()
        vm.name = "Alice"
        vm.email = "not-an-email"
        vm.password = "password123"
        vm.confirmPassword = "password123"

        await vm.signUp()

        #expect(vm.emailError != nil)
        #expect(vm.didSignUp == false)
    }

    @Test func shortPasswordSetsPasswordError() async {
        let vm = makeVM()
        vm.name = "Alice"
        vm.email = "test@example.com"
        vm.password = "abc"
        vm.confirmPassword = "abc"

        await vm.signUp()

        #expect(vm.passwordError != nil)
        #expect(vm.didSignUp == false)
    }

    @Test func mismatchedPasswordsSetsConfirmError() async {
        let vm = makeVM()
        vm.name = "Alice"
        vm.email = "test@example.com"
        vm.password = "password123"
        vm.confirmPassword = "different123"

        await vm.signUp()

        #expect(vm.confirmPasswordError != nil)
        #expect(vm.didSignUp == false)
    }

    @Test func validationErrorsPreventsServiceCall() async {
        let service = MockAuthService()
        let vm = makeVM(service: service)
        vm.name = ""
        vm.email = "bad"
        vm.password = "short"
        vm.confirmPassword = ""

        await vm.signUp()

        #expect(service.createCalled == false)
    }

    // MARK: isFormValid

    @Test func isFormValidRequiresAllFields() {
        let vm = makeVM()
        #expect(vm.isFormValid == false)

        vm.name = "Alice"
        #expect(vm.isFormValid == false)

        vm.email = "test@example.com"
        #expect(vm.isFormValid == false)

        vm.password = "password123"
        #expect(vm.isFormValid == false)

        vm.confirmPassword = "password123"
        #expect(vm.isFormValid == true)
    }

    // MARK: Success

    @Test func validInputSetsDidSignUp() async {
        let vm = makeVM()
        fill(vm, name: "Alice", email: "alice@example.com", password: "password123")

        await vm.signUp()

        #expect(vm.didSignUp == true)
        #expect(vm.generalError == nil)
    }

    @Test func successClearsAllErrors() async {
        let vm = makeVM()
        vm.nameError = "old error"
        vm.emailError = "old error"
        fill(vm, name: "Alice", email: "alice@example.com", password: "password123")

        await vm.signUp()

        #expect(vm.nameError == nil)
        #expect(vm.emailError == nil)
    }

    // MARK: Failure

    @Test func serviceErrorSetsGeneralError() async {
        let service = MockAuthService()
        service.shouldFail = true
        let vm = makeVM(service: service)
        fill(vm, name: "Alice", email: "alice@example.com", password: "password123")

        await vm.signUp()

        #expect(vm.didSignUp == false)
        #expect(vm.generalError != nil)
    }

    @Test func loadingIsFalseAfterFailure() async {
        let service = MockAuthService()
        service.shouldFail = true
        let vm = makeVM(service: service)
        fill(vm, name: "Alice", email: "alice@example.com", password: "password123")

        await vm.signUp()

        #expect(vm.isLoading == false)
    }

    // MARK: Helpers

    private func makeVM(service: MockAuthService = MockAuthService()) -> SignUpViewModel {
        SignUpViewModel(service: service)
    }

    private func fill(_ vm: SignUpViewModel, name: String, email: String, password: String) {
        vm.name = name
        vm.email = email
        vm.password = password
        vm.confirmPassword = password
    }
}
