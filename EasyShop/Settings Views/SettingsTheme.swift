import SwiftUI

struct SettingsTheme: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @State private var isThemeChanged: Bool = false
    
    var body: some View {
        Section(header: Text(NSLocalizedString("app_theme", comment: ""))) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 35) {
                    ForEach(themes, id: \.id) { item in
                        Button(action: {
                            gThemeSettings.themeSettings = item.id
                            UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                            self.isThemeChanged.toggle()
                            print("Changing to \(item.themeName)")
                            impactMedium.impactOccurred()
                        }) {
                            VStack {
                                
// MARK: - Card
                                VStack {
                                    Spacer()
                                    Divider()
                                        .frame(width: 50, height: 3)
                                        .background(item.mainColor)
                                    Image(systemName: "tray.and.arrow.down.fill")
                                        .foregroundColor(item.mainColor)
                                        .font(.system(size: 35, weight: .regular))
                                    Spacer().frame(height: 45)
                                    Divider().background(Color.gray)
                                    
// MARK: - Tabbar
                                    HStack(spacing: 20) {
                                        Rectangle().reusableShape(width: 10, heigth: 10, color: item.mainColor)
                                        Rectangle().reusableShape(width: 10, heigth: 10, color: .gray)
                                        Rectangle().reusableShape(width: 10, heigth: 10, color: .gray)
                                    }.padding(.bottom, 12)
                                }.reusableTabbar(width: 110, height: 180, maskRadius: 12, overlayRadius: 8, strokeColor: .gray)
                                //.modifier(themeTabbar())
                                
// MARK: - Label
                                Text(item.themeName)
                                    .reusableLabel(font: .headline, size: 20, design: .serif, color: item.mainColor)
                            } // VS
                        }.accentColor(Color.primary)
                    }.padding(.horizontal, 5)
                }
            }
            // MARK: - Alert
            .alert(isPresented: $isThemeChanged) {
                Alert(
                    title: Text(NSLocalizedString("done", comment: "")),
                    message: Text(NSLocalizedString("changed_theme", comment: "")),
                    dismissButton: .default(Text("Ok"))
                )}
        }
    }
}

// MARK: - PREVIEW
struct SettingsTheme_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTheme().padding()
    }
}
