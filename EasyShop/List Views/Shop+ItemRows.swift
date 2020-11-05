import SwiftUI
import CoreData

// MARK: - SHOP ROW

struct ShopListRow: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var store: Shop
    var body: some View {
        HStack {
            Image(systemName: self.store.select ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundColor(Color("tint"))
                .onTapGesture { self.store.select.toggle() }
                .padding(.leading, 10)
            Text(store.shopName)
                .font(Font.system(size: 20))
                .padding(.leading, 20)
            Spacer()
        }.frame(height: rowHeight)
        .onReceive(self.store.objectWillChange) { PersistentContainer.saveContext() }
    }
}

// MARK: - ITEM ROW

struct ItemListRow: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var item: Item
    var body: some View {
        HStack {
            Image(systemName: self.item.select ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundColor(Color("tint"))
                
                .padding(.leading, 10)
            Text(item.itemName)
                .font(Font.system(size: 20))
                .padding(.leading, 20)
            Spacer()
        }.frame(height: rowHeight)
        .onTapGesture { self.item.select.toggle() }
        .onReceive(self.item.objectWillChange) { PersistentContainer.saveContext() }
    }
}

// MARK: - PREVIEWS

struct ShopListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Whole Foods"
        return ShopListRow(store: data).previewLayout(.sizeThatFits)
    }
}

struct ItemListRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let datum = Item(context: moc)
        datum.name = "Chicken"
        return ItemListRow(item: datum).previewLayout(.sizeThatFits)//, store: data
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        ShopList().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
