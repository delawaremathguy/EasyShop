import SwiftUI
import CoreData

struct ItemList: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @State var name = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Section {
                // MARK: - TEXTFIELD
                HStack(spacing: 0) {
                    TextField("new Product here...", text: $name)
                        .frame(height: rowHeight)
                        .background(Color("ColorWhiteBlack"))
                        .font(Font.system(size: 20))
                        .multilineTextAlignment(.center)
                        .disableAutocorrection(true)
                        .keyboardType(UIKeyboardType.default)
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .frame(width: 50, height: 50)
                            .foregroundColor(themes[self.theme.themeSettings].mainColor)
                            .opacity(name.isEmpty ? 0.4 : 1.0)
                            .background(Color("ColorWhiteBlack"))
                    }.disabled(name.isEmpty)
                }
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color("ColorWhiteBlack")))
                .padding()
                .background(Color("ColorAccent"))
            } // SE
            Section {
                // MARK: - LIST
                List {
                    ForEach(store.getItem) { s in ItemListRow(item: s)
                    }.onDelete(perform: deleteItem)
                }.listStyle(GroupedListStyle())
            }
            // MARK: - Footer
            HStack {
                Text("Total items: \(store.getItem.count) ")
                Spacer()
                Text("Items selected: ?? ")
            }.padding(5)
        }
        .navigationTitle("\(store.shopName)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { selectAll() }) {
                    Text("Select All")
                        .foregroundColor(themes[self.theme.themeSettings].mainColor)
                }.disabled(store.getItem.isEmpty)
            }
        }
    }
    // MARK: - FUNCTIONS
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
    func selectAll() {
        // all items are selected when pressed
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



