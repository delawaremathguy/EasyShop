import SwiftUI

struct ShopListModal: View {
    static let DefaultShop = "Any Shop"
    @State var name = ""
    let onComplete: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter the name...", text: $name)
                    .modifier(CustomTextField2())
                Button(action: { addNewShop() }) {
                    Text("Save")
                        .modifier(CustomButton2())
                        .opacity(name.isEmpty ? 0.6 : 1.0)
                }
                .disabled(name.isEmpty)
                Spacer()
            }
            .padding(.top, 25)
            .navigationBarTitle(("New Shop"), displayMode: .inline)
        }
    }
    private func addNewShop() {
        onComplete(name.isEmpty ? ShopListModal.DefaultShop : name)
    }
}

// MARK: - MODIFIERS

struct CustomTextField2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: rowHeight)
            .padding(.vertical, 10)
            .padding(.horizontal, 25)
            .font(Font.system(size: 24))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .disableAutocorrection(true)
            .keyboardType(UIKeyboardType.default)
    }
}

struct CustomButton2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 50)
            .font(Font.system(size: 20))
            .foregroundColor(Color("tint"))
            .background(Color("grayblack"))
            .cornerRadius(15)
    }
}
