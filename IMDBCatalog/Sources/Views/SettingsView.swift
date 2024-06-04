import SwiftUI
import ComposableArchitecture

struct SettingsView: View {
    let store: Store<SettingsState, SettingsAction>
    
    var body: some View {
        Text("Settings")
    }
}
