import SwiftUI
import CoreData

struct SelectedItemView: View {
    
// MARK: - PROPERTIES
    @Environment(\.presentationMode) var present
    
    @ObservedObject var store: Shop
    @ObservedObject var theme = gThemeSettings
    
    @State private var layoutView = false
    
    var body: some View {
        VStack {
            
// MARK: - LIST
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
            
// MARK: - FOOTER
            InfinitLine()
            HStack {
                Button(action: {
                        withAnimation {
                            clearAll()
                            impactHeavy.impactOccurred()
                        }}) {
                    Text(NSLocalizedString("clear_all", comment: "delete all from list"))
                }.disabled((store.getItem.filter({ $0.status == kOnListAndTaken }).count == 0) == true)
                Spacer()
                Button(action: {
                        withAnimation {
                            takeAll()
                            impactMedium.impactOccurred()
                        }}) {
                    Text(NSLocalizedString("take_all", comment: "add all to list"))
                }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
            }.padding([.horizontal, .bottom], 10)
        }
        .onAppear(perform: navigateBack)
        
// MARK: - MODIFIERS
        .navigationBarTitle("\(store.shopName)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: backButton)
            ToolbarItem(placement: .navigationBarTrailing, content: switchView)
        }
        .onAppear { print("SelectedItemView appears") } // PRINTING TEST
        .onDisappear { print("SelectedItemView disappers") } // PRINTING TEST
    }
    
    
// MARK: - FUNCTIONS
    func backButton() -> some View {
        Button(action: {
            present.wrappedValue.dismiss()
            print("Navigating Back") // PRINTING TEST
        }) {
            Image(systemName: "chevron.left")
        }
    }
    func switchView() -> some View {
        Button(action: {
            withAnimation() {
            self.layoutView.toggle()
            }
            print("switching View") // PRINTING TEST
        }) {
            Image(layoutView ? "arrow1" : "arrow2").animation(.default)
        }
    }
    func takeAll() {
        print("takeAll function executed") // PRINTING TEST
        for item in store.getItem {
            if item.status == kOnListNotTaken {
                item.status = kOnListAndTaken
            }
        }
    }
    func clearAll() {
        print("clearAll function executed") // PRINTING TEST
        for item in store.getItem {
            if item.status == kOnListAndTaken {
                item.status = kNotOnList
            }
        }
        if store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0 { 
            present.wrappedValue.dismiss()
        }
    }
    func navigateBack() {
        if store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0 && store.getItem.filter({ $0.status == kOnListAndTaken }).count == 0 {
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
            Text(item.amount ?? "")
                .multilineTextAlignment(.trailing)
        }
        .reusableTakenImage(place: .horizontal, padding: 5, height: rowHeight, shape: Rectangle())
        .onTapGesture(count: 2) {
            if item.status == kOnListNotTaken {
                item.status = kOnListAndTaken
                print("item added on taken list") // PRINTING TEST
            } else {
                item.status = kOnListNotTaken
                print("item added on not taken list") // PRINTING TEST
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
        datum.amount = "6"
        datum.status = kOnListNotTaken
        data.addToItem(datum)
        return
                SelectedItemView(store: data)
                    .previewDevice("iPhone 8")
                    .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
