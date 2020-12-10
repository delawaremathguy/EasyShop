import SwiftUI
import CoreData

var rowHeight: CGFloat = 50

struct ShopList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Shop.allShops()) var allShops: FetchedResults<Shop>
    
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
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
                            }.onDelete(perform: deleteShop)
                        }
                    } // LS
                    .listStyle(GroupedListStyle())
                    .navigationTitle("Shops")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }.accentColor(themes[self.theme.themeSettings].mainColor)
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
            self.moc.delete(self.allShops[index])
        }
        PersistentContainer.saveContext()
        print("Shop deleted")
    }
}

// MARK: - SHOP ROW

struct ShopListRow: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName)
                .foregroundColor(store.hasItemsInCartNotYetTaken ? (themes[self.theme.themeSettings].mainColor) : Color("ColorBlackWhite"))
                .font(Font.system(size: 28))
                .padding(.leading, 20)
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


