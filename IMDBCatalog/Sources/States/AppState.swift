import ComposableArchitecture

struct AppState: Equatable {
    var selectedTab: Tab = .home
    var homeState = HomeState()
    var settingsState = SettingsState()
    
    enum Tab {
        case home
        case settings
    }
}
