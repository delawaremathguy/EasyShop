import SwiftUI

struct SettingsIcon: View {
    @EnvironmentObject var iconSettings: IconNames
    
    var body: some View {
        Form {
            Section(header: Text("Choose the app icon")) {
                Picker(selection: $iconSettings.currentIndex, label:
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(Color.primary, lineWidth: 2)
                                Image(systemName: "paintbrush")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                    .foregroundColor(Color.primary)
                            }
                            .frame(width: 44, height: 44)
                            Text("App Icons".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                        }
                ) {
                    ForEach(0..<iconSettings.iconNames.count) { index in
                        HStack {
                            Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Icon_Blue") ?? UIImage())
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                                .cornerRadius(9)
                            Spacer().frame(width: 8)
                            
                            Text(self.iconSettings.iconNames[index] ?? "Blue")
                                .frame(alignment: .leading)
                        }.padding(3)
                    }
                }
                .onReceive([self.iconSettings.currentIndex].publisher.first()) {
                    (value) in
                    let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                    if index != value {
                        UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                print("Success! You have changed the app icon")
                            }
                        }
                    }
                }
            }.padding(.vertical, 3)
        }
    }
}

struct SettingsIcon_Previews: PreviewProvider {
    static var previews: some View {
        SettingsIcon().environmentObject(IconNames())
    }
}
