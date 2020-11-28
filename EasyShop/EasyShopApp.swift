import SwiftUI

@main
struct EasyShopApp: App {
    let context = PersistentContainer.persistentContainer.viewContext
    var body: some Scene {
        if Shop.count() == 0 {
            Shop.loadSeedData(into: context)
        }
        return WindowGroup {
            ContentView().environment(\.managedObjectContext, context)
        }
    }
}
