import SwiftUI

struct ContentView: View {
    
    @State private var selected = 0
    
    var body: some View {
        TabView(selection: $selected) {
            SelectedShopView().tabItem ({
                Text("Cart")
                Image("shopcart")
            }).tag(0)
            ShopList().tabItem ({
                Text("List")
                Image("shoplist")
            }).tag(1)
            SettingsViews().tabItem ({
                Text("Settings")
                Image("shopsettings")
            }).tag(2)
            
        }.accentColor(Color("tint"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
