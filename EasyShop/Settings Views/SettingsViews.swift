import SwiftUI

struct SettingsViews: View {
    @ObservedObject var theme = gThemeSettings
    @State private var action: Int? = 0
        
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 25) {
// MARK: - Navigation
                    NavigationLink(destination: SettingsAppearance(), tag: 1, selection: $action) {
                        CapsuleRow(image: "appearance", text: (NSLocalizedString("appearance", comment: "")))
                    }
                }.offset(y: -190)
                
// MARK: - Logo
                VStack {
                    Image("easyshoplogo").foregroundColor(theme.mainColor)
                    Text(NSLocalizedString("version", comment: "Version of the app")).font(.caption)
                }
                .transition(.move(edge: .top))
                .animation(.easeOut(duration: 0.8))
            }
            .navigationTitle(NSLocalizedString("tab_settings", comment: ""))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - CAPSULEROW

struct CapsuleRow: View {
    @ObservedObject var theme = gThemeSettings
    var image: String
    var text: String
    
    var body: some View {
        HStack {
            Image(image)
                .capsuleImage(width: 40, height: 40, padding: 10)
            Text(text)
                .foregroundColor(theme.mainColor)
                .modifier(capsuleFont())
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.trailing, 15)
        }
        .background(Color("ColorAccent"))
        .frame(maxWidth: .infinity)
    }
}

 // MARK: - PREVIEWS

struct SettingsViews_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViews()
    }
}

