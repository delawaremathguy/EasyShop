import SwiftUI
import CoreData

struct SelectedItemView: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @ObservedObject var store: Shop

    var body: some View {
        VStack {
            List {
                Section(header: Text("Items Remaining")) {
                    ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                        SelectedTakenRow(item: s)
                    }
                }
            }
            List {
                Section(header: Text("Items Taken")) {
                    ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                        SelectedTakenRow(item: k)
                    }
                }
            }
        }
        .navigationTitle("\(store.shopName)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { ClearAll() }) {
                    Text("Clear All")
                        .foregroundColor(themes[self.theme.themeSettings].mainColor)
                }
            }
        }
    }
    // MARK: - FUNCTIONS
    func ClearAll() {
//        var status0 = kNotOnList
//        var status1 = kOnListNotTaken
//        var status2 = kOnListAndTaken
//
//        if status2 != 0 && status1 == 0 {
//            status2 = status0
//        }
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
        return Group {
            SelectedTakenRow(item: datum)
                .padding()
                .previewLayout(.sizeThatFits)
            SelectedTakenRow(item: datum)
                .preferredColorScheme(.dark)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
