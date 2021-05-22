import SwiftUI
import CoreData

struct ItemList: View {
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
                        .reusableTextField(height: rowHeight, color: colorWhiteBlack, fontSize: 20, alignment: .center, autocorrection: true)
                    Button(action: { // animation
                        newItem()
                        impactSoft.impactOccurred()
                    }) {
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
                    Button(action: { // animation
                        deselectAll()
                        impactMedium.impactOccurred()
                    }) {
                        Text(NSLocalizedString("deselet_all", comment: "")).padding(.leading, 12)
                    }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
                    Spacer()
                    Button(action: { // animation
                        selectAll()
                        impactMedium.impactOccurred()
                    }) {
                        Text(NSLocalizedString("select_all", comment: "")).padding(.trailing, 12)
                    }.disabled((store.getItem.filter({ $0.status == kNotOnList }).count == 0) == true)
                }.padding(.vertical, 10) // horizontal padding 12?
            } // SC
        } // VS
        
// MARK: - MODIFIERS
        .navigationBarTitle("\(store.shopName)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction, content: backButton)
            ToolbarItem(placement: .navigationBarTrailing) { EditButton().disabled(store.getItem.count == 0) }
        }
        .onAppear { print("ItemList appears") }
        .onDisappear { print("ItemList disappers") }
    }
    
// MARK: - FUNCTIONS
    func newItem() { // animation
        Item.addNewItem(named: name, to: store)
        self.name = ""
        print("New Item created")
    }
    func deleteItem(at offsets: IndexSet) { // animation
        let items = store.getItem
        offsets.forEach({ Item.delete( items[$0] )})
        print("Item deleted")
    }
    private func doMove(from indexes: IndexSet, to destinationIndex: Int) { // animation
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
    func selectAll() { // animation
        print("selectAll function executed")
        store.getItem.forEach({ $0.status = kOnListNotTaken })
    }
    func deselectAll() { // animation
        print("deselectAll function executed")
        store.getItem.forEach({ $0.status = kNotOnList })
    }
}

// MARK: - ITEMLISTROW

struct ItemListRow: View {
    @ObservedObject var item: Item
    @ObservedObject var theme = gThemeSettings
    
    var body: some View {
        Button(action: { // animation
            self.item.toggleSelected()
            impactSoft.impactOccurred()
            print("item added to List not taken")
        }) {
            HStack {
                Text(item.itemName).reusableTextItem(colorF: colorBlackWhite, size: 20)
                Spacer()
                Image(systemName: item.status != kOnListNotTaken ? "circle" : "checkmark.circle.fill")
                    .imageScale(.large) // modifiers
                    .foregroundColor(theme.mainColor)
            }.frame(height: rowHeight)
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
        return NavigationView {
            ItemList(store: data)
                .previewDevice("iPhone 8")
                .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
        }
    }
}

/*
 BACKUP
 
 var body: some View {
     VStack(spacing: 0) {
         Section {
             HStack(spacing: 0) {
// MARK: - Header
                 Text("\(store.getItem.filter({ $0.status == kOnListNotTaken }).count)")
                     .frame(minWidth: 45, maxWidth: 55)
                 TextField(NSLocalizedString("new_product", comment: ""), text: $name)
                     .reusableTextField(height: rowHeight, color: colorWhiteBlack, fontSize: 20, alignment: .center, autocorrection: true)
                 Button(action: {
                     newItem()
                     impactSoft.impactOccurred()
                 }) {
                     Image(systemName: "plus")
                         .reusableButtonImage(scale: .large, width: 50, height: 50, colorF: theme.mainColor, colorB: colorWhiteBlack)
                         .opacity(name.isEmpty ? 0.4 : 1.0)
                 }.disabled(name.isEmpty)
             }
             .reusableHstack(radius: 5, stroke: 1, colorF: colorWhiteBlack, colorB: colorAccent)
             //.modifier(customHStack())
         }
// MARK: - Footer
         Section {
             HStack {
                 Button(action: {
                     deselectAll()
                     impactMedium.impactOccurred()
                 }) {
                     Text(NSLocalizedString("deselet_all", comment: "")).padding(.leading, 12)
                 }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
                 Spacer()
                 Button(action: {
                     selectAll()
                     impactMedium.impactOccurred()
                 }) {
                     Text(NSLocalizedString("select_all", comment: "")).padding(.trailing, 12)
                 }.disabled((store.getItem.filter({ $0.status == kNotOnList }).count == 0) == true)
             }.padding(.vertical, 10)
         InfinitLine()
         }
// MARK: - List
         Section {
             List {
                 ForEach(store.getItem) { s in
                     ItemListRow(item: s)
                 } // FE
                 .onDelete(perform: deleteItem)
                 .onMove(perform: doMove).animation(.default)
             }.listStyle(GroupedListStyle()) // LS
         } // SC
     }
     .navigationBarTitle("\(store.shopName)", displayMode: .inline)
     .navigationBarBackButtonHidden(true)
// MARK: - Toolbar
     .toolbar {
         ToolbarItem(placement: .cancellationAction, content: backButton)
         ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
     }.disabled(store.getItem.count == 0)
     .onAppear { print("ItemList appears") }
     .onDisappear { print("ItemList disappers") }
 }
 
 PLAN B
 
 var body: some View {
     VStack(spacing: 0) {
         Section {
             HStack(spacing: 0) {
// MARK: - Header
                 Text("\(store.getItem.filter({ $0.status == kOnListNotTaken }).count)")
                     .frame(minWidth: 45, maxWidth: 55)
                 TextField(NSLocalizedString("new_product", comment: ""), text: $name)
                     .reusableTextField(height: rowHeight, color: colorWhiteBlack, fontSize: 20, alignment: .center, autocorrection: true)
                 Button(action: {
                     newItem()
                     impactSoft.impactOccurred()
                 }) {
                     Image(systemName: "plus")
                         .reusableButtonImage(scale: .large, width: 50, height: 50, colorF: theme.mainColor, colorB: colorWhiteBlack)
                         .opacity(name.isEmpty ? 0.4 : 1.0)
                 }.disabled(name.isEmpty)
             }
             .reusableHstack(radius: 5, stroke: 1, colorF: colorWhiteBlack, colorB: colorAccent)
         }

// MARK: - List
         Section {
             List {
                 ForEach(store.getItem) { s in
                     ItemListRow(item: s)
                 }
                 .onDelete(perform: deleteItem)
                 .onMove(perform: doMove)
             }.listStyle(GroupedListStyle())
         } // SC
         
// MARK: - Footer
         Section {
             InfinitLine()
             HStack {
                 Button(action: {
                     deselectAll()
                     impactMedium.impactOccurred()
                 }) {
                     Text(NSLocalizedString("deselet_all", comment: "")).padding(.leading, 12)
                 }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
                 Spacer()
                 Button(action: {
                     selectAll()
                     impactMedium.impactOccurred()
                 }) {
                     Text(NSLocalizedString("select_all", comment: "")).padding(.trailing, 12)
                 }.disabled((store.getItem.filter({ $0.status == kNotOnList }).count == 0) == true)
             }.padding(.vertical, 10)
             
         } // SC
     } // VS
// MARK: - Modifiers
         .navigationBarTitle("\(store.shopName)", displayMode: .inline)
         .navigationBarBackButtonHidden(true)
         .toolbar {
             ToolbarItem(placement: .cancellationAction, content: backButton)
             ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
         }.disabled(store.getItem.count == 0)
         .onAppear { print("ItemList appears") }
         .onDisappear { print("ItemList disappers") }
     
 } // BO
 */


