import SwiftUI
import CoreData

// MARK: - SHOP ROW

struct ShopListRow: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    var body: some View {
        HStack {
            Text(store.shopName)
                .font(Font.system(size: 30))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: self.store.select ? "checkmark.square.fill" : "checkmark.square")
                .onTapGesture {  self.store.select.toggle()  }
                .padding(.trailing, 50)
        }
        .onReceive(self.store.objectWillChange) { PersistentContainer.saveContext() }
        .frame(width: .infinity, height: 80)
        .background(Color("rowcolor"))
        .cornerRadius(20)
    }
}

// MARK: - ITEM ROW

struct ItemListRow: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var item: Item
//    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(item.itemName)
                .font(Font.system(size: 30))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: self.item.select ? "checkmark.square.fill" : "checkmark.square")
                .onTapGesture {
                    self.item.select.toggle()
//                    self.store.select.toggle()
                }
                .padding(.trailing, 50)
        }
        .onReceive(self.item.objectWillChange) { PersistentContainer.saveContext() }
//        .onReceive(self.store.objectWillChange) { PersistentContainer.saveContext() }
        .frame(width: .infinity, height: 80)
        .background(Color("rowcolor"))
        .cornerRadius(20)
    }
}

// MARK: - PREVIEWS

struct ShopListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Carrefour"
        return ShopListRow(store: data).previewLayout(.sizeThatFits)
    }
}

struct ItemListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
//        let data = Shop(context: moc)
//        data.name = "Carrefour"
        let datum = Item(context: moc)
        datum.name = "Pollo"
        return ItemListRow(item: datum).previewLayout(.sizeThatFits)//, store: data
    }
}
