//
//  Item+Extensions.swift
//  EasyShop
//
//  Created by Jerry on 11/11/20.

import Foundation
import CoreData

extension Item {
    
    // My Extensions
    public var itemName: String {
        name ?? "Unknown item name"
    }

// Jerry's
	class func addNewItem(named name: String, to store: Shop) {
		let addItem = Item(context: PersistentContainer.context)
		addItem.name = name
		addItem.select = false
        addItem.taken = false
		store.addToItem(addItem)
//DMG --
// not quite sure what .order means; i think you're trying to track
// the order in which items are added, but there are problems with
// this strategy.  fo now, i'll leave it essentially as you had it:
// e.g., if we just added this as the fourth item, its .order should
// be 4 (?)
		let index = store.item?.count ?? 0 // Delete?
		addItem.order = Int64(index) // Delete?
		PersistentContainer.saveContext()
	}
    /*
     func newItem() {
         Item.addNewItem(named: name, to: store)
             self.name = ""
     }
     */
	
	func setSelected(to newValue: Bool) {
		select = newValue
		guard let shop = shop else { return }
// update the associated s
		if newValue {
			shop.select = true
		} else {
// this one-liner is a little subtle: allSatisfy will return true if
// every item in the shop is NOT selected, and will return
// false if any one item is selected.  the shop's select state
// is then the opposite of this result
			shop.select = !shop.getItem.allSatisfy({ !$0.select })
		}
	}

	func toggleSelected() {
		setSelected(to: !select)
	}
}

