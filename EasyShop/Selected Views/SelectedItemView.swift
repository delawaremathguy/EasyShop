import SwiftUI
import CoreData

struct SelectedItemView: View {
    @Environment(\.presentationMode) var present
    @ObservedObject var store: Shop
    @ObservedObject var theme = gThemeSettings
    @State private var layoutView = false
    @State private var switchButton = false
    
    var body: some View {
        VStack {
// MARK: - LIST
            Group {
                if layoutView {
                    List {
                        Section(header: Text("Remaining")) {
                            ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                                SelectedTakenRow(item: s)
                            }
                        }.textCase(nil)
                    }
                    List {
                        Section(header: Text("Taken")) {
                            ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                                SelectedTakenRow(item: k)
                            }
                        }.textCase(nil)
                    }
                } else {
                    HStack(spacing: 0) {
                        List {
                            Section(header: Text("Remaining")) {
                                ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                                    SelectedTakenRow(item: s)
                                }
                            }.textCase(nil)
                        }
                        Divider().background(theme.mainColor)
                        List {
                            Section(header: Text("Taken")) {
                                ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                                    SelectedTakenRow(item: k)
                                }
                            }.textCase(nil)
                        }
                    }
                } // Else
            }
        }
        .navigationTitle("\(store.shopName)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
// MARK: - TOOLBAR
        .navigationBarItems(leading:
            HStack {
                Button(action: { present.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left").font(.system(size: 20, weight: .regular))
                } // Button 1
                Spacer()
                Button(action: {
                    self.switchButton.toggle()
                    self.layoutView.toggle()
                }) {
                    Image(systemName: switchButton ? "slider.vertical.3" : "slider.horizontal.3")
                        .font(.system(size: 20, weight: .regular))
                } // Button 2
            } // HS
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { clearAll() }) {
                    Text("Clear All")
                        .opacity(kOnListNotTaken != 0 ? 1.0 : 0.6)
                }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count != 0) == true)
            }
        }
        .onAppear { print("SelectedItemView appears") }
        .onDisappear { print("SelectedItemView disappers") }
    }
// MARK: - FUNCTIONS
    func clearAll() { // DMG 5 - clearAll() email
        print("clearAll function executed")
        for item in store.getItem {
            if item.status == kOnListAndTaken {
                item.status = kNotOnList
            }
        }
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
                .font(.system(size: 32))
                .foregroundColor((item.status == kOnListAndTaken) ? .green : .red)
        }.frame(height: rowHeight)
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            if item.status == kOnListNotTaken {
                item.status = kOnListAndTaken
                print("item added on taken list")
            } else {
                item.status = kOnListNotTaken
                print("item added on not taken list")
            }
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
