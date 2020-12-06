//
//  Item+Extensions.swift
//  EasyShop
//
//  Created by Jerry on 11/11/20.

import Foundation
import CoreData

//DMG3 --
// these definitions must be known globally to use them in code.  we may be able to
// hide these in the future, depending on whether you want to stick with them as is,
// maining that an Item can be in only one of three states:
// 0 = not on the list today
// 1 = on the list, but not yet picked up and placed in the cart
// 2 = on the list and i placed it into the cart (so it is purchased)

let kNotOnList: Int = 0
let kOnListNotTaken: Int = 1
let kOnListAndTaken: Int = 2

extension Item {
    public var itemName: String {
        name ?? "Unknown item name"
    }
// Jerry's
	class func addNewItem(named name: String, to store: Shop) {
		let addItem = Item(context: PersistentContainer.context)
		addItem.name = name
		store.addToItem(addItem) //DMG 1
		let index = store.item?.count ?? 0
		addItem.order = Int64(index)
        addItem.status = kNotOnList
		PersistentContainer.saveContext()
	}
//DMG3 --
// this is called from the ItemListRow view that appears in the ItemList
// view. there's some question about what this means: if you put it on the list
// previously and have placed it into your shopping cart, should it still
// remain "selected"?  i will take the approach that it means that if the
// status of the item in kNotOnList, then we will change it to kOnListNotTaken,
// and otherwise, we will change the status to kNotOnList
    func toggleSelected() {
        if status == kNotOnList {
            status = kOnListNotTaken
        } else {
            status = kNotOnList
        }
    }
    
//    func ClearAllItems() {
//        if status == kOnListAndTaken && kOnListNotTaken == 0 {
//            status = kNotOnList
//        }
//    }

    var status: Int { // 1
        get { Int( status16 )}
        set {
// let the shop know we're changing the status of an item, because the
// shop's computed value of "select" depends on it
            shop?.objectWillChange.send()
            status16 = Int16(newValue)
        }
    }
}

