import SwiftUI
import CoreData

struct ItemList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.order, ascending: true)]
    ) var items: FetchedResults<Item>
    
    @ObservedObject var store: Shop
    @State var name = ""
    @State private var totalItems: Int = 0 // Text(String(totalItems)).bold()
    
    var body: some View {
        VStack {
            Section {
                HStack {
                    TextField("name of the product", text: $name).modifier(customTextfield())
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .frame(width: 40, height: 40)
                    }.disabled(name.isEmpty)
                }
            }
            Section {
                List {
                    ForEach(store.getItem) { s in
                        ItemListRow(item: s).id(UUID())//, store: store
                    }.onDelete(perform: deleteItem)
                }
            }
        }
        .onAppear(perform: countItems)
        .navigationBarTitle(("Items"), displayMode: .inline)
        .navigationBarItems(leading: Text(String(totalItems)).bold())
    }
    func newItem() {
        withAnimation {
            let addItem = Item(context: self.moc)
            addItem.name = name
            addItem.order = (items.last?.order ?? 0) + 1
            addItem.select = false 
            store.addToItem(addItem)
            PersistentContainer.saveContext()
            self.name = ""
        }
    }
    func deleteItem(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                self.moc.delete(self.items[index])
            }
            PersistentContainer.saveContext()
        }
    }
    
    func countItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        if let count = try? self.moc.count(for: request) {
            self.totalItems = count
        }
    }
}

// MARK: - PREVIEWS

struct ItemList_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Carrefour"
        let datum = Item(context: moc)
        datum.name = "Caramelo"
        data.addToItem(datum) // addToItem - default func
        return ItemList(store: data) // store - ObservedObject
    }
}

/*
 
 func selectedData(shop: [Shop]) {
     let moc = PersistentContainer.context
     moc.performAndWait {
         shop.forEach { stores in
             let newShop = Shop(context: moc)
             newShop.select = true
             
             newShop.item?.forEach { itemss in
                 let itemss = Item(context: moc)
                 itemss.select = true
                 
             }
         }
     }
     PersistentContainer.saveContext()
 }
 */
