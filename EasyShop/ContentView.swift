import SwiftUI // Project on GitHub
import CoreData

struct ContentView: View {
    @ObservedObject var theme = gThemeSettings
    @State private var selected = 1
    
    var body: some View {
                TabView(selection: $selected) {
                    
                    ShopList().tabItem {
                        Text("List")
                        Image("shoplist")
                    }.tag(0)
                    
                    SelectedShopView().tabItem {
                        Text("Cart")
                        Image((Item.onShoppingListCount() != 0) ? "shopcartbadge" : "shopcart")
//                        Image(((store.getItem.filter({ $0.status == kOnListNotTaken }).count != 0) ? "shopcart" : "shopcartbadge")) // shopcartbadge - "shopcart"
                    }.tag(1)
                    
                    SettingsViews().tabItem {
                        Text("Settings")
                        Image("shopsettings")
                    }.tag(2)
                }.accentColor(theme.mainColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
