import SwiftUI

struct SettingsAppearance: View {
    var body: some View {
        VStack {
            SettingsIcon()
            SettingsTheme()
        }
    }
}

struct SettingsAppearance_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAppearance().environmentObject(IconNames())
    }
}
