import SwiftUI

// MARK: - Controller

struct Theme: Identifiable {
    let id: Int
    let themeName: String
    let mainColor: Color
}

// MARK: - Model

let themeData: [Theme] = [

    Theme(id: 0, themeName: String(NSLocalizedString("blue_theme", comment: "")), mainColor: Color("ColorBlue")),
    
    Theme(id: 1, themeName: String(NSLocalizedString("green_theme", comment: "")), mainColor: Color("ColorGreen")),
    
    Theme(id: 2, themeName: String(NSLocalizedString("orange_theme", comment: "")), mainColor: Color("ColorOrange")),
    
    Theme(id: 3, themeName: String(NSLocalizedString("pink_theme", comment: "")), mainColor: Color("ColorPink")),
    
    Theme(id: 4, themeName: String(NSLocalizedString("red_theme", comment: "")), mainColor: Color("ColorRed"))

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

