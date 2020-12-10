import SwiftUI

struct Modifiers: View {
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Section {
                    HStack(spacing: 0) {
                        Button(action: {}) {
                            Image(systemName: "plus")
                                .modifier(customButton())
                                .opacity(name.isEmpty ? 0.4 : 1.0)
                                .background(Color("ColorWhiteBlack"))
                        }.disabled(name.isEmpty)
                        
                        TextField("name goes here", text: $name).modifier(customTextfield())
                        Text("1").padding(15)
                    }.modifier(customHStack())
                }
                List {
                    Text("Chicken").modifier(customText())
                }
            }
            .navigationBarTitle(("Modifiers"), displayMode: .inline)
        }
    }
}

// MARK: - Modifiers

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

struct customText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("ColorBlackWhite"))
            .font(Font.system(size: 28))
            .padding(.leading, 20)
    }
}

// MARK: - Preview

struct Modifiers_Previews: PreviewProvider {
    static var previews: some View {
        Modifiers()
    }
}
