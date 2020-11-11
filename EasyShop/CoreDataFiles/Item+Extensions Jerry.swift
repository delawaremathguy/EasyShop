//
//  Item+Extensions.swift
//  EasyShop
//
//  Created by Jerry on 11/11/20.

import Foundation
import CoreData

//DMG --
// this new file adds some functions directly to the Item class
// for what it's worth, this is a better strategy than going in to
// the XCode-generated Item+CoreDataProperties.swift file and
// making edits there; if you ever make a change to the Core Data
// model for Item, regenerating Item+CoreDataProperties.swift will
// overwrite everything you've added there.
//
// my suggestion: move the definitions you made in Item+CoreDataProperties.swift
// to this file:
// public var itemName: String
// static func allItems() -> NSFetchRequest<Item>
// static func selectedItems() -> NSFetchRequest<Item>

extension Item {
    
    // My Extensions
    
    public var itemName: String {
        name ?? "Unknown item name"
    }
    static func allItems() -> NSFetchRequest<Item> {
    let request: NSFetchRequest<Item> = Item.fetchRequest() as! NSFetchRequest<Item>
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.order, ascending: true)]
    return request
    }
    
    static func selectedItems() -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest() as! NSFetchRequest<Item>
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.select, ascending: false)]
            request.predicate = NSPredicate(format: "select == %@", NSNumber(value: true))
        return request
    }
    
    // Jerry's
	
	class func addNewItem(named name: String, to store: Shop) {
		let addItem = Item(context: PersistentContainer.context)
		addItem.name = name
		addItem.select = false
		store.addToItem(addItem)
		//DMG --
		// not quite sure what .order means; i think you're trying to track
		// the order in which items are added, but there are problems with
		// this strategy.  fo now, i'll leave it essentially as you had it:
		// e.g., if we just added this as the fourth item, its .order should
		// be 4 (?)
		let index = store.item?.count ?? 0
		addItem.order = Int64(index)
		PersistentContainer.saveContext()
	}
	
	func setSelected(to newValue: Bool) {
		select = newValue
		guard let shop = shop else { return }
		// update the associated shop value
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
/*
 //DMG --
 // call new toggleSelection method on an Item, which
 // in turn, will update the select status of the
 // associated shop
 self.item.toggleSelected()
 */
