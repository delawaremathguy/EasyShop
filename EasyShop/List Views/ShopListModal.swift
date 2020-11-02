import SwiftUI

struct ShopListModal: View {
    static let DefaultShop = "Any Shop"
    @State var name = ""
    let onComplete: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter the name", text: $name)
                    .modifier(customTextfield())
                Button(action: { addNewShop() }) {
                    Text("Save")
                        .modifier(customButton())
                        .disabled(name.isEmpty)
                }.opacity(name.isEmpty ? 0.6 : 1.0)
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

struct ShopListMovdal_Previews: PreviewProvider {
    static var previews: some View {
        ModalTest()
    }
}

struct ModalTest: View {
    @State var name = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter the name", text: $name)
                    .modifier(customTextfield())
                
                Button(action: { }) {
                    Text("Save")
                        .frame(width: 150, height: 50)
                        .foregroundColor(Color("tint"))
                        
                        .background(Color("accent"))
                        .cornerRadius(15)
                        .disabled(name.isEmpty)
                }.opacity(name.isEmpty ? 0.6 : 1.0)
                Spacer()
            }
            .padding(.top, 25)
            .navigationBarTitle(("New Shop"), displayMode: .inline)
        }
    }
}
