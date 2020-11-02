import SwiftUI
import CoreData

struct SelectedShopView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Shop.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Shop.select, ascending: false)],
        predicate: NSPredicate(format: "select == %@", NSNumber(value: true))
    ) var selectedShops: FetchedResults<Shop>
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedShops.count == 0 {
                    EmptyList().padding(.top, 50)
                }
                List {
                    ForEach(selectedShops, id:\.self) { s in
                        NavigationLink(destination: SelectedItemView(store: s)) {
                            HStack {
                                Text(s.shopName).id(UUID())
                                    .font(Font.system(size: 20))
                                    .padding(.leading, 20)
                                Spacer()
                            }
                           // .frame(width: .infinity, height: 50)
                        }
                    }
                }.listStyle(GroupedListStyle())
            }
            .navigationTitle("Shops")
        }
    }
}

struct SelectedShopView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedShopView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}

struct EmptyList: View {
    var body: some View {
        VStack {
            Text("Start from the list of Shops")
            Image(systemName: "tray.and.arrow.down.fill")
                .resizable()
                .frame(width: 200, height: 200)
        }.foregroundColor(Color("tint")).opacity(0.8)
    }
}
