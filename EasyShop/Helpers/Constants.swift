import SwiftUI

// MARK: - CoreData

let kNotOnList: Int = 0
let kOnListNotTaken: Int = 1
let kOnListAndTaken: Int = 2

// MARK: - Tabbar

let badgePosition: CGFloat = 2
let tabsCount: CGFloat = 3
let rowHeight: CGFloat = 50

// MARK: - Color
// .background(constant)

let colorBlackWhite: Color = Color("ColorBlackWhite")
let colorWhiteBlack: Color = Color("ColorWhiteBlack")
let colorAccent: Color = Color("ColorAccent")

// MARK: - Impact
// impactxxxx.impactOccurred()

let impactSoft = UIImpactFeedbackGenerator(style: .soft)
let impactMedium = UIImpactFeedbackGenerator(style: .medium)
let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)

// MARK: - CustomRectangle

struct InfinitLine: View {
    var body: some View {
        Rectangle()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
    }
}


