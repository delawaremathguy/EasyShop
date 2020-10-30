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
                HStack {
                    TextField("name of the product", text: $name).modifier(customTextfield())
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .frame(width: 40, height: 40)
                    }.disabled(name.isEmpty)
                }
            }
            Section {
                List {
                    ForEach(store.getItem) { s in
                        ItemRow(item: s).id(UUID())
                    }.onDelete(perform: deleteItem)
                }
            }
        }.navigationBarTitle(("Items"), displayMode: .inline)
    }
    
    func newItem() {
        withAnimation {
            let addItem = Item(context: self.moc)
            addItem.name = name
            addItem.order = (items.last?.order ?? 0) + 1
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
}

// MARK: - CUSTOM ROW

struct ItemRow: View {
    let item: Item
    var body: some View {
        HStack {
            Text(item.itemName).modifier(cellText())
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

struct ItemRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let datum = Item(context: moc)
        datum.name = "Caramelo"
        return ItemRow(item: datum).previewLayout(.sizeThatFits)
    }
}
