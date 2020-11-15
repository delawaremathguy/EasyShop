import Foundation
import CoreData

extension Shop {
    
    @NSManaged public var select: Bool
    @NSManaged public var order: Int64
    @NSManaged public var name: String?
    @NSManaged public var item: NSSet?

    public var shopName: String {
        name ?? "Unknown Shop name"
    }
    
    public var getItem: [Item] {
        let set = item as? Set<Item> ?? []
        return set.sorted {
            $0.itemName < $1.itemName
        }
    } // HWS
    
    class func addNewShop(named name: String) {
        let newShop = Shop(context: PersistentContainer.context)
        newShop.name = name
        newShop.select = false
        
        /*
        let index = store.item?.count ?? 0
        addItem.order = Int64(index)
         */
        
        PersistentContainer.saveContext()
    }
    
    /* Old func
     let addShop = Shop(context: moc)
     addShop.name = name
     addShop.order = (shops.last?.order ?? 0) + 1
     addShop.select = false
     PersistentContainer.saveContext()
     */
}

extension Shop {
    static func allShops() -> NSFetchRequest<Shop> {
        let request: NSFetchRequest<Shop> = Shop.fetchRequest() as! NSFetchRequest<Shop>
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Shop.order, ascending: true)]
        return request
    } // On ShopList file
    
    static func selectedShops() -> NSFetchRequest<Shop> {
        let request: NSFetchRequest<Shop> = Shop.fetchRequest() as! NSFetchRequest<Shop>
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Shop.select, ascending: false)]
        request.predicate = NSPredicate(format: "select == %@", NSNumber(value: true))
        return request
    } // On SelectedShopView file
}

// MARK: Generated accessors for item
extension Shop {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: Item)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: Item)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}

extension Shop : Identifiable {

}

/*
 THISFILE:
     @nonobjc public class func fetchRequest() -> NSFetchRequest<Shop> {
         return NSFetchRequest<Shop>(entityName: "Shop")
     }
 
 SHOPLIST:
     @FetchRequest(
         entity: Shop.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \Shop.order, ascending: true)]
     ) var shops: FetchedResults<Shop>
 
 SELECTEDSHOPVIEW:
     @FetchRequest(
         entity: Shop.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \Shop.select, ascending: false)],
         predicate: NSPredicate(format: "select == %@", NSNumber(value: true))
     ) var selectedShops: FetchedResults<Shop>
*/
