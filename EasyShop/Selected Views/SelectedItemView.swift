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
                            Section(header: Text(NSLocalizedString("remaining", comment: ""))) {
                                ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                                    SelectedTakenImage(item: s).listRowInsets(EdgeInsets())
                                }
                            }.textCase(nil)
                        }
                        Divider().background(theme.mainColor)
                        List {
                            Section(header: Text(NSLocalizedString("taken", comment: ""))) {
                                ForEach(store.getItem.filter({ $0.status == kOnListAndTaken })) { k in
                                    SelectedTakenImage(item: k).listRowInsets(EdgeInsets())
                                }
                            }.textCase(nil)
                        }
                    }
                } else {
                    List {
                        Section(header: Text(NSLocalizedString("remaining", comment: ""))) {
                            ForEach(store.getItem.filter({ $0.status == kOnListNotTaken })) { s in
                                SelectedTakenImage(item: s)
                            }
                        }.textCase(nil)
                    }
                    List {
                        Section(header: Text(NSLocalizedString("taken", comment: ""))) {
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
                    clearAll()
                    impactHeavy.impactOccurred()
                }) {
                    Text(NSLocalizedString("clear_all", comment: "")).padding(.leading, 12)
                }.disabled((store.getItem.filter({ $0.status == kOnListAndTaken }).count == 0) == true)
                Spacer()
                Button(action: {
                    takeAll()
                    impactMedium.impactOccurred()
                }) {
                    Text(NSLocalizedString("take_all", comment: "")).padding(.trailing, 12)
                }.disabled((store.getItem.filter({ $0.status == kOnListNotTaken }).count == 0) == true)
            }.padding(.bottom, 10)
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
                .reusableChevron(place: .horizontal, size: 20, weight: .regular)
        }
    }
    func switchView() -> some View {
        Button(action: {
            withAnimation() {
            self.switchButton.toggle()
            self.layoutView.toggle()
            }
            print("switching View")
        }) {
            Image(switchButton ? "arrow1" : "arrow2")
        }.animation(.default)
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
            impactSoft.impactOccurred()
        }.animation(.easeOut(duration: 1.5))
    }
}
/*
 Image(systemName: (item.status == kOnListAndTaken) ? "cart.fill" : "cart.badge.plus")
     .font(.system(size: 20))
     .foregroundColor((item.status == kOnListAndTaken) ? .green : .red)
 */
