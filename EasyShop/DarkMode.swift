import SwiftUI

struct DarkMode: View {
    var body: some View {
        ContentView()
    }
}

struct DarkMode_Previews: PreviewProvider {
    static var previews: some View {
        DarkMode()
            .environment(\.managedObjectContext, PersistentContainer.persistentContainer.viewContext)
            .preferredColorScheme(.dark)
    }
}
