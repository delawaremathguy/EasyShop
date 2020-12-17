//  EasyShop
//
//  Created by Jerry on 11/19/20.

import Foundation
import CoreData

extension Shop {
    
    var shopName: String {
        name ?? "Unknown Shop name"
    }
    
    public var getItem: [Item] {
        let set = item as? Set<Item> ?? []
        return set.sorted {
            $0.position < $1.position
        }
    }
    
    static func shopList() -> [Shop] {
        let context = PersistentContainer.context
        let fetchRequest: NSFetchRequest<Shop> = Shop.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
        do {
            let shops = try context.fetch(fetchRequest)
            return shops
        }
        catch let error as NSError {
            print("Error fetching Shops: \(error.localizedDescription), \(error.userInfo)")
        }
        return []
    }
    
    class func addNewShop(named name: String) {
        let newShop = Shop(context: PersistentContainer.context)
        newShop.name = name
        if let lastShopByPosition = shopList().last {
            newShop.position = lastShopByPosition.position + 1
        } else {
            newShop.position = 0
        }
        PersistentContainer.saveContext()
    }

    var hasItemsInCartNotYetTaken: Bool {
        for item in getItem {
            if item.status == kOnListNotTaken {
                return true
            }
        }
        return false
    }

    var hasItemsOnListOrInCart: Bool {
        for item in getItem {
            if item.status == kOnListNotTaken || item.status == kOnListAndTaken {
                return true
            }
        }
        return false
    }

    var countItemsInCart: Int {
        var count = 0
        for item in getItem {
            if item.status == kOnListNotTaken {
                count += 1
            }
        }
        return count
    }
    
    static func delete(_ shop: Shop) { 
        let context = shop.managedObjectContext
        context?.delete(shop)
    }

    static func count() -> Int {
        let context = PersistentContainer.context
        let fetchRequest: NSFetchRequest<Shop> = Shop.fetchRequest()
        do {
            let itemCount = try context.count(for: fetchRequest)
            return itemCount
        }
        catch let error as NSError {
            print("Error counting Shops: \(error.localizedDescription), \(error.userInfo)")
        }
        return 0
    }
    
    static func loadSeedData(into context: NSManagedObjectContext) {
        for shop in shopsList {
            let newShop = Shop(context: context)
            newShop.name = shop.name
            newShop.position = shop.position
            
            for item in shop.item {
                let newItem = Item(context: context)
                newItem.name = item.name
                newItem.position = item.position
                newItem.shop = newShop
            }
        }
        PersistentContainer.saveContext()
    }
    
}
extension Shop {
    static func allShops() -> NSFetchRequest<Shop> {
        let request: NSFetchRequest<Shop> = Shop.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
        return request
    }
}
