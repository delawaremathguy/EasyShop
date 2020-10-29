/*
Shop - shopName /// Item - itemName -> getItem
*/
import SwiftUI
import CoreData

struct ShopList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Shop.entity(),
        sortDescriptors: []
    ) var shops: FetchedResults<Shop>
    @State var name = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        TextField("name of the shop", text: self.$name).modifier(customTextfield())
                        Button(action: { newShop()  }) {
                            Image(systemName: "plus")
                                .frame(width: 40, height: 40)
                        }.disabled(name.isEmpty)
                    }
                }
                Section {
                    ForEach(shops, id: \.self) { s in
                        NavigationLink(destination: ItemList(store: s)) {
                            HStack {
                                Text(s.shopName)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(("Shops"), displayMode: .inline)
        }
    }
    
    func newShop() {
        withAnimation {
            let addShop = Shop(context: moc)
            addShop.name = self.name
            PersistentContainer.saveContext()
            self.name = ""
        }
    }
}

struct ShopList_Previews: PreviewProvider {
    static var previews: some View {
        ShopList().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
