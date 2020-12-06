import SwiftUI
import CoreData

struct SelectedShopView: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    @State private var selectedShops = [Shop]()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(selectedShops) { s in
                        NavigationLink(destination: SelectedItemView(store: s)) {
                            SelectedShopRow(store: s)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Shops")
                .onAppear { selectedShops = Shop.selectedShops() }
                if selectedShops.count == 0 { EmptySelectedShop() }
            }
        }.accentColor(themes[self.theme.themeSettings].mainColor)
    }
}

// MARK: - SELECTEDSHOP

struct SelectedShopRow: View {
    @ObservedObject var store: Shop
    
    var body: some View {
        HStack {
            Text(store.shopName).modifier(customText())
            Spacer() // Section B
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
