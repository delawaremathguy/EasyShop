import SwiftUI
import CoreData

struct SelectedItemView: View {
    @FetchRequest(fetchRequest: Item.takenShops()) var takenShops: FetchedResults<Item>
    @ObservedObject var store: Shop

    var body: some View {
        VStack {
            Group {
                List {
                    ForEach(store.getItem.filter({ $0.select })) { s in
                         SelectedItemRow(item: s)
                    } // s
                }.listStyle(GroupedListStyle())
            } // GR
            Drawingaline()
            Group {
                List {
                    ForEach(takenShops) { k in
                        TakenItemRow(item: k)
                    } // k
                }
            } // GR
        }.navigationBarTitle(("Products"), displayMode: .inline)
    }
}

// MARK: - SELECTED-ITEM-ROW

struct SelectedItemRow: View {
    
    @ObservedObject var item: Item
    
    var body: some View {
        HStack {
            Text(item.itemName)
                .font(Font.system(size: 26))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: "cart.badge.plus")
                .font(.system(size: 35))
                .foregroundColor(.red)

        }.frame(height: rowHeight)
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            self.item.taken.toggle()
            self.item.select.toggle()
        }
    }
}

// MARK: - TAKEN-ITEM-ROW

struct TakenItemRow: View {
    @ObservedObject var item: Item
    
    var body: some View {
        HStack {
            Text(item.itemName)
                .font(Font.system(size: 26))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: "cart.fill")
                .font(.system(size: 35))
                .foregroundColor(.green)
        }.frame(height: rowHeight)
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            self.item.taken.toggle()
            self.item.select.toggle()
        }
    }
}
// MARK: - DRAWING A LINE

struct Drawingaline: View {
    var body: some View {
        VStack {
            Rectangle().frame(minWidth: 0, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
            Text("Items taken")
            Rectangle().frame(minWidth: 0, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
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
struct TakenItemRow_Preview: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let datum = Item(context: moc)
        datum.name = "Bread"
        return TakenItemRow(item: datum)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
struct Drawingaline_Previews: PreviewProvider {
    static var previews: some View {
        Drawingaline()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
