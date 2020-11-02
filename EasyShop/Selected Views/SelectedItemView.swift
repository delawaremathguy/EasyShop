import SwiftUI
import CoreData

struct SelectedItemView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.select, ascending: false)],
        predicate: NSPredicate(format: "select == %@", NSNumber(value: true))
    ) var selectedItems: FetchedResults<Item>
    @ObservedObject var store: Shop
    
    var body: some View {
        VStack {
            List {
                ForEach(store.getItem) { s in
                    Text(s.itemName)
                        .font(Font.system(size: 20))
                        .padding(.leading, 20)
                }
            }.listStyle(GroupedListStyle())
        }.navigationTitle("Products")
    }
}

struct SelectedItemView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Carrefour"
        let datum = Item(context: moc)
        datum.name = "Chicken"
        data.addToItem(datum)
        return SelectedItemView(store: data)
    }
}
