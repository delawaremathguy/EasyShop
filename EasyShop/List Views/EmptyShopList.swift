import SwiftUI

struct EmptyShopList: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Add new Shop from here!")
                    Image(systemName: "arrow.up.right")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .trailing)
                }
                .foregroundColor(Color("tint")).opacity(0.8)
                .padding()
                Spacer()
            }
        }
    }
}

struct EmptyShopList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyShopList()
    }
}
