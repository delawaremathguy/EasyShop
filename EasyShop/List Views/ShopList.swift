import SwiftUI
import CoreData

var rowHeight: CGFloat = 50 //.frame(height: rowHeight)

struct ShopList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Shop.allShops()) var shops: FetchedResults<Shop>
    
    @State var name = ""
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(shops, id: \.self) { s in
                        NavigationLink(destination: ItemList(store: s)) {
                            ShopListRow(store: s).id(UUID())
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
            let addShop = Shop(context: moc)
            addShop.name = name
            addShop.order = (shops.last?.order ?? 0) + 1
            addShop.select = false
            PersistentContainer.saveContext()
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
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    var body: some View {
        HStack {
            Image(systemName: self.store.select ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundColor(Color("tint"))
                .padding(.leading, 10)
                .onTapGesture(perform: { self.store.select.toggle() })
            Text(store.shopName)
                .font(Font.system(size: 20))
                .padding(.leading, 20)
            Spacer()
        }.frame(height: rowHeight)
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
            //.preferredColorScheme(.dark)
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
