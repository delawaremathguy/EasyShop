//  EasyShop
//
//  Created by Jerry on 11/11/20.

import Foundation
import CoreData

extension Item {
// 1
    public var itemName: String {
        name ?? "Unknown item name"
    }
// 2
    public var itemAmount: String {
        amount ?? "..."
    }    
// 3
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
// 4
    class func delete(_ item: Item) { 
        let shop = item.shop // this shop is the relationship
        let context = item.managedObjectContext
        context?.delete(item)
        shop?.objectWillChange.send()
        NotificationCenter.default.post(name: .itemStatusChanged, object: self)
        PersistentContainer.saveContext()
    }
// 5
    var status: Int {
        get { Int( status16 )}
        set {
            shop?.objectWillChange.send()
            status16 = Int16(newValue)
            NotificationCenter.default.post(name: .itemStatusChanged, object: self)
        }
    }
// 6
    func toggleSelected() {
        if status == kNotOnList {
            status = kOnListNotTaken
        } else {
            status = kNotOnList
        }
        PersistentContainer.saveContext()
    }
// 7
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



