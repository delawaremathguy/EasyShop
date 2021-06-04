import SwiftUI

struct SettingsViews: View {
    
    @ObservedObject var theme = gThemeSettings
    
    @State private var action: Int? = 0
        
    var body: some View {
        NavigationView {
            Form {
                LogoView()
                SettingsTheme()
                SettingsDarkMode()
                
            }.navigationBarTitle(NSLocalizedString("tab_settings", comment: ""), displayMode: .inline)
        }
    }
}

// MARK: - LOGO VIEW

struct LogoView: View {
    
    @ObservedObject var theme = gThemeSettings
    
    var body: some View {
        Section(header: Text(NSLocalizedString("logo", comment: "Information about the app"))) {
            Image("shopincart").foregroundColor(theme.mainColor) // shopincart
                .reusableSection(miW: 0, maW: .infinity, miH: 0, maH: .infinity, ali: .center)
            Text(NSLocalizedString("version", comment: "Version of the app"))
                .reusableSection(miW: 0, maW: .infinity, miH: 0, maH: .infinity, ali: .center)
        }
    }
}
extension View {
    func reusableSection(miW: CGFloat, maW: CGFloat, miH: CGFloat, maH: CGFloat, ali: Alignment) -> some View {
        self
            .frame(minWidth: miW, maxWidth: maW, minHeight: miH, maxHeight: maH, alignment: ali)
    }
}

 // MARK: - PREVIEWS

struct SettingsViews_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViews()
    }
}
