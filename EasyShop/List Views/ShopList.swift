import SwiftUI
import CoreData

var rowHeight: CGFloat = 50

struct ShopList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest( //DMG3
        entity: Shop.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    private var shops: FetchedResults<Shop>
    @State var name = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Section {
                    HStack(spacing: 0) {
                        TextField("new Shop here...", text: $name)
                            .frame(height: rowHeight)
                            .background(Color("wb"))
                            .font(Font.system(size: 20))
                            .multilineTextAlignment(.center)
                            .disableAutocorrection(true)
                            .keyboardType(UIKeyboardType.default)
                        Button(action: { newShop(name: name) }) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("tint"))
                                .opacity(name.isEmpty ? 0.4 : 1.0)
                                .background(Color("wb"))
                        }.disabled(name.isEmpty)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color("wb")))
                    .padding()
                    .background(Color("accent"))
                } // SE
                Section {
                    List {
                        ForEach(shops) { s in
                            NavigationLink(destination: ItemList(store: s)) {
                                ShopListRow(store: s)
                            }
                        }.onDelete(perform: deleteShop)
                    } // LS
                    .listStyle(GroupedListStyle())
                    .navigationTitle("Shops")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }.accentColor(Color("tint"))
    }
    func newShop(name: String) {
        Shop.addNewShop(named: name)
        self.name = ""
    }
    func deleteShop(at offsets: IndexSet) {
        for index in offsets {
            self.moc.delete(self.shops[index])
        }
        PersistentContainer.saveContext()
    }
}

// MARK: - SHOP ROW

struct ShopListRow: View {//DMG4
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName)
                .foregroundColor(store.hasItemsInCartNotYetTaken ? Color("tint") : Color("bw"))
                .font(Font.system(size: 28))
                .padding(.leading, 20)
            Spacer()
//            if store.hasItemsInCartNotYetTaken {
//                Image(systemName: "checkmark")
//                    .imageScale(.large)
//                    .foregroundColor(Color("tint"))
//                    .padding(.leading, 10)
//            }
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

// MARK: - Modifiers

struct customText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("bw"))
            .font(Font.system(size: 28))
            .padding(.leading, 20)
    }
} // .modifier(customText())

//DMG3 -- use a simple, direct fetch request here.
//DMG4 -- no need for @Environment(\.managedObjectContext) var moc
