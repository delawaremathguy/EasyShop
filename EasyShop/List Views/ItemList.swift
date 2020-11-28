import SwiftUI
import CoreData

struct ItemList: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    @State var name = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Section {
                HStack(spacing: 0) {
                    TextField("new Product here...", text: $name)
                        .frame(height: rowHeight)
                        .background(Color("wb"))
                        .font(Font.system(size: 20))
                        .multilineTextAlignment(.center)
                        .disableAutocorrection(true)
                        .keyboardType(UIKeyboardType.default)
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color("tint"))
                            .opacity(name.isEmpty ? 0.4 : 1.0)
                            .background(Color("wb"))
                    }.disabled(name.isEmpty)
                }
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color("wb")))
                .padding()
                .background(Color("accent"))
            } // SE
            Section {
                List {
                    ForEach(store.getItem) { s in ItemListRow(item: s)
                    }.onDelete(perform: deleteItem)
                }.listStyle(GroupedListStyle())
            }
        }
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.inline)
    }
    func newItem() {
        Item.addNewItem(named: name, to: store)
        self.name = ""
    }
    func deleteItem(at offsets: IndexSet) {
        let items = store.getItem
        for index in offsets {
            self.moc.delete(items[index])
        }
        PersistentContainer.saveContext()
    }
}

// MARK: - ITEM ROW

struct ItemListRow: View {
    @ObservedObject var item: Item
    
    var body: some View {
        Button(action: {
            self.item.toggleSelected()
        }) {
            HStack {
                Text(item.itemName)
                    .modifier(customText())
                Spacer()
                Image(systemName: item.status != kOnListNotTaken ? "circle" : "checkmark.circle.fill") .imageScale(.large)
                    .foregroundColor(Color("tint"))
            }.frame(height: rowHeight)
        }.onReceive(self.item.objectWillChange) { PersistentContainer.saveContext()
        }
    }
}

// MARK: - PREVIEWS

struct ItemList_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "K-Mart"
        let datum = Item(context: moc)
        datum.name = "Eggs"
        data.addToItem(datum)
        return ItemList(store: data) 
            .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)//.preferredColorScheme(.dark)
    }
}

struct ItemListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let datum = Item(context: moc)
        datum.name = "Chicken"
        return ItemListRow(item: datum)
            .padding()
            .previewLayout(.sizeThatFits)//, store: data
    }
}



