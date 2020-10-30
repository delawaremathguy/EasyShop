import SwiftUI
import CoreData

struct ShopListRow: View {
    let store: Shop
    var body: some View {
        HStack {
            Text(store.shopName)
                .font(Font.system(size: 30))
                .padding(.leading, 20)
            Spacer()
        }
        .frame(width: .infinity, height: 80)
        .background(Color("rowcolor"))
        .cornerRadius(20)
    }
}

struct ItemListRow: View {
    let item: Item
    var body: some View {
        HStack {
            Text(item.itemName)
                .font(Font.system(size: 30))
                .padding(.leading, 20)
            Spacer()
        }
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
        let datum = Item(context: moc)
        datum.name = "Pollo"
        return ItemListRow(item: datum).previewLayout(.sizeThatFits)
    }
}
