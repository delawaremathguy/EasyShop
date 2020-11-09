import SwiftUI
import CoreData

struct ItemList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Item.allItems()) var items: FetchedResults<Item>
    
    @ObservedObject var store: Shop
    @State var name = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Section {
                HStack(spacing: 0) {
                    TextField("name of the product", text: $name)
                        .modifier(CustomTextField1())
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .modifier(CustomButton1())
                            .foregroundColor(name.isEmpty ? Color("wb") : Color("tint"))
                    }.disabled(name.isEmpty)
                }.modifier(CustomHStack1())
            } // SN
            Section {
                List {
                    ForEach(store.getItem) { s in ItemListRow(item: s).id(UUID())
                    }.onDelete(perform: deleteItem)
                }.listStyle(GroupedListStyle())
            }
        }.navigationBarTitle(("Products"), displayMode: .inline)
    }
    func newItem() {
            let addItem = Item(context: self.moc)
            addItem.name = name
            addItem.order = (items.last?.order ?? 0) + 1
            addItem.select = false 
            store.addToItem(addItem)
            PersistentContainer.saveContext()
            self.name = ""
    }
    func deleteItem(at offsets: IndexSet) {
            for index in offsets {
                self.moc.delete(self.items[index])
            }
            PersistentContainer.saveContext()
    }
}

// MARK: - ITEM ROW

struct ItemListRow: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var item: Item
    var body: some View {
        Button(action: {
               self.item.select.toggle()
        }) {
            HStack {
                Image(systemName: self.item.select ? "star.fill" : "star")
                    .imageScale(.large)
                    .foregroundColor(Color("tint"))
                    .padding(.leading, 10)
                Text(item.itemName)
                    .foregroundColor(Color("bw"))
                    .font(Font.system(size: 20))
                    .padding(.leading, 20)
                Spacer()
            }.frame(height: rowHeight)
        }
        .onReceive(self.item.objectWillChange) { PersistentContainer.saveContext() }
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
        data.addToItem(datum) // addToItem - default func
        return ItemList(store: data) // store - ObservedObject
            .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)//.preferredColorScheme(.dark)
    }
}

struct ItemListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let datum = Item(context: moc)
        datum.name = "Chicken"
        return ItemListRow(item: datum).previewLayout(.sizeThatFits)//, store: data
    }
}

// MARK: - MODIFIERS

struct CustomTextField1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: rowHeight)
            .background(Color("wb"))
            .font(Font.system(size: 20))
            .multilineTextAlignment(.center)
            .disableAutocorrection(true)
            .keyboardType(UIKeyboardType.default)
    }
}

struct CustomButton1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .frame(width: 50, height: 50)
            .background(Color("wb"))
    }
}

struct CustomHStack1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color("wb")))
            .padding()
            .background(Color("accent"))
    }
}

