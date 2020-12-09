import SwiftUI
import CoreData

struct SelectedShopView: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @FetchRequest(fetchRequest: Shop.allShops()) var allShops: FetchedResults<Shop>
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section(header:
                        HStack {
                            Spacer()
                            Text("Products remaining")
                                .opacity(allShops.count != 0 ? 1 : 0)
                        }.textCase(nil)
                    ) {
                        ForEach(allShops) { s in
                            NavigationLink(destination: SelectedItemView(store: s)) {
                                SelectedShopRow(store: s)
                            }
                        }
                    }
                } // LS
                .listStyle(GroupedListStyle())
                .navigationTitle("Shops")
                if allShops.count == 0 {
                    EmptySelectedShop()
                }
            }
        }.accentColor(themes[self.theme.themeSettings].mainColor)
    }
}

// MARK: - SelectedRow

struct SelectedShopRow: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName)
                .foregroundColor((store.countItemsInCart != 0) ? (themes[self.theme.themeSettings].mainColor) : Color("ColorBlackWhite"))
                .font(Font.system(size: 28))
                .padding(.leading, 20)
            Spacer() 
            Text("\(store.countItemsInCart)").font(.caption)
        }.frame(height: rowHeight)
    }
}
// MARK: - EmptySelectedShop

struct EmptySelectedShop: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    var body: some View {
        ZStack {
            VStack {
                Text("Start from the List section!")
                    .font(Font.system(size: 20))
                Image(systemName: "tray.and.arrow.down.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
            }.foregroundColor(themes[self.theme.themeSettings].mainColor).opacity(0.8)
        }.edgesIgnoringSafeArea(.all)
    }
}
// MARK: - PREVIEWS

struct SelectedShopView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedShopView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}

struct SelectedShopRow_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let data = Shop(context: moc)
        data.name = "Whole Food"
        return Group {
            SelectedShopRow(store: data)
                .padding()
                .previewLayout(.sizeThatFits)
            SelectedShopRow(store: data)
                .preferredColorScheme(.dark)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
