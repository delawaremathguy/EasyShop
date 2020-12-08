import SwiftUI

struct SettingsViews: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 25) {
                    NavigationLink(destination: SettingsTheme(), tag: 1, selection: $action) {
                        HStack {
                            Image("appearance")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(10)
                            Text("Appearance")
                                .foregroundColor(themes[self.theme.themeSettings].mainColor)
                                .font(.headline)
                                .font(Font.system(size: 20, design: .serif))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding(.trailing, 15)
                        }
                        .background(Color("ColorAccent"))
                        .frame(maxWidth: .infinity)
                    }
                }.padding(.top, 45)
                Spacer()
                VStack {
                    Image("easyshoplogo")
                        .foregroundColor(themes[self.theme.themeSettings].mainColor)
                    Text("Version 1.0").font(.caption)
                }
                Spacer()
            } // Main VS
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

 // MARK: - PREVIEWS

struct SettingsViews_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViews()
    }
}
