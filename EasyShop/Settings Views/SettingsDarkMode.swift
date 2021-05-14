import SwiftUI

struct SettingsDarkMode: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @ObservedObject var theme = gThemeSettings
    
    var body: some View {
        Section(header: Text(NSLocalizedString("aspect", comment: ""))) {
            Toggle(isOn: $isDarkMode, label: {
                Image(systemName: "moon.circle")
                    .foregroundColor(theme.mainColor)
                Text(NSLocalizedString("dark_mode", comment: ""))
                    .reusableLabel(font: .headline, size: 20, design: .serif, color: .primary)
                // .modifier(capsuleFont())
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
//
