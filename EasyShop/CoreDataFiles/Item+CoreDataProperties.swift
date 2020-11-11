import Foundation
import CoreData

extension Item {
    
    @NSManaged public var select: Bool
    @NSManaged public var order: Int64
    @NSManaged public var name: String?
    @NSManaged public var shop: Shop?
    
}

extension Item : Identifiable {

}

/*
 THISFILE:
     @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
         return NSFetchRequest<Item>(entityName: "Item")
}
 */

/*
 
 i kept the select attribute on Shop because you have some fetch requests that use it as a key path; but it really is read-only and should be treated that way in code.  so you should remove this line in the ShopListRow view:

    .onTapGesture(perform: { self.store.select.toggle() })

 you don’t want to set this the store’s select attribute directly.
 */
