import SwiftUI
import CoreData

struct ShopList: View {
    @FetchRequest(fetchRequest: Shop.allShops()) var allShops: FetchedResults<Shop>
    @ObservedObject var theme = gThemeSettings
    @State var name = ""
    let hapticNew = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Section {
                    HStack(spacing: 0) {
// MARK: - Header
                        Button(action: {
                                newShop(name: name)
                            hapticNew.impactOccurred()
                        }) {
                            Image(systemName: "plus")
                                .modifier(customButton())
                                .opacity(name.isEmpty ? 0.4 : 1.0)
                                .background(Color("ColorWhiteBlack"))
                        }.disabled(name.isEmpty)
                        TextField(NSLocalizedString("new_shop", comment: ""), text: $name)
                            .modifier(customTextfield())
                        Text("\(allShops.count)").padding(15)
                    }.modifier(customHStack())
                }
                Section {
// MARK: - List
                    List {
                        Section {
                            ForEach(allShops) { s in
                                NavigationLink(destination: ItemList(store: s)) {
                                    ShopListRow(store: s)
                                }
                            }
                            .onDelete(perform: deleteShop)
                            .onMove(perform: doMove).animation(.default) // Animation Test
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .navigationTitle(Text(NSLocalizedString("shops", comment: "")))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
                    }.disabled(allShops.count == 0)
                }
            }
        }.accentColor(theme.mainColor)
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
            Text(store.shopName).modifier(customShopText())
                .foregroundColor(store.hasItemsInCartNotYetTaken ? (theme.mainColor) : Color("ColorBlackWhite"))
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



