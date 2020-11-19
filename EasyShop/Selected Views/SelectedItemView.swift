import SwiftUI
import CoreData

struct SelectedItemView: View {
    @ObservedObject var store: Shop

    var body: some View {
         Form {
            if store.getItem.filter ({ $0.status == kOnListNotTaken }).count > 0 {
                Section(header: Text("Items Remaining")) {
                    ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                        SelectedTakenRow(item: s)
                    } // s
                }
            }
            if store.getItem.filter ({ $0.status == kOnListAndTaken }).count > 0 {
                Section(header: Text("Items Taken")) {
                    ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                        SelectedTakenRow(item: k)
                    } // k
                }
            }
        }
        .navigationBarTitle("Products", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            ClearAll()
        }) {
            Text("Clear All") // only visible when all items are taken
        })
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
                .font(Font.system(size: 26))
                .padding(.leading, 20)
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
            }
//DMG3 --
// this was moved to the Item class so that whenever you set the status of
// an item, it automatically does this for you.  the View should not be
// responsible for remembering that it has to do this whenever it changes
// the status of an item
// item.shop?.objectWillChange.send()
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
