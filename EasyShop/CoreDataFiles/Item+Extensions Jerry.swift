//  EasyShop
//
//  Created by Jerry on 11/11/20.

import Foundation
import CoreData

let kNotOnList: Int = 0
let kOnListNotTaken: Int = 1
let kOnListAndTaken: Int = 2

extension Item {
    public var itemName: String {
        name ?? "Unknown item name"
    }

	class func addNewItem(named name: String, to store: Shop) {
		let addItem = Item(context: PersistentContainer.context)
		addItem.name = name
		store.addToItem(addItem) //DMG 1
		let index = store.item?.count ?? 0
		addItem.order = Int64(index)
        addItem.status = kNotOnList
		PersistentContainer.saveContext()
	}
    
    class func delete(_ item: Item) { // DMG 6
        let context = item.managedObjectContext
        context?.delete(item)
    }
    
    func toggleSelected() {
        if status == kNotOnList {
            status = kOnListNotTaken
        } else {
            status = kNotOnList
        }
    }

    var status: Int { 
        get { Int( status16 )}
        set {
            shop?.objectWillChange.send()
            status16 = Int16(newValue)
        }
    }
}

