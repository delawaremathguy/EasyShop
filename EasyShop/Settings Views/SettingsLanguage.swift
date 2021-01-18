import SwiftUI

struct SettingsLanguage: View {
    var body: some View {
        Text(NSLocalizedString("language", comment: ""))
    }
}

struct SettingsLanguage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLanguage()
    }
}
