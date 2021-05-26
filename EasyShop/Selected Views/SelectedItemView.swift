import SwiftUI
import CoreData

struct SelectedItemView: View {
    @Environment(\.presentationMode) var present
    
    @ObservedObject var store: Shop
    @ObservedObject var theme = gThemeSettings
    
    @State private var layoutView = false
    
    var body: some View {
        VStack {
// MARK: - List // Navigating back and forth dismiss the selected view style, from columns to list!!!
            Group {
                if layoutView {
                    HStack(spacing: 0) {
                        List {
                            Section(header: Text(NSLocalizedString("remaining", comment: "remaining products"))) {
                                ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                                    SelectedTakenImage(item: s).listRowInsets(EdgeInsets())
                                }
                            }.textCase(nil)
                        }
                        Divider().background(theme.mainColor)
                        List {
                            Section(header: Text(NSLocalizedString("taken", comment: "taken products"))) {
                                ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                                    SelectedTakenImage(item: k).listRowInsets(EdgeInsets())
                                }
                            }.textCase(nil)
                        }
                    }
                } else {
                    List {
                        Section(header: Text(NSLocalizedString("remaining", comment: "remaining products"))) {
                            ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                                SelectedTakenImage(item: s)
                            }
                        }.textCase(nil)
                    }
                    List {
                        Section(header: Text(NSLocalizedString("taken", comment: "taken products"))) {
                            ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                                SelectedTakenImage(item: k)
                            }
                        }.textCase(nil)
                    }
                }
            }
// MARK: - Footer
            InfinitLine()
            HStack {
                Button(action: {
                        withAnimation {
                            clearAll()
                            impactHeavy.impactOccurred()
                        }}) {
                    Text(NSLocalizedString("clear_all", comment: ""))
                }.disabled((store.getItem.filter({ $0.status == kOnListAndTaken }).count == 0) == true)
                Spacer()
                Button(action: {
                        withAnimation {
                            takeAll()
                            impactMedium.impactOccurred()
                        }}) {
                    Text(NSLocalizedString("take_all", comment: ""))
                }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
            }.padding([.horizontal, .bottom], 10)
        }
        .navigationBarTitle("\(store.shopName)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
// MARK: - Toolbar
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: backButton)
            ToolbarItem(placement: .navigationBarTrailing, content: switchView)
        }
        .onAppear { print("SelectedItemView appears") }
        .onDisappear { print("SelectedItemView disappers") }
    }
// MARK: - Functions
    func backButton() -> some View {
        Button(action: {
            present.wrappedValue.dismiss()
            print("Navigating Back")
        }) {
            Image(systemName: "chevron.left")
        }
    }
    func switchView() -> some View {
        Button(action: {
            withAnimation() {
            self.layoutView.toggle()
            }
            print("switching View")
        }) {
            Image(layoutView ? "arrow1" : "arrow2").animation(.default)
        }
    }
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
        if store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0 { 
            present.wrappedValue.dismiss()
        }
    }
}
// MARK: - SELECTED-TAKEN

struct SelectedTakenImage: View {
    @ObservedObject var item: Item
    var body: some View {
        HStack {
            Text(item.itemName).reusableText(colorF: colorBlackWhite, size: 20, place: .horizontal, padding: 10)
            Spacer()
        }
        .reusableTakenImage(place: .horizontal, padding: 5, height: rowHeight, shape: Rectangle())
//        .padding(.horizontal, 5) // modifier
//        .frame(height: rowHeight)
//        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            if item.status == kOnListNotTaken {
                item.status = kOnListAndTaken
                print("item added on taken list")
            } else {
                item.status = kOnListNotTaken
                print("item added on not taken list")
            }
            impactSoft.impactOccurred()
        }
    }
}

// MARK: - PREVIEW

struct SelectedItemView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "K-Mart"
        let datum = Item(context: moc)
        datum.name = "Eggs"
        datum.status = kOnListNotTaken
        data.addToItem(datum)
        return
            SelectedItemView(store: data)
                .previewDevice("iPhone 8")
                .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)

    }
}

/*
 Image(systemName: (item.status == kOnListAndTaken) ? "cart.fill" : "cart.badge.plus")
     .font(.system(size: 20))
     .foregroundColor((item.status == kOnListAndTaken) ? .green : .red)
 */
