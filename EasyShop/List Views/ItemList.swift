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
                    TextField("name of the product", text: $name)
                        .modifier(CustomTextField1())
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .modifier(CustomButton1())
                            .foregroundColor(name.isEmpty ? Color("wb") : Color("tint"))
                    }.disabled(name.isEmpty)
                }.modifier(CustomHStack1())
            } // SE
            Section {
                List {
                    ForEach(store.getItem) { s in ItemListRow(item: s)//, store: s
                    }.onDelete(perform: deleteItem)
                }.listStyle(GroupedListStyle())
            }
        }.navigationBarTitle(("Products"), displayMode: .inline)
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
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var item: Item
    
    var body: some View {
        Button(action: {
            self.item.toggleSelected()
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

