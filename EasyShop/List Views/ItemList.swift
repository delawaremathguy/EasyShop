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
    
    var body: some View {
        VStack {
            Section {
                HStack(spacing: 5) {
                    TextField("name of the product", text: $name)
                        .frame(height: rowHeight)
                        .padding(.vertical, 10)
                        .padding(.leading, 15)
                        .font(Font.system(size: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .disableAutocorrection(true)
                        .keyboardType(UIKeyboardType.default)
                    
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color("tint"))
                            .opacity(name.isEmpty ? 0.6 : 1.0)
                    }.disabled(name.isEmpty)
                    .padding()
                } // HS
                .background(Color("accent"))
            }
            Section {
                List {
                    ForEach(store.getItem) { s in
                        ItemListRow(item: s).id(UUID())
                    }.onDelete(perform: deleteItem)
                }.listStyle(GroupedListStyle())
            }
        }.navigationBarTitle(("Products"), displayMode: .inline)
    }
    func newItem() {
//        withAnimation {
            let addItem = Item(context: self.moc)
            addItem.name = name
            addItem.order = (items.last?.order ?? 0) + 1
            addItem.select = false 
            store.addToItem(addItem)
            PersistentContainer.saveContext()
            self.name = ""
 //       }
    }
    func deleteItem(at offsets: IndexSet) {
//        withAnimation {
            for index in offsets {
                self.moc.delete(self.items[index])
            }
            PersistentContainer.saveContext()
//        }
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
            .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
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
