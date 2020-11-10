import SwiftUI
import CoreData

struct SelectedShopView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Shop.selectedShops()) var selectedShops: FetchedResults<Shop>
    @FetchRequest(fetchRequest: Item.selectedItems()) var selectedItems: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(selectedShops, id:\.self) { s in
                        NavigationLink(destination: SelectedItemView(store: s)) {
                            HStack {
                                Text(s.shopName).id(UUID())
                                    .font(Font.system(size: 20))
                                    .padding(.leading, 20)
                                Spacer()
                            }.frame(height: rowHeight)
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

// MARK: - PREVIEWS

struct SelectedShopView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedShopView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
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
