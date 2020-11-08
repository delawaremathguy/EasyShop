import Foundation
import CoreData

extension Item {
    
    @NSManaged public var select: Bool
    @NSManaged public var order: Int64
    @NSManaged public var name: String?
    @NSManaged public var shop: Shop?
    
    public var itemName: String {
        name ?? "Unknown item name"
    }
}

extension Item {
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
}

extension Item : Identifiable {

}

/*
 THISFILE:
     @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
         return NSFetchRequest<Item>(entityName: "Item")
     }
 
 ITEMLIST:
     @FetchRequest(
         entity: Item.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \Item.order, ascending: true)]
     ) var items: FetchedResults<Item>
 
 SELECTEDITEMVIEW:
     @FetchRequest(
         entity: Item.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \Item.select, ascending: false)],
         predicate: NSPredicate(format: "select == %@", NSNumber(value: true))
     ) var selectedItems: FetchedResults<Item>
 */
