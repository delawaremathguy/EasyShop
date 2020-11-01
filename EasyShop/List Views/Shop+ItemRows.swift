import SwiftUI
import CoreData

// MARK: - SHOP ROW

struct ShopListRow: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    var body: some View {
        HStack {
            Text(store.shopName)
                .font(Font.system(size: 20))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: self.store.select ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundColor(.yellow)
                .onTapGesture {  self.store.select.toggle()  }
                .padding(.trailing, 30)
        }
        .onReceive(self.store.objectWillChange) { PersistentContainer.saveContext() }
        .frame(width: .infinity, height: 50)
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
                .font(Font.system(size: 20))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: self.item.select ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundColor(.yellow)
                .onTapGesture {
                    self.item.select.toggle()
//                    self.store.select.toggle()
                }
                .padding(.trailing, 30)
        }
        .onReceive(self.item.objectWillChange) { PersistentContainer.saveContext() }
//        .onReceive(self.store.objectWillChange) { PersistentContainer.saveContext() }
        .frame(width: .infinity, height: 50)
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

struct List_Previews: PreviewProvider {
    static var previews: some View {
        ShopList().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
