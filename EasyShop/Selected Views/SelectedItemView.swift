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
// MARK: - List
            Group {
                if layoutView {
                    HStack(spacing: 0) {
                        List {
                            Section(header: Text("Remaining")) {
                                ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                                    SelectedTakenImage(item: s).listRowInsets(EdgeInsets())
                                }
                            }.textCase(nil)
                        }
                        Divider().background(theme.mainColor)
                        List {
                            Section(header: Text("Taken")) {
                                ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                                    SelectedTakenImage(item: k).listRowInsets(EdgeInsets())
                                }
                            }.textCase(nil)
                        }
                    }
                } else {
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
                }
            }
// MARK: - Footer
            Rectangle()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
            HStack {
                Button(action: { clearAll()  }) {
                    Text("Clear all").padding(.trailing)
                }.disabled((store.getItem.filter({ $0.status == kOnListAndTaken }).count == 0) == true)
                Spacer()
                Button(action: { takeAll()  }) {
                    Text("Take all").padding(.leading)
                }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
            }.padding(.bottom, 5)
        }
        .navigationTitle("\(store.shopName)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
// MARK: - Toolbar
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { present.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .padding(.horizontal)
                        .font(.system(size: 20, weight: .regular))
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.switchButton.toggle()
                    self.layoutView.toggle()
                }) {
                    Image(switchButton ? "viewswitch1" : "viewswitch2")
                }
            }
        }
        .onAppear { print("SelectedItemView appears") }
        .onDisappear { print("SelectedItemView disappers") }
    }
// MARK: - Functions
    func takeAll() {
        print("takeAll function executed")
        for item in store.getItem {
            if item.status == kOnListNotTaken {
                item.status = kOnListAndTaken
            }
        }
    }
    func clearAll() {
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
            Text(item.itemName).modifier(customItemText())
            Spacer()
            Image(systemName: (item.status == kOnListAndTaken) ? "cart.fill" : "cart.badge.plus")
                .font(.system(size: 28))
                .foregroundColor((item.status == kOnListAndTaken) ? .green : .red)
        }
        .padding(.horizontal, 5)
        .frame(height: rowHeight)
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

struct SelectedTakenImage: View {
    @ObservedObject var item: Item
    var body: some View {
        HStack {
            Text(item.itemName).modifier(customItemText())
            Spacer()
            Image(systemName: (item.status == kOnListAndTaken) ? "cart.fill" : "cart.badge.plus")
                .font(.system(size: 20))
                .foregroundColor((item.status == kOnListAndTaken) ? .green : .red)
        }
        .padding(.horizontal, 5)
        .frame(height: rowHeight)
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
