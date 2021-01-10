import SwiftUI

// ****** 1.
class Order: ObservableObject {
    @Published var items = [String]()
    
    func add(item: String) {
        items.append(item)
    }
    
    func remove(item: String) {
        if let index =
            items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}
/*
****** 2.
struct MenuView: View {
    @EnvironmentObject var order: Order
    
    var body: some View {
        VStack {
            Button(action:{
                self.order.add(item: "item")
            }) {
                Text("Add to cart")
            Button(action:{
                self.order.remove(item: "item")
            }) {
                Text("Remove from cart")
            }
        }
    }
}
****** 3.
struct ContentView: View {
 @EnvironmentObject var order: Order
 
 GeometryReader { geo in
     ZStack(alignment: .bottomLeading) {
         TabView(selection: $selected) {
             SelectedShopView().tabItem {
                 Text("Cart")
                 Image("shopcart")
             }.tag(0)
             
             ShopList().tabItem {
                 Text("List")
                 Image("shoplist")
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
         .offset(x: (( 2 * self.badgePosition ) - 0.90 ) * ( geo.size.width / ( 2 * self.tabsCount ) ) + 2, y: -30 )
                .opacity(
                (store.getItem.filter({ $0.status == kOnListNotTaken }).count != 0) ||
                (store.getItem.filter({ $0.status == kOnListAndTaken }).count != 0) ? 1.0 : 0 ))
     }
   }
}
 
 ****** 4.
 On App file:
 
 var order: Order()
 
 ContentView().environmentObject(order)
 
*/
 
