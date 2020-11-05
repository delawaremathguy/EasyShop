import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var select: Bool
    @NSManaged public var order: Int64
    @NSManaged public var name: String?
    @NSManaged public var shop: Shop?
    
    public var itemName: String {
        name ?? "Unknown item name"
    }
}

extension Item : Identifiable {

}
