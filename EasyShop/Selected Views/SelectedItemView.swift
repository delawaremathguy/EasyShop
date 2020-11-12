import SwiftUI
import CoreData

struct SelectedItemView: View {
    
    @ObservedObject var store: Shop
    
    
    var body: some View {
        VStack {
            List {
                ForEach(store.getItem.filter({ $0.select })) { s in
                     SelectedItemRow(item: s)
                }
            }.listStyle(GroupedListStyle())
        }.navigationBarTitle(("Products"), displayMode: .inline)
    }
}

// MARK: - SELECTEDITEMROW

struct SelectedItemRow: View {

    @ObservedObject var item: Item
    @State private var hasDoubleTapped = false
    
    var body: some View {
        HStack {
            Text(item.itemName)
                .font(Font.system(size: 26))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: hasDoubleTapped ? "cart.fill" : "cart.badge.plus")
                .font(.system(size: 35))
                .foregroundColor(Color("tint"))

        }.frame(height: rowHeight)
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            self.hasDoubleTapped.toggle()
        }
    }
}


// MARK: - PREVIEWS

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

struct SelectedItemRow_Preview: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let datum = Item(context: moc)
        datum.name = "Chicken"
        return SelectedItemRow(item: datum)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
