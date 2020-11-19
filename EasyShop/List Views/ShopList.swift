import SwiftUI
import CoreData

var rowHeight: CGFloat = 50

struct ShopList: View {
    @Environment(\.managedObjectContext) var moc
    //DMG3 -- use a simple, direct fetch request here.
    @FetchRequest(
        entity: Shop.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    private var shops: FetchedResults<Shop>
    
    @State var name = ""
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(shops, id: \.self) { s in
                        NavigationLink(destination: ItemList(store: s)) {
                            ShopListRow(store: s)
                        }
                    }.onDelete(perform: deleteShop)
                } // LS
                .listStyle(GroupedListStyle())
                .sheet(isPresented: $isPresented) { ShopListModal { name in
                    self.newShop(name: name)
                    self.isPresented = false } }
                .navigationBarTitle(("Shops"), displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: { self.isPresented.toggle() }) {
                    Image(systemName: "plus")
                          .imageScale(.large)
                          .frame(width: 50, height: 50)
                })
                if shops.count == 0 { EmptyShopList() }
            } // ZS
        }.accentColor(Color("tint"))
    }
    func newShop(name: String) {
        Shop.addNewShop(named: name)
         self.name = ""
    }
    func deleteShop(at offsets: IndexSet) {
            for index in offsets {
                self.moc.delete(self.shops[index])
            }
            PersistentContainer.saveContext()
    }
}

// MARK: - SHOP ROW

struct ShopListRow: View {
    //DMG3 -- no need for @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName)
                .font(Font.system(size: 20))
                .padding(.leading, 20)
            Spacer()
            //DMG3 --
            // you can't leave a system name "" here, so instead, use an if ...
            if store.hasItemsInCartNotYetTaken {
                Image(systemName: "checkmark")
                    .imageScale(.large)
                    .foregroundColor(Color("tint"))
                    .padding(.leading, 10)
            }
        }
        .frame(height: rowHeight)
        .onReceive(self.store.objectWillChange) {
            PersistentContainer.saveContext()
        }
    }
}

// MARK: - EMPTY SHOP LIST

struct EmptyShopList: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Add new Shop from here!")
                    Image(systemName: "arrow.up.right")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .trailing)
                }
                .foregroundColor(Color("tint")).opacity(0.8)
                .padding()
                Spacer()
            }
        }
    }
}

// MARK: - PREVIEWS

struct ShopList_Previews: PreviewProvider {
    static var previews: some View {
        ShopList().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}

struct ShopListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Whole Foods"
        return ShopListRow(store: data).previewLayout(.sizeThatFits)
    }
}

struct EmptyShopList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyShopList()
            .frame(width: 300, height: 100)
            .previewLayout(.sizeThatFits)
    }
}
