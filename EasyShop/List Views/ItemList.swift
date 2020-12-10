import SwiftUI
import CoreData

struct ItemList: View {
    @Environment(\.presentationMode) var present
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @State var name = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Section {
                HStack(spacing: 0) {
// MARK: - HEADER
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .modifier(customButton())
                            .opacity(name.isEmpty ? 0.4 : 1.0)
                            .background(Color("ColorWhiteBlack"))
                    }.disabled(name.isEmpty)
                    TextField("new product here...", text: $name)
                        .modifier(customTextfield())
                    Text("\(store.getItem.count)").padding(15)
                }.modifier(customHStack())
            } // SE
            Section {
// MARK: - LIST
                List {
                    ForEach(store.getItem) { s in ItemListRow(item: s)
                    }.onDelete(perform: deleteItem)
                }.listStyle(GroupedListStyle())
            }
        }
        .navigationTitle("\(store.shopName)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
// MARK: - TOOLBAR
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { present.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left").font(.system(size: 16, weight: .regular))
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { selectAll() }) {
                    Text("Select All")
                        .opacity(kNotOnList != 0 ? 1.0 : 0.6)
                }.disabled(store.getItem.isEmpty)
            }
        }
        .onAppear { print("ItemList appears") }
        .onDisappear { print("ItemList disappers") }
    }
// MARK: - FUNCTIONS
    func newItem() {
        Item.addNewItem(named: name, to: store)
        self.name = ""
        print("New Item created")
    }
    func deleteItem(at offsets: IndexSet) {
        let items = store.getItem
        for index in offsets {
            self.moc.delete(items[index])
        }
        PersistentContainer.saveContext()
        print("Item deleted")
    }
    func selectAll() { // Test
        print(" selectAll function executed")
        for item in store.getItem {
            if item.status == kNotOnList {
                item.status = kOnListNotTaken
            }
        }
    }
}

// MARK: - ITEM ROW

struct ItemListRow: View {
    @ObservedObject var item: Item
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    
    var body: some View {
        Button(action: {
            self.item.toggleSelected()
            print("item added to List not taken")
        }) {
            HStack {
                Text(item.itemName)
                    .modifier(customText())
                Spacer()
                Image(systemName: item.status != kOnListNotTaken ? "circle" : "checkmark.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(themes[self.theme.themeSettings].mainColor)
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
            .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}

struct ItemListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let datum = Item(context: moc)
        datum.name = "Chicken"
        return Group {
            ItemListRow(item: datum)
                .padding()
                .previewLayout(.sizeThatFits)
            ItemListRow(item: datum)
                .preferredColorScheme(.dark)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}



