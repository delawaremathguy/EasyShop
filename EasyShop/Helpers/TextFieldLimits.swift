import SwiftUI

/*
 @ObservedObject private var limitAmount = LimitAmount()
 
 TextField(item.itemAmount, text: $limitAmount.amount, onCommit: updateAmount)
 */

// MARK: - TEXTLIMIT CLASS

class LimitAmount: ObservableObject {
    var limit: Int = 5
    
    @Published var amount: String = "" {
        didSet {
            if amount.count > limit {
                amount = String(amount.prefix(limit))
            }
        }
    }
}



