import SwiftUI

struct SettingsIcon: View {
    @EnvironmentObject var iconSettings: IconNames
    
    var body: some View {
        Section(header: Text(NSLocalizedString("app_icon", comment: ""))) {
// MARK: - Picker
            Picker(selection: $iconSettings.currentIndex, label:
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .strokeBorder(Color.primary, lineWidth: 2)
                            Image(systemName: "paintbrush")
                                .reusableIcon(size: 28, weight: .regular, desing: .default, color: .primary)
                        }
                        .frame(width: 44, height: 44)
                        Text(NSLocalizedString("app_icons", comment: ""))
                            .reusableLabel(font: .headline, size: 20, design: .serif, color: .primary)
                         //   .modifier(capsuleFont())
                    }
            ) {
// MARK: - ForEach
                ForEach(0..<iconSettings.iconNames.count) { index in
                    HStack {
                        Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                            .reusableIconApp(rendering: .original, width: 60, height: 60, corner: 9)

                    }.padding(3)
                }
            }.onReceive([self.iconSettings.currentIndex].publisher.first()) {
                (value) in
                let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                if index != value {
                    UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print(Text(NSLocalizedString("app_success", comment: "")))
                        } 
                    }
                }
            }
        }.padding(.vertical, 3)
    }
}

struct SettingsIcon_Previews: PreviewProvider {
    static var previews: some View {
        SettingsIcon().environmentObject(IconNames())
    }
}
