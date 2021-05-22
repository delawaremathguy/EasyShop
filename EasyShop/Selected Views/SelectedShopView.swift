import SwiftUI
import CoreData

struct SelectedShopView: View {
    @FetchRequest(fetchRequest: Shop.allShops()) var allShops: FetchedResults<Shop>
    
    @ObservedObject var theme = gThemeSettings
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section(header:
                        HStack {
                            Spacer()
                            Text(NSLocalizedString("products_remaining", comment: "Remaining products")).opacity(allShops.count != 0 ? 1 : 0) // worth it?
                        }.textCase(nil) // textcase?
                    ) {
                        ForEach(allShops) { s in
                            ConditionalSelectedShopRow(store: s)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text(NSLocalizedString("shops", comment: "Shops")))
                if allShops.count == 0 {
                    EmptySelectedShop()
                }
            }
        }
        .accentColor(theme.mainColor)
        .onAppear { print("SelectedShopView appears") }
        .onDisappear { print("SelectedShopView disappers") }
    }
}

// MARK: - SELECTEDROW

struct SelectedShopRow: View {
    @ObservedObject var theme = gThemeSettings
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName) // modifier
                .font(Font.system(size: 20))
                .foregroundColor((store.countItemsInCart != 0) ? (theme.mainColor) : colorBlackWhite)
            Spacer() 
            Text("\(store.countItemsInCart)").font(.caption)
        }.frame(height: rowHeight)
    }
}

// MARK: - CONDITIONALSELECTEDSHOPROW

struct ConditionalSelectedShopRow: View {
    @ObservedObject var store: Shop
    var body: some View {
        if store.countItemsInCart == 0 {
            SelectedShopRow(store: store)
        } else {
            NavigationLink(destination:
                SelectedItemView(store: store)) {
                    SelectedShopRow(store: store)
            }
        }
    }
}

// MARK: - EMPTYSELECTEDSHOP

struct EmptySelectedShop: View {
    @ObservedObject var theme = gThemeSettings
    var body: some View {
        ZStack {
            VStack {
                Text(NSLocalizedString("start_from_list", comment: "Start from List section!"))
                    .font(Font.system(size: 20)) // modifier
                Image(systemName: "tray.and.arrow.down.fill")
                    .displayImage(width: 200, height: 200)
            }.foregroundColor(theme.mainColor).opacity(0.8) // modifier
        }.edgesIgnoringSafeArea(.all)
        .onAppear { print("EmptySelectedShop appears") }
        .onDisappear { print("EmptySelectedShop disappers") }
    }
}
// MARK: - PREVIEWS

struct SelectedShopView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedShopView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}

