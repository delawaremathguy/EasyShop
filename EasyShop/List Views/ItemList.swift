/*
Shop - shopName /// Item - itemName -> getItem
*/
import SwiftUI
import CoreData

struct ItemList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: []
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
                        HStack {
                            Text(s.itemName)
                        }
                    }.onDelete(perform: deleteItem)
                }
            }
        }.navigationBarTitle(("Items"), displayMode: .inline)
    }
    
    func newItem() {
        withAnimation {
            let addItem = Item(context: self.moc)
            addItem.name = name
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

//struct ItemList_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemList()
//    }
//}
