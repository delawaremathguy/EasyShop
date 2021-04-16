import SwiftUI

struct SettingsDarkMode: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        Section(header: Text(NSLocalizedString("aspect", comment: ""))) {
            Toggle(isOn: $isDarkMode, label: {
                Image(systemName: "moon.circle")
                Text(NSLocalizedString("dark_mode", comment: ""))
                    .modifier(capsuleFont())
            })
        }
    }
}

struct SettingsDarkMode_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Dark Mode", isOn: .constant(false))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
