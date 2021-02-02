import SwiftUI

struct SettingsAppearance: View {
    var body: some View {
        Form {
            SettingsIcon()
            SettingsTheme()
            
        }.navigationTitle(NSLocalizedString("appearance", comment: ""))
    }
}

struct SettingsAppearance_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAppearance().environmentObject(IconNames())
    }
}
