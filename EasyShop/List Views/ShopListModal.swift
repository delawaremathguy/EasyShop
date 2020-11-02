import SwiftUI

struct ShopListModal: View {
    static let DefaultShop = "Any Shop"
    @State var name = ""
    let onComplete: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter the name...", text: $name)
                    .frame(height: rowHeight)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .font(Font.system(size: 24))
                    
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .keyboardType(UIKeyboardType.default)
                
                Button(action: { addNewShop() }) {
                    Text("Save")
                        .frame(width: 150, height: 50)
                        .font(Font.system(size: 20))
                        .foregroundColor(Color("tint"))
                        .background(Color("wb"))
                        .cornerRadius(15)
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


