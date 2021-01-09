import SwiftUI

struct ContentView: View {
    @ObservedObject var theme = gThemeSettings
    @State private var selected = 1

    private var badgePosition: CGFloat = 2
    private var tabsCount: CGFloat = 3
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
                TabView(selection: $selected) {
                    
                    ShopList().tabItem {
                        Text("List")
                        Image("shoplist")
                    }.tag(0)
                    
                    SelectedShopView().tabItem {
                        Text("Cart")
                        Image("shopcart")
                    }.tag(1)

                    
                    SettingsViews().tabItem {
                        Text("Settings")
                        Image("shopsettings")
                    }.tag(2)
                }.accentColor(theme.mainColor)
                ZStack {
                    Circle().foregroundColor(theme.mainColor)
                }
                .frame(width: 12, height: 12)
                .offset(x: (( 2 * self.badgePosition ) - 0.90 ) * ( geo.size.width / ( 2 * self.tabsCount ) ) + 2, y: -30)
/*
                .opacity(
                (store.getItem.filter({ $0.status == kOnListNotTaken }).count != 0) ||
                (store.getItem.filter({ $0.status == kOnListAndTaken }).count != 0) ? 1.0 : 0 ))
 */
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
    }
}
