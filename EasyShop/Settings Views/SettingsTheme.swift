import SwiftUI

struct SettingsTheme: View {
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    @State private var isThemeChanged: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("App Theme")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 35) {
                            ForEach(themes, id: \.id) { item in
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                    self.isThemeChanged.toggle()
                                }) {
                                    VStack {
                                        VStack {
                                            Spacer()
                                            
                                            Divider()
                                                .frame(width: 50, height: 3)
                                                .background(item.mainColor)
                                            
                                            Image(systemName: "tray.and.arrow.down.fill")
                                                .foregroundColor(item.mainColor)
                                                .font(.system(size: 35, weight: .regular))
                                            
                                            Spacer().frame(height: 45)
                                            
                                            Divider().background(Color.gray) // Tabbar
                                            
                                            HStack(spacing: 20) {
                                                Rectangle()
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(item.mainColor)
                                                Rectangle()
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(Color.gray)
                                                Rectangle()
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(Color.gray)
                                            }.padding(.bottom, 12)
                                        }
                                        .frame(width: 110, height: 180)
                                        .mask(RoundedRectangle(cornerRadius: 12))
                                        .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray))
                                        
                                        Text(item.themeName)
                                            .font(.headline)
                                            .font(Font.system(size: 20, design: .serif))
                                    } // VS
                                }.accentColor(Color.primary)
                            }.padding(.horizontal, 5)
                        }
                    } // SV
                    // MARK: - ALERT
                    .alert(isPresented: $isThemeChanged) {
                        Alert(
                            title: Text("DONE!"),
                            message: Text("\(themes[self.theme.themeSettings].themeName) is ON!!! Now close the App and open it again"),
                            dismissButton: .default(Text("Ok"))
                    )}
                }
            }
        }
    }
}
// MARK: - PREVIEW
struct SettingsTheme_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsTheme()
                .padding()
                .previewLayout(.sizeThatFits)
            
            SettingsTheme()
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
