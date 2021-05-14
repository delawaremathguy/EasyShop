import SwiftUI

//struct customHStack: ViewModifier { // ShopList, ItemList
//    func body(content: Content) -> some View {
//        content
//            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(colorWhiteBlack))
//            .padding()
//            .background(colorAccent)
//    }
//}

//struct customButton: ViewModifier { // ShopList, ItemList
//    @ObservedObject var theme = gThemeSettings
//    func body(content: Content) -> some View {
//        content
//            .imageScale(.large)
//            .frame(width: 50, height: 50)
//            .foregroundColor(theme.mainColor)
//    }
//}

//struct customTextfield: ViewModifier { // ShopList, ItemList
//    func body(content: Content) -> some View {
//        content
//            .frame(height: rowHeight)
//            .background(colorWhiteBlack)
//            .font(Font.system(size: 20))
//            .multilineTextAlignment(.center)
//            .disableAutocorrection(true)
//            .keyboardType(UIKeyboardType.default) // Needed?
//    }
//}

//struct customItemText: ViewModifier { // ItemList, SelectedItemView
//    func body(content: Content) -> some View {
//        content
//            .foregroundColor(colorBlackWhite)
//            .font(Font.system(size: 20))
//    }
//}


//struct capsuleFont: ViewModifier { // SettingsView, SettingsTheme
//    func body(content: Content) -> some View {
//        content
//            .font(.headline)
//            .font(Font.system(size: 20, design: .serif))
//    }
//}
//struct themeTabbar: ViewModifier { // SetthingsTheme
//    func body(content: Content) -> some View {
//        content
//            .frame(width: 110, height: 180)
//            .mask(RoundedRectangle(cornerRadius: 12))
//            .overlay(RoundedRectangle(cornerRadius: 8)
//            .stroke(Color.gray))
//    }
//}

/*
 ANIMATION
 
 .onAppear(perform: {
     withAnimation(.easeOut(duration: 0.75)) {
         isAnimating.toggle()
     }
 })
 ----
 Button(action: {
     withAnimation(.easeIn) {
         feedback.impactOccurred()
         shop.selectedProduct = nil
         shop.showingProduct = false
     }
 }
 ----
 .onTapGesture {
     feedback.impactOccurred()
     withAnimation(.easeOut) {
         shop.selectedProduct = product
         shop.showingProduct = true
     }
 }
 ----
 .animation(.easeOut(duration: 1.5))
 ----
 .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
 ----
 var slideInAnimation: Animation {
     Animation.spring(response: 1.5, dampingFraction: 0.5, blendDuration: 0.5)
         .speed(1)
         .delay(0.25)
 }
 
 .animation(slideInAnimation)
 ----
 Button(action: {
     withAnimation() {
         self.viewRouter.currentPage = "page2"
     }
 }) {
     NextButtonContent()
 }
 */
