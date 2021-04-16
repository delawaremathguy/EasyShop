import SwiftUI

@main
struct EasyShopApp: App {
    let context = PersistentContainer.persistentContainer.viewContext
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some Scene {
        if Shop.count() == 0 {
            Shop.loadSeedData(into: context)
        }
        return WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context)
                .environmentObject(IconNames())
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

class IconNames: ObservableObject {
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for (_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String,Any> else { return }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                guard let icon = iconFiles.first else { return }
                
                iconNames.append(icon)
            }
        }
    }
}
