import SwiftUI

struct EmptySelectedShop: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Start from the List section!")
                Image(systemName: "tray.and.arrow.down.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
            }.foregroundColor(Color("tint")).opacity(0.8)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct EmptySelectedShop_Previews: PreviewProvider {
    static var previews: some View {
        EmptySelectedShop()
    }
}
