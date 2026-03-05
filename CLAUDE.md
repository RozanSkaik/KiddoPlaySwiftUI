# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

Open `KiddoPlay.xcodeproj` in Xcode and run with `Cmd+R`. Tests run with `Cmd+U`. There is no CLI build system — all building, testing, and signing is done through Xcode.

To run a single test: focus the test in Xcode and press `Ctrl+Option+Cmd+U`, or click the diamond icon next to the test method.

## Architecture

**MVVM** with a global `AppState` object for navigation.

### App Flow (`Utils/AppFlow.swift`)
`AppState` is an `ObservableObject` injected as an `@EnvironmentObject` from `KiddoPlayApp`. It drives top-level navigation via `AppFlowState`:
- `.welcome` → `WelcomeView` (unauthenticated)
- `.guest` → `MainTabView` (no account)
- `.loggedIn` → `MainTabView` (Firebase authenticated)

State is persisted in `UserDefaults` (`isLoggedIn`, `isGuest`). To transition states, call `appState.login()`, `appState.continueAsGuest()`, or `appState.logout()`.

### ViewModels
- Use `@Observable` macro (not `ObservableObject`) with `@MainActor`
- Follow the pattern: validate with `Validator` → assign field errors → guard → call `AuthenticationManager` → set `didLogin`/`didSignUp` bool → View observes that bool to trigger `appState` transition

### Validation (`Utils/Validator.swift`)
Namespace enum `Validator` with nested `Auth`, `SignUp`, and `Login` sub-enums. Returns typed result structs (`SignUpValidationResult`, `LoginValidationResult`) with optional per-field error strings and an `isValid` computed property.

### Services (`Services/AuthenticationManager.swift`)
Singleton (`AuthenticationManager.shared`) wrapping Firebase Auth. All methods are `async throws` returning `UserInfo`.

### Views
- `Views/AuthViews/` — `WelcomeView`, `AuthView` (hosts Login/SignUp with a `CustomSegmentView` toggle)
- `Views/TabBar/MainTabView.swift` — custom tab bar; the "Trophie" tab opens as a `CustomDialog` overlay instead of navigating
- `Views/CustomViews/` — reusable components: `CustomTextField`, `PrimaryButton`, `CustomSegmentView`, `CustomDialog`, `StrokeText`

### Models
- `UserInfo` — thin wrapper around Firebase `User` (uid, email, displayName)
- `HomeCategory` — model for home screen learning categories

## Key Conventions
- ViewModels use `@Observable` (Swift 5.9 macro), not `ObservableObject`/`@Published`
- `AppState` is the only `ObservableObject`; pass it via `.environmentObject(appState)`
- Firebase is initialized via `AppDelegate` (UIKit delegate adaptor)
- Custom tab icons use asset catalog image names (`home`, `selectedHome`, etc.)
- The Trophie tab does not navigate — it intercepts tab selection and shows a `CustomDialog` popup, restoring the previous tab on dismiss
