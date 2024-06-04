import ComposableArchitecture

enum AppAction: Equatable {
    case selectTab(AppState.Tab)
    case home(HomeAction)
    case settings(SettingsAction)
}
