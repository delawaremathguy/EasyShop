/*
Shop - shopName /// Item - itemName -> getItem
*/
import SwiftUI

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
                    }
                }
            }
        }
    }
    
    func newItem() {
        let addItem = Item(context: self.moc)
        addItem.name = name
        store.addToItem(addItem)
        PersistentContainer.saveContext()
        self.name = ""
    }
}

//struct ItemList_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemList()
//    }
//}
