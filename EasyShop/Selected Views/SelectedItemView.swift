import SwiftUI
import CoreData

struct SelectedItemView: View {
    @ObservedObject var store: Shop

    var body: some View {
        Form {
            Section(header: Text("Items Remaining")) {
                ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                    SelectedTakenRow(item: s)
                }
            }
            Section(header: Text("Items Taken")) {
                ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                    SelectedTakenRow(item: k)
                }
            }
        }
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { ClearAll() }) {
                    Text("Clear All")
                }
            }
        }
    }
    func ClearAll() {
        // all items are taken. Then deselect them

    }
}

// MARK: - SELECTED-TAKEN-ROW

struct SelectedTakenRow: View {
    @ObservedObject var item: Item
    
    var body: some View {
        HStack {
            Text(item.itemName)
                .modifier(customText())
            Spacer()
            Image(systemName: (item.status == kOnListAndTaken) ? "cart.fill" : "cart.badge.plus")
                .font(.system(size: 35))
                .foregroundColor((item.status == kOnListAndTaken) ? .green : .red)
        }.frame(height: rowHeight)
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            if item.status == kOnListNotTaken {
                item.status = kOnListAndTaken
            } else {
                item.status = kOnListNotTaken
            }//DMG3 --
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

struct SelectedTakenRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let datum = Item(context: moc)
        datum.name = "Chicken"
        return SelectedTakenRow(item: datum)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

//DMG3 --
// this was moved to the Item class so that whenever you set the status of
// an item, it automatically does this for you.  the View should not be
// responsible for remembering that it has to do this whenever it changes
// the status of an item
// item.shop?.objectWillChange.send()
