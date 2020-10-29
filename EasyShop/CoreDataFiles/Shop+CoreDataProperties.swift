//
//  Shop+CoreDataProperties.swift
//  EasyShop
//
//  Created by Fede Duarte on 29/10/2020.
//
//

import Foundation
import CoreData


extension Shop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shop> {
        return NSFetchRequest<Shop>(entityName: "Shop")
    }

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
    }
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
