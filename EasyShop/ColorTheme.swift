import SwiftUI

// MARK: - Controller

struct Theme: Identifiable {
    let id: Int
    let themeName: String
    let mainColor: Color
}

// MARK: - Model

let themeData: [Theme] = [

    Theme(id: 0, themeName: "Blue Theme", mainColor: Color("ColorBlue")),
    
    Theme(id: 1, themeName: "Green Theme", mainColor: Color("ColorGreen")),
    
    Theme(id: 2, themeName: "Orange Theme", mainColor: Color("ColorOrange")),
    
    Theme(id: 3, themeName: "Pink Theme", mainColor: Color("ColorPink")),
    
    Theme(id: 4, themeName: "Red Theme", mainColor: Color("ColorRed"))

]

// MARK: - Class

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int =
        UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    var mainColor: Color { themeData[themeSettings].mainColor }
}

let gThemeSettings = ThemeSettings()

