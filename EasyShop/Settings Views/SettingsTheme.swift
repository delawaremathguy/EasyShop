import SwiftUI

struct SettingsTheme: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @State private var isThemeChanged: Bool = false
    let themeImpact = UIImpactFeedbackGenerator(style: .medium)
    
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
                            themeImpact.impactOccurred()
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
                                        Rectangle()
                                            .frame(width: 10, height: 10)
                                            .foregroundColor(item.mainColor)
                                        Rectangle().modifier(themeRectangle())
                                        Rectangle().modifier(themeRectangle())
                                    }.padding(.bottom, 12)
                                }.modifier(themeTabbar())
                                // MARK: - Label
                                Text(item.themeName).modifier(capsuleFont())
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
