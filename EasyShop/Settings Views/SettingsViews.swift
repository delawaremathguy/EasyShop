import SwiftUI

struct SettingsViews: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Created by CookingApps")
                
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .border(Color.black)
                    .padding()
                Text("EasyShop Version 1.0").font(.caption)
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

 // MARK: - PREVIEWS

struct SettingsViews_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViews()
    }
}
