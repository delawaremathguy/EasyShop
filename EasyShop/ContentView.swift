import SwiftUI

struct ContentView: View {
    @State private var selected = 0
    var body: some View {
        TabView(selection: $selected) {
            SelectedShopView().tabItem ({
                Text("Cart")
                Image(systemName: "cart")
            }).tag(0)
            ShopList().tabItem ({
                Text("List")
                Image(systemName: "square.and.pencil")
            }).tag(1)
        }.accentColor(Color("tint"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
