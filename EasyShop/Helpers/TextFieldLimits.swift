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

// MARK: - SHOP LIMIT

class LimitShop: ObservableObject { // not working
    var limit: Int = 56
    
    @Published var name: String = "" {
        didSet {
            if name.count > limit {
                name = String(name.prefix(limit))
            }
        }
    }
}

// MARK: - ITEM LIMIT

class LimitItem: ObservableObject { // not working
    var limit: Int = 42
    
    @Published var name: String = "" {
        didSet {
            if name.count > limit {
                name = String(name.prefix(limit))
            }
        }
    }
}


