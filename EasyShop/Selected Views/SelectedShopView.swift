import SwiftUI
import CoreData

struct SelectedShopView: View { // Section A
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @State private var selectedShops = [Shop]() // DMG3 — added
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(selectedShops) { s in
                        NavigationLink(destination: SelectedItemView(store: s)) {
                            SelectedShopRow(store: s)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Shops")
                .onAppear { selectedShops = Shop.selectedShops() }
                if selectedShops.count == 0 { EmptySelectedShop() }
            }
        }.accentColor(themes[self.theme.themeSettings].mainColor)
    }
}

// MARK: - SELECTEDSHOP

struct SelectedShopRow: View {
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName).modifier(customText())
            Spacer() // Section B
        }.frame(height: rowHeight)
    }
}
// MARK: - EmptySelectedShop

struct EmptySelectedShop: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    var body: some View {
        ZStack {
            VStack {
                Text("Start from the List section!")
                Image(systemName: "tray.and.arrow.down.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
            }.foregroundColor(themes[self.theme.themeSettings].mainColor).opacity(0.8)
        }.edgesIgnoringSafeArea(.all)
    }
}
// MARK: - PREVIEWS

struct SelectedShopView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedShopView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
struct SelectedShopRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Whole Food"
        return Group {
            SelectedShopRow(store: data)
                .padding()
                .previewLayout(.sizeThatFits)
            SelectedShopRow(store: data)
                .preferredColorScheme(.dark)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}


// Section A

//DMG3 -- not used in this View: @Environment(\.managedObjectContext) var moc
//DMG3 --
// use a simple, direct fetch request here.  we'll just get all the
// shops and filter them for what appears in the list.  however, for some reason
// that i don't fully understand, when a Shop's itemWillChange.send() message is
// invoked on the change of the status of an Item, this @FetchRequest is not
// redrawing.  i think this can be fixed; staty tuned.  but there is a UI issue
// that you might want to think about as to whether this view should be empty
// if no shop has any items remaining to be purchased.
//    @FetchRequest(
//        entity: Shop.entity(),
//        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],
//        predicate: NSPredicate(format: "ANY item.status16 > 0"))
//    private var shops: FetchedResults<Shop> //DMG3

// Section B
//Text(store.hasItemsOnListOrInCart ? "has items" : "no items")
