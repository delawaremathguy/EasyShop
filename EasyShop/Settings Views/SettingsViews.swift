import SwiftUI

struct SettingsViews: View {
    @ObservedObject var theme = gThemeSettings
    @State private var action: Int? = 0
        
    var body: some View {
        NavigationView {
            Form {
                SettingsTheme()
                
                SettingsDarkMode()
                
                LogoView()
                
            }.navigationBarTitle(NSLocalizedString("tab_settings", comment: ""), displayMode: .inline)
        }
    }
}

// MARK: - LOGO VIEW

struct LogoView: View {
    @ObservedObject var theme = gThemeSettings
    var body: some View {
        Section(header: Text(NSLocalizedString("logo", comment: "Information about the app"))) {
            Image("easyshoplogo").foregroundColor(theme.mainColor)
                .reusableSection(miW: 0, maW: .infinity, miH: 0, maH: .infinity, ali: .center)
            Text(NSLocalizedString("version", comment: "Version of the app"))
                .reusableSection(miW: 0, maW: .infinity, miH: 0, maH: .infinity, ali: .center)
        }
    }
}
extension View {
    func reusableSection(miW: CGFloat, maW: CGFloat, miH: CGFloat, maH: CGFloat, ali: Alignment) -> some View {
        self
            .frame(minWidth: miW, maxWidth: maW, minHeight: miH, maxHeight: maH, alignment: ali)
    }
}

 // MARK: - PREVIEWS

struct SettingsViews_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViews()
    }
}

/*
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
         .navigationBarTitle(NSLocalizedString("tab_settings", comment: ""), displayMode: .inline)
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
                 .reusableImage(width: 40, height: 40, padding: 10)
             Text(text)
                 .reusableLabel(font: .headline, size: 20, design: .serif, color: theme.mainColor)
             Spacer()
             Image(systemName: "chevron.right")
                 .padding(.trailing, 15)
         }
         .background(Color("ColorAccent"))
         .frame(maxWidth: .infinity)
     }
 }
 
 */
