import SwiftUI

struct ContentView: View {
    @State private var selected = 0
    var body: some View {
        TabView(selection: $selected) {
            SelectedShopView().tabItem ({
                Text("Selected")
                Image(systemName: "plus")
            }).tag(0)
            ShopList().tabItem ({
                Text("List")
                Image(systemName: "calendar")
            }).tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
