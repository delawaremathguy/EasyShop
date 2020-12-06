import SwiftUI
import CoreData

struct TabbarTest: View {
    @ObservedObject var theme = ThemeSettings()
    let themes: [Theme] = themeData
    private var badgePosition: CGFloat = 2 // Tabbar Badge Test
    private var tabCounts: CGFloat = 3 // Tabbar Badge Test
    @State private var selected = 0
//    @ObservedObject var store: Shop // Tabbar Badge Test
    @State private var selectedShops = [Shop]() // Tabbar Badge Test 2
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
                TabView {
                    SelectedShopView()
                        .tabItem {
                            Text("Cart")
                            Image("shopcart")
                    }.tag(0)
                    ShopList()
                        .tabItem {
                            Text("List")
                            Image("shoplist")
                    }.tag(1)
                    SettingsViews()
                        .tabItem {
                            Text("Settings")
                            Image("shopsettings")
                    }.tag(2)
                    
                }.accentColor(themes[self.theme.themeSettings].mainColor)
                ZStack { // Test 1
                    Circle()
                        .foregroundColor((themes[self.theme.themeSettings].mainColor))
//                        .opacity(store.hasItemsInCartNotYetTaken ? 1.0 : 0.0) // Tabbar Badge Test
                        .opacity(selectedShops.count == 0 ? 1.0 : 0.0) // Tabbar Badge Test 2
                }
                .frame(width: 12, height: 12)
                .offset(x: (( 1 * self.badgePosition) - 0.95) * ( geo.size.width / (2 * self.tabCounts)) + 2, y: -30)
                .opacity(1.0)
            }
        }
    }
}

struct TabbarTest_Previews: PreviewProvider {
    static var previews: some View {
        TabbarTest().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}

