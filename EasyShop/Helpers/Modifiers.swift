import SwiftUI

struct customHStack: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color("ColorWhiteBlack")))
            .padding()
            .background(Color("ColorAccent"))
    }
}

struct customButton: ViewModifier {
    @ObservedObject var theme = gThemeSettings
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .frame(width: 50, height: 50)
            .foregroundColor(theme.mainColor)
    }
}

struct customTextfield: ViewModifier { // Image
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

struct customItemText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("ColorBlackWhite"))
            .font(Font.system(size: 20))
    }
}

struct customShopText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 20))
    }
}

extension Image {
    func displayImage(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .frame(width: width, height: height)
    }
    func capsuleImage(width: CGFloat, height: CGFloat, padding: CGFloat) -> some View {
        self
            .resizable()
            .frame(width: width, height: height)
            .padding(padding)
    }
    func tabItem(width: CGFloat, height: CGFloat, color: CGColor) -> some View {
        self
            .frame(width: width, height: height)
            .foregroundColor(Color(color))
    }
}
