import ComposableArchitecture

//let appReducer: any Reducer<AppState, AppAction> = Reducer.combine(
//    homeReducer.pullback(
//        state: \.homeState,
//        action: /AppAction.home
//    ),
//    settingsReducer.pullback(
//        state: \.settingsState,
//        action: /AppAction.settings
//    ),
//    Reducer { state, action, environment in
//        switch action {
//        case let .selectTab(tab):
//            state.selectedTab = tab
//            return .none
//        case .home, .settings:
//            return .none
//        }
//    }
//)
