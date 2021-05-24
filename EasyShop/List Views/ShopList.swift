import SwiftUI
import CoreData

struct ShopList: View {
    @FetchRequest(fetchRequest: Shop.allShops()) var allShops: FetchedResults<Shop>
    
    @ObservedObject var theme = gThemeSettings
    
    @State var name = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Section(header:
                    HStack(spacing: 0) {
// MARK: - Header
                       TextField(NSLocalizedString("new_shop", comment: "new shop here..."), text: $name)
                           .reusableTextField(height: rowHeight, color: colorWhiteBlack, fontSize: 20, alignment: .center, autocorrection: true)
                       Button(action: {
                        withAnimation {
                            newShop(name: name)
                            impactSoft.impactOccurred()
                        } } ) {
                            Image(systemName: "plus")
                                .reusableButtonImage(scale: .large, width: 50, height: 50, colorF: theme.mainColor, opacity: name.isEmpty ? 0.4 : 1.0)
                                }.disabled(name.isEmpty)
                            }.reusableHstack(radius: 5, stroke: 1, colorF: colorWhiteBlack, colorB: colorAccent)
                ) {
// MARK: - List
                    List {
                        ForEach(allShops) { s in
                            NavigationLink(destination: ItemList(store: s)) {
                                ShopListRow(store: s)
                            }
                        }
                        .onDelete(perform: deleteShop)
                        .onMove(perform: doMove)
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle(Text(NSLocalizedString("shops", comment: "Shops")), displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
                    }.disabled(allShops.count == 0)
                } // SC
            } // VS
        } // NV
        
        .accentColor(theme.mainColor)
        .onAppear { print("ShopList appears") }
        .onDisappear { print("ShopList disappers") }
    }
    // MARK: - Functions
    func newShop(name: String) {
        Shop.addNewShop(named: name)
        self.name = ""
        print("New Shop created")
    }
    func deleteShop(at offsets: IndexSet) {
        for index in offsets {
            Shop.delete(allShops[index])
        }
        PersistentContainer.saveContext()
        print("Shop deleted")
    }
    private func doMove(from indexes: IndexSet, to destinationIndex: Int) {
        var revisedItems: [Shop] = allShops.map{ $0 }
        revisedItems.move(fromOffsets: indexes, toOffset: destinationIndex)
        for index in 0 ..< revisedItems.count {
            revisedItems[index].position = Int32(index)
        }
        print("move from \(indexes) to \(destinationIndex)")
    }
}

// MARK: - SHOPLISTROW

struct ShopListRow: View {
    @ObservedObject var theme = gThemeSettings
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName) // Modifiers
                .reusableTextItem(colorF: store.hasItemsInCartNotYetTaken ? (theme.mainColor) : colorBlackWhite, size: 20)
//                .font(Font.system(size: 20))
//                .foregroundColor(store.hasItemsInCartNotYetTaken ? (theme.mainColor) : colorBlackWhite)
            Spacer()
        }
        .frame(height: rowHeight)
        .onReceive(self.store.objectWillChange) {
            PersistentContainer.saveContext()
        }
    }
}

// MARK: - PREVIEWS

struct ShopList_Previews: PreviewProvider {
    static var previews: some View {
        ShopList().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}



/*
 BACKUP

 NavigationView {
     VStack(spacing: 0) {
         Section(header:
             HStack(spacing: 0) {
// MARK: - Header
                TextField(NSLocalizedString("new_shop", comment: ""), text: $name)
                    .reusableTextField(height: rowHeight, color: colorWhiteBlack, fontSize: 20, alignment: .center, autocorrection: true)
                Button(action: {
                     newShop(name: name)
                     impactSoft.impactOccurred()
                }) {
                     Image(systemName: "plus")
                         .reusableButtonImage(scale: .large, width: 50, height: 50, colorF: theme.mainColor, colorB: colorWhiteBlack)
                         .opacity(name.isEmpty ? 0.4 : 1.0)
                         }.disabled(name.isEmpty)
                     }.reusableHstack(radius: 5, stroke: 1, colorF: colorWhiteBlack, colorB: colorAccent)
                     //.modifier(customHStack())
         ) {
// MARK: - List
             List {
                 ForEach(allShops) { s in
                     NavigationLink(destination: ItemList(store: s)) {
                         ShopListRow(store: s)
                     }
                 }
                 .onDelete(perform: deleteShop)
                 .onMove(perform: doMove).animation(.default)
             }
             .listStyle(GroupedListStyle())
             .navigationBarTitle(Text(NSLocalizedString("shops", comment: "")), displayMode: .inline)
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
             }.disabled(allShops.count == 0)
         }
     } // VS
 } // NV
 
 PLAN B
 
 NavigationView {
     List {
         Section(header:
             HStack(spacing: 0) {
// MARK: - Header
                TextField(NSLocalizedString("new_shop", comment: ""), text: $name)
                    .reusableTextField(height: rowHeight, color: colorWhiteBlack, fontSize: 20, alignment: .center, autocorrection: true)
                Button(action: {
                     newShop(name: name)
                     impactSoft.impactOccurred()
                }) {
                     Image(systemName: "plus")
                         .reusableButtonImage(scale: .large, width: 50, height: 50, colorF: theme.mainColor, colorB: colorWhiteBlack)
                         .opacity(name.isEmpty ? 0.4 : 1.0)
                         }.disabled(name.isEmpty)
                     }.reusableHstack(radius: 5, stroke: 1, colorF: colorWhiteBlack, colorB: colorAccent)
                     //.modifier(customHStack())
         ) {
// MARK: - List
             
                 ForEach(allShops) { s in
                     NavigationLink(destination: ItemList(store: s)) {
                         ShopListRow(store: s)
                     }
                 }
                 .onDelete(perform: deleteShop)
                 .onMove(perform: doMove).animation(.default)
         }

     }
     .listStyle(GroupedListStyle())
     .navigationBarTitle(Text(NSLocalizedString("shops", comment: "")), displayMode: .inline)
     .toolbar {
         ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
     
 }.disabled(allShops.count == 0)
 } // NV
 */
