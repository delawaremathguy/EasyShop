import SwiftUI

struct customHStack: ViewModifier { // ShopList, ItemList
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color("ColorWhiteBlack")))
            .padding()
            .background(Color("ColorAccent"))
    }
}

struct customButton: ViewModifier { // ShopList, ItemList
    @ObservedObject var theme = gThemeSettings
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .frame(width: 50, height: 50)
            .foregroundColor(theme.mainColor)
    }
}

struct customTextfield: ViewModifier { // ShopList, ItemList
    func body(content: Content) -> some View {
        content
            .frame(height: rowHeight)
            .background(Color("ColorWhiteBlack"))
            .font(Font.system(size: 20))
            .multilineTextAlignment(.center)
            .disableAutocorrection(true)
            .keyboardType(UIKeyboardType.default)
    }
}

struct customItemText: ViewModifier { // ItemList, SelectedItemView
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("ColorBlackWhite"))
            .font(Font.system(size: 20))
    }
}

struct customShopText: ViewModifier { // ShopList, SelectedShopView
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 20))
    }
}
struct chevronLeft: ViewModifier { // SelectedItemView
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .font(.system(size: 20, weight: .regular))
    }
}
struct capsuleFont: ViewModifier { // SettingsView, SettingsTheme
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .font(Font.system(size: 20, design: .serif))
    }
}
struct themeTabbar: ViewModifier { // SetthingsTheme
    func body(content: Content) -> some View {
        content
            .frame(width: 110, height: 180)
            .mask(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray))
    }
}
struct themeRectangle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 10, height: 10)
            .foregroundColor(Color.gray)
    }
}
extension Image {
    func displayImage(width: CGFloat, height: CGFloat) -> some View {
        self  // SelectedShopView
            .resizable()
            .frame(width: width, height: height)
    }
    func capsuleImage(width: CGFloat, height: CGFloat, padding: CGFloat) -> some View {
        self  // SettingsView
            .resizable()
            .frame(width: width, height: height)
            .padding(padding)
    }
    func themeTab(width: CGFloat, height: CGFloat, color: CGColor) -> some View {
        self
            .frame(width: width, height: height)
            .foregroundColor(Color(color))
    }
}

