import SwiftUI
import CoreData

struct SelectedItemView: View {
    @ObservedObject var store: Shop
    
    var body: some View {
        Form {
            if store.getItem.filter({ $0.select && !$0.taken }).count > 0 {
                Section(header: Text("Items Remaining")) {
                    ForEach(store.getItem.filter({ $0.select && !$0.taken })) { s in
                        SelectedTakenRow(item: s)
                    } // s
                }
            }
            if store.getItem.filter({ !$0.select && $0.taken }).count > 0 {
                Section(header: Text("Items Taken")) {
                    ForEach(store.getItem.filter({ !$0.select && $0.taken })) { k in
                        SelectedTakenRow(item: k)
                    } // k
                }
            }
        }.navigationBarTitle("Products", displayMode: .inline)
    }
}

// MARK: - SELECTED-TAKEN-ROW

struct SelectedTakenRow: View {
    @ObservedObject var item: Item
    var body: some View {
        HStack {
            Text(item.itemName)
                .font(Font.system(size: 26))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: item.taken ? "cart.fill" : "cart.badge.plus")
                .font(.system(size: 35))
                .foregroundColor(item.taken ? .green : .red)
        }.frame(height: rowHeight)
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            self.item.taken.toggle()
            self.item.select.toggle()
            item.shop?.objectWillChange.send()
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

