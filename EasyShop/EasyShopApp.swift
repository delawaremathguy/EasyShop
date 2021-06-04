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
               // .environmentObject(IconNames())
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

