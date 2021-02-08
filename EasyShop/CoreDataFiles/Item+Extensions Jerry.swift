//  EasyShop
//
//  Created by Jerry on 11/11/20.

import Foundation
import CoreData

let kNotOnList: Int = 0
let kOnListNotTaken: Int = 1
let kOnListAndTaken: Int = 2

extension Item {
// 1
    public var itemName: String {
        name ?? "Unknown item name"
    }
// 2
	class func addNewItem(named name: String, to store: Shop) {
		let addItem = Item(context: PersistentContainer.context)
		addItem.name = name
		store.addToItem(addItem)
        if let lastItemByPosition = store.getItem.last {
            addItem.position = lastItemByPosition.position + 1
        } else {
            addItem.position = 0
        }
        addItem.status = kNotOnList
		PersistentContainer.saveContext()
	}
// 3
    class func delete(_ item: Item) { 
        let shop = item.shop // this shop is the relationship
        let context = item.managedObjectContext
        context?.delete(item)
        shop?.objectWillChange.send()
        NotificationCenter.default.post(name: .itemStatusChanged, object: self)
        PersistentContainer.saveContext()
    }
// 4
    var status: Int {
        get { Int( status16 )}
        set {
            shop?.objectWillChange.send()
            status16 = Int16(newValue)
            NotificationCenter.default.post(name: .itemStatusChanged, object: self)
        }
    }
// 5
    func toggleSelected() {
        if status == kNotOnList {
            status = kOnListNotTaken
        } else {
            status = kNotOnList
        }
        PersistentContainer.saveContext()
    }
// 6
    static func onShoppingListCount() -> Int {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "status16 == %d", kOnListNotTaken)
        do {
            let count = try PersistentContainer.context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            NSLog("Error counting all items: \(error.localizedDescription)")
        }
        return 0
    }
}



