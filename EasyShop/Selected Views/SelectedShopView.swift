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
                List {
                    ForEach(selectedShops, id:\.self) { s in
                        NavigationLink(destination: SelectedItemView(store: s)) {
                            HStack {
                                Text(s.shopName).id(UUID())
                                    .font(Font.system(size: 30))
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            .frame(width: .infinity, height: 80)
                            .background(Color("rowcolor"))
                            .cornerRadius(20)
                        }
                    }
                }
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
