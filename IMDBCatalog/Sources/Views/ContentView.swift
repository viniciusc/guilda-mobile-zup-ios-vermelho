import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        Text("??")
//        WithViewStore(self.store) { viewStore in
//            TabView(selection: viewStore.binding(
//                get: \.selectedTab,
//                send: AppAction.selectTab
//            )) {
//                HomeView(store: self.store.scope(
//                    state: \.homeState,
//                    action: AppAction.home
//                ))
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//                .tag(AppState.Tab.home)
//                
//                SettingsView(store: self.store.scope(
//                    state: \.settingsState,
//                    action: AppAction.settings
//                ))
//                .tabItem {
//                    Label("Settings", systemImage: "gear")
//                }
//                .tag(AppState.Tab.settings)
//            }
//        }
    }
}
