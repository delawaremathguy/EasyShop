import SwiftUI
import CoreData

struct ItemList: View {
    @Environment(\.presentationMode) var present
    @ObservedObject var store: Shop
    @ObservedObject var theme = gThemeSettings
    @State var name = ""
    let selectImpact = UIImpactFeedbackGenerator(style: .medium)
    let deselectImpact = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        VStack(spacing: 0) {
            Section {
                HStack(spacing: 0) {
// MARK: - Header
                    Button(action: { newItem() }) {
                        Image(systemName: "plus")
                            .modifier(customButton())
                            .opacity(name.isEmpty ? 0.4 : 1.0)
                            .background(Color("ColorWhiteBlack"))
                    }.disabled(name.isEmpty)
                    TextField("Add new product", text: $name)
                        .modifier(customTextfield())
                    Text("\(store.getItem.count)").padding(15)
                }.modifier(customHStack())
            }
            Section {
                Rectangle()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
// MARK: - List
                List {
                    ForEach(store.getItem) { s in
                        ItemListRow(item: s)
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: doMove).animation(.default) // Animation Test
                }.listStyle(GroupedListStyle())
// MARK: - Footer
            }
            Section {
                Rectangle()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                HStack {
                    Button(action: { deselectAll()
                        deselectImpact.impactOccurred()
                    }) {
                        Text("Deselect All").padding(.leading, 12)
                    }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
                    Spacer()
                    Button(action: { selectAll()
                        selectImpact.impactOccurred()
                    }) {
                        Text("Select All").padding(.trailing, 12)
                    }.disabled((store.getItem.filter({ $0.status == kNotOnList }).count == 0) == true)
                }.padding(.vertical, 10)
            }
        }
        .navigationTitle("\(store.shopName)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
// MARK: - Toolbar
        .toolbar {
            ToolbarItem(placement: .cancellationAction, content: backButton)
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
        }.disabled(store.getItem.count == 0)
        .onAppear { print("ItemList appears") }
        .onDisappear { print("ItemList disappers") }
    }
// MARK: - Functions
    func newItem() {
        Item.addNewItem(named: name, to: store)
        self.name = ""
        print("New Item created")
    }
    func deleteItem(at offsets: IndexSet) {
        let items = store.getItem
        offsets.forEach({ Item.delete( items[$0] )})
        print("Item deleted")
    }
    private func doMove(from indexes: IndexSet, to destinationIndex: Int) {
        var revisedItems: [Item] = store.getItem.map{ $0 }
        revisedItems.move(fromOffsets: indexes, toOffset: destinationIndex)
        for index in 0 ..< revisedItems.count {
            revisedItems[index].position = Int32(index)
            revisedItems.first?.shop?.objectWillChange.send()
        }
        print("move from \(indexes) to \(destinationIndex)")
    }
    func backButton() -> some View {
        Button(action: { present.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left").font(.system(size: 16, weight: .regular))
        }
    }
    func selectAll() {
        print("selectAll function executed")
        store.getItem.forEach({ $0.status = kOnListNotTaken })
    }
    func deselectAll() {
        print("deselectAll function executed")
        store.getItem.forEach({ $0.status = kNotOnList })
    }
}

// MARK: - ITEMLISTROW

struct ItemListRow: View {
    @ObservedObject var item: Item
    @ObservedObject var theme = gThemeSettings
    let selectedImpact = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        Button(action: {
            self.item.toggleSelected()
            selectedImpact.impactOccurred()
            print("item added to List not taken")
        }) {
            HStack {
                Text(item.itemName).modifier(customItemText())
                Spacer()
                Image(systemName: item.status != kOnListNotTaken ? "circle" : "checkmark.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(theme.mainColor)
            }.frame(height: rowHeight)
        }.animation(.default) // Animation Test
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



