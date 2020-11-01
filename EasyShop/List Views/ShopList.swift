import SwiftUI
import CoreData

struct ShopList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Shop.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Shop.order, ascending: true)]
    ) var shops: FetchedResults<Shop>
    @State var name = ""
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(shops, id: \.self) { s in
                    NavigationLink(destination: ItemList(store: s)) {
                        ShopListRow(store: s).id(UUID())
                    }
                }.onDelete(perform: deleteShop)
            }
            .sheet(isPresented: $isPresented) { ShopListModal { name in
                    self.newShop(name: name)
                    self.isPresented = false
                }
            }
            .navigationBarTitle(("Shops"), displayMode: .inline)
            .navigationBarItems(trailing:
                    Button(action: { self.isPresented.toggle() }) {
                          Image(systemName: "plus")
                               .imageScale(.large)
                               .frame(width: 40, height: 40)
            })
        }.accentColor(Color("tint"))
    }
    func newShop(name: String) {
//       withAnimation {
            let addShop = Shop(context: moc)
            addShop.name = name
            addShop.order = (shops.last?.order ?? 0) + 1
            addShop.select = false
            PersistentContainer.saveContext()
         // self.name = ""
//        }
    }
    func deleteShop(at offsets: IndexSet) {
//        withAnimation {
            for index in offsets {
                self.moc.delete(self.shops[index])
            }
            PersistentContainer.saveContext()
//        }
    }
}

// MARK: - PREVIEWS

struct ShopList_Previews: PreviewProvider {
    static var previews: some View {
       ShopList().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}


