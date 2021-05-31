import SwiftUI

struct SettingsDarkMode: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @ObservedObject var theme = gThemeSettings
    
    var body: some View {
        Section(header: Text(NSLocalizedString("aspect", comment: "App aspect"))) {
            Toggle(isOn: $isDarkMode, label: {
                Image(systemName: "moon.circle")
                    .foregroundColor(theme.mainColor)
                Text(NSLocalizedString("dark_mode", comment: "light/dark mode"))
                    .reusableLabel(font: .headline, size: 20, design: .serif, color: .primary)
            })
        }
    }
}

struct SettingsDarkMode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsDarkMode()
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
