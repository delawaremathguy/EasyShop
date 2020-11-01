import SwiftUI

struct Modifiers: View {
    @State private var name = ""
    var body: some View {
        VStack {
            HStack {
                Text("Hello, World!").modifier(cellText())
            }.modifier(cellStack())
            TextField("name goes here", text: $name).modifier(customTextfield())
            HStack {
                Text("Carrefour")
                    .font(Font.system(size: 30))
                    .padding(.leading, 20)
                Spacer()
            }
            .frame(width: .infinity, height: 80)
            .background(Color("rowcolor"))
            .cornerRadius(20)
        }
    }
}

struct Modifiers_Previews: PreviewProvider {
    static var previews: some View {
        Modifiers()
    }
}

// MARK: - TextField

struct customTextfield: ViewModifier { // Image
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.leading, 15)
            .font(Font.system(size: 20))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .disableAutocorrection(true)
            .keyboardType(UIKeyboardType.default)
    }
}

struct cellText: ViewModifier { // Text
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 22))
            .foregroundColor(Color.black)
            .padding(.all, 5)
    }
}

struct cellStack: ViewModifier { // Stack
    func body(content: Content) -> some View {
        content
            .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("rowcolor"))) // card
    }
}

struct customButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 50)
            .foregroundColor(Color("tint"))
            .background(Color("accent"))
            .cornerRadius(15)
    }
}
