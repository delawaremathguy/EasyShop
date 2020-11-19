import SwiftUI
import CoreData

struct SelectedShopView: View {
//DMG3 -- not used in this View: @Environment(\.managedObjectContext) var moc
//DMG3 --
// use a simple, direct fetch request here.  we'll just get all the
// shops and filter them for what appears in the list.  however, for some reason
// that i don't fully understand, when a Shop's itemWillChange.send() message is
// invoked on the change of the status of an Item, this @FetchRequest is not
// redrawing.  i think this can be fixed; staty tuned.  but there is a UI issue
// that you might want to think about as to whether this view should be empty
// if no shop has any items remaining to be purchased.
    @FetchRequest(
        entity: Shop.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    private var shops: FetchedResults<Shop> //DMG3
    @State private var selectedShops = [Shop]() // DMG3 — added
    
    var body: some View {
        NavigationView {
            ZStack { // and, you do need a ZStack! DUH!
                List {
                    ForEach(selectedShops) { s in
                        NavigationLink(destination: SelectedItemView(store: s)) {
                            SelectedShopRow(store: s)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Shops")
                //DMG3 —
                // this makes sure we update the list of shops that should appear
                .onAppear { selectedShops = shops.filter({ $0.hasItemsOnListOrInCart })
                }
                
                if shops.filter({ $0.hasItemsOnListOrInCart }).count == 0 {
                    EmptySelectedShop()
                }
            }
        }
    }
}

// MARK: - SELECTEDSHOP

struct SelectedShopRow: View {
    
    //DMG3 --
    // not used in this View: @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName)
                .font(Font.system(size: 28))
                .padding(.leading, 20)
            Spacer()
            //Text(store.hasItemsOnListOrInCart ? "has items" : "no items")
        }.frame(height: rowHeight)
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
        return SelectedShopRow(store: data)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - EmptySelectedShop

struct EmptySelectedShop: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Start from the List section!")
                Image(systemName: "tray.and.arrow.down.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
            }.foregroundColor(Color("tint")).opacity(0.8)
        }.edgesIgnoringSafeArea(.all)
    }
}
