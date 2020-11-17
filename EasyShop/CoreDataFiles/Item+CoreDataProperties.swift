import Foundation
import CoreData

extension Item {
    
    @NSManaged public var select: Bool
    @NSManaged public var taken: Bool
    @NSManaged public var order: Int64
    @NSManaged public var name: String?
    @NSManaged public var shop: Shop?
    
    @NSManaged public var status16: Int16
}

extension Item { // On SelectedItemView
// @FetchRequest(fetchRequest: Item.takenItems()) var takenItems: FetchedResults<Item>
//    static func takenItems() -> NSFetchRequest<Item> {
//        let request: NSFetchRequest<Item> = Item.fetchRequest() as! NSFetchRequest<Item>
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.select, ascending: false)]
//        request.sortDescriptors = [NSSortDescriptor(keyPath:
//            \Item.taken, ascending: false)]
//        
//        request.predicate = NSPredicate(format: "select == %@", NSNumber(value: true))
//        request.predicate = NSPredicate(format: "taken == %@", NSNumber(value: true))
//        
//        return request
//    }
}
extension Item : Identifiable {

}
