import SwiftUI
import CoreData

var rowHeight: CGFloat = 50

struct ShopList: View {
    @FetchRequest(fetchRequest: Shop.allShops()) var allShops: FetchedResults<Shop>
    @ObservedObject var theme = gThemeSettings
    @State var name = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Section {
                    HStack(spacing: 0) {
// MARK: - Header
                        Button(action: { newShop(name: name) }) {
                            Image(systemName: "plus")
                                .modifier(customButton())
                                .opacity(name.isEmpty ? 0.4 : 1.0)
                                .background(Color("ColorWhiteBlack"))
                        }.disabled(name.isEmpty)
                        TextField("new shop here...", text: $name)
                            .modifier(customTextfield())
                        Text("\(allShops.count)").padding(15)
                    }.modifier(customHStack())
                } // SE
                Section {
// MARK: - LIST
                    List {
                        Section {
                            ForEach(allShops) { s in
                                NavigationLink(destination: ItemList(store: s)) {
                                    ShopListRow(store: s)
                                }
                            }
                            .onDelete(perform: deleteShop)
                            .onMove(perform: doMove)
                        }
                    } // LS
                    .listStyle(GroupedListStyle())
                    .navigationTitle("Shops")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: EditButton())
                }
            }
        }.accentColor(theme.mainColor)
        .onAppear { print("ShopList appears") }
        .onDisappear { print("ShopList disappers") }
    }
    // MARK: - FUNCTIONS
    func newShop(name: String) {
        Shop.addNewShop(named: name)
        self.name = ""
        print("New Shop created")
    }
    func deleteShop(at offsets: IndexSet) {
        for index in offsets {
            Shop.delete(allShops[index]) // DMG 6
        }
        PersistentContainer.saveContext()
        print("Shop deleted")
    }
    private func doMove(from indexes: IndexSet, to destinationIndex: Int) {
        let sourceIndex = indexes.first!
// let’s say for the moment we’ll only move the first item
// print out what we’re going to do in terms of what gets moved by index
        print("move from \(sourceIndex) to \(destinationIndex)")
// nothing to do if indices are the same.  this can happen: the user begins
// to drag, but then sort of drops it where she started.
        guard sourceIndex != destinationIndex else {
            return
        }
// more code to come here, once you decide what to do in CD
    }
}

// MARK: - SHOP ROW

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

struct ShopListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Whole Foods"
        return Group {
            ShopListRow(store: data)
                .padding()
                .previewLayout(.sizeThatFits)
            ShopListRow(store: data)
                .preferredColorScheme(.dark)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}


