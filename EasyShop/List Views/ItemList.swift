import SwiftUI
import CoreData

struct ItemList: View {
    
// MARK: - PROPERTIES
    @Environment(\.presentationMode) var present
    
    @ObservedObject var store: Shop
    @ObservedObject var theme = gThemeSettings
    
    @State var name = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Section {
                HStack(spacing: 0) {
                    
// MARK: - HEADER
                    Text("\(store.getItem.filter({ $0.status == kOnListNotTaken }).count)")
                        .frame(minWidth: 45, maxWidth: 55)
                    TextField(NSLocalizedString("new_product", comment: "new product here..."), text: $name)
                        .reusableTextField(height: rowHeight, color: colorWhiteBlack, fontSize: 20, alignment: .center, autocorrection: true, limit: 2)
                    Button(action: {
                        withAnimation {
                            newItem()
                            impactSoft.impactOccurred()
                        }}) {
                        Image(systemName: "plus")
                            .reusableButtonImage(scale: .large, width: 50, height: 50, colorF: theme.mainColor, opacity: name.isEmpty ? 0.4 : 1.0)
                    }.disabled(name.isEmpty)
                }.reusableHstack(radius: 5, stroke: 1, colorF: colorWhiteBlack, colorB: colorAccent)
            } // SC
            
// MARK: - LIST
            Section {
                List {
                    ForEach(store.getItem) { s in
                        ItemListRow(item: s)
                    } // FE
                    .onDelete(perform: deleteItem)
                    .onMove(perform: doMove)
                }.listStyle(GroupedListStyle()) // LS
            } // SC
            
// MARK: - FOOTER
            Section {
                InfinitLine()
                HStack {
                    Button(action: {
                            withAnimation {
                                deselectAll()
                                impactMedium.impactOccurred()
                            }}) {
                            Text(NSLocalizedString("deselet_all", comment: ""))
                    }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
                    Spacer()
                    Button(action: {
                            withAnimation {
                                selectAll()
                                impactMedium.impactOccurred()
                            }}) {
                            Text(NSLocalizedString("select_all", comment: ""))
                    }.disabled((store.getItem.filter({ $0.status == kNotOnList }).count == 0) == true)
                }.padding([.horizontal, .vertical], 10)
            } // SC
        } // VS
        
// MARK: - MODIFIERS
        .navigationBarTitle("\(store.shopName)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction, content: backButton)
            ToolbarItem(placement: .navigationBarTrailing) { EditButton().disabled(store.getItem.count == 0) }
        }
        .onAppear { print("ItemList appears") } // PRINTING TEST
        .onDisappear { print("ItemList disappers") } // PRINTING TEST
    }
    
// MARK: - FUNCTIONS
    func newItem() {
        Item.addNewItem(named: name, to: store)
        self.name = ""
        print("New Item created") // PRINTING TEST
    }
    func deleteItem(at offsets: IndexSet) {
        let items = store.getItem
        offsets.forEach({ Item.delete( items[$0] )})
        print("Item deleted") // PRINTING TEST
    }
    private func doMove(from indexes: IndexSet, to destinationIndex: Int) {
        var revisedItems: [Item] = store.getItem.map{ $0 }
        revisedItems.move(fromOffsets: indexes, toOffset: destinationIndex)
        for index in 0 ..< revisedItems.count {
            revisedItems[index].position = Int32(index)
            revisedItems.first?.shop?.objectWillChange.send()
        }
        print("move from \(indexes) to \(destinationIndex)") // PRINTING TEST
    }
    func backButton() -> some View {
        Button(action: { present.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left").font(.system(size: 16, weight: .regular))
        }
    }
    func selectAll() {
        print("selectAll function executed") // PRINTING TEST
        store.getItem.forEach({ $0.status = kOnListNotTaken })
    }
    func deselectAll() {
        print("deselectAll function executed") // PRINTING TEST
        store.getItem.forEach({ $0.status = kNotOnList })
    }
}

// MARK: - ITEMLISTROW

struct ItemListRow: View {
    
// MARK: - PROPERTIES
    @ObservedObject var item: Item
    @ObservedObject var theme = gThemeSettings
    @ObservedObject private var limitAmount = LimitAmount()
        
    var body: some View {
        HStack {
            Text(item.itemName).reusableTextItem(colorF: colorBlackWhite, size: 20)
                .onTapGesture {
                    withAnimation {
                        self.item.toggleSelected()
                        impactSoft.impactOccurred()
                        print("item added to List not taken") // PRINTING TEST
                    }}
            Spacer()
            
            TextField(item.itemAmount, text: $limitAmount.amount) // , onCommit: updateAmount
                .onChange(of: limitAmount.amount) {_ in
                    updateAmount()
                }
                .frame(maxWidth: 60)
                .multilineTextAlignment(.center)
            
            Image(systemName: item.status != kOnListNotTaken ? "circle" : "checkmark.circle.fill")
                .reusableSelectedImage(scale: .large, coloF: theme.mainColor)
                .onTapGesture {
                    withAnimation {
                        self.item.toggleSelected()
                        impactSoft.impactOccurred()
                        print("item added to List not taken") // PRINTING TEST
                }
            }
        }.frame(height: rowHeight)
    }
    func updateAmount() {
        if !item.itemAmount.isEmpty {
            item.amount = limitAmount.amount
            PersistentContainer.saveContext()
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
        datum.name = "Item56789/123456789/123456789/123456789/123456789/123456789/"
        datum.amount = "12345"
        data.addToItem(datum)
        return NavigationView {
            ItemList(store: data)
                .previewDevice("iPhone 8")
                .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
        }
    }
}
