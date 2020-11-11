import SwiftUI
import CoreData

struct SelectedShopView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Shop.selectedShops()) var selectedShops: FetchedResults<Shop>
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(selectedShops, id:\.self) { s in
                        NavigationLink(destination: SelectedItemView(store: s)) {
                            SelectedShopRow(store: s)
                        }
                    }
                }.listStyle(GroupedListStyle())
                if selectedShops.count == 0 {
                    EmptySelectedShop()
                }
            }
            .navigationTitle("Shops")
        }
    }
}

// MARK: - SELECTEDSHOP

struct SelectedShopRow: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName)
                .font(Font.system(size: 28))
                .padding(.leading, 20)
            Spacer()
        }.frame(height: rowHeight)
    }
}

// MARK: - PREVIEWS

struct SelectedShopView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedShopView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}

struct SelectedShopRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Whole Food"
        return SelectedShopRow(store: data)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - EmptySelectedShop

struct EmptySelectedShop: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Start from the List section!")
                Image(systemName: "tray.and.arrow.down.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
            }.foregroundColor(Color("tint")).opacity(0.8)
        }.edgesIgnoringSafeArea(.all)
    }
}
