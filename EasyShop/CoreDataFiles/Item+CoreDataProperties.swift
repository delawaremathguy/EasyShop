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
