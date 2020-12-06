//
//  Shop+Extension.swift
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
            $0.itemName < $1.itemName
        }
    } // HWS
    
    class func addNewShop(named name: String) {
        let newShop = Shop(context: PersistentContainer.context)
        newShop.name = name
        PersistentContainer.saveContext()
    }
    
/*
it would be cleaner … for me … to have the Shop class (or even the PersistentContainer itself,
because it knows where all the data is) be able to return to you “the list of items on the
list (in cart or not).”
so, i would add this as a class function in an extension of Shop:
*/
    static func selectedShops() -> [Shop] {
        let fetchRequest: NSFetchRequest<Shop> = Shop.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "ANY item.status16 > 0")
        let context = PersistentContainer.context
        do {
            let shops = try context.fetch(fetchRequest)
            print("number of selected shops is \(shops.count)")
            return shops
        } catch let error as NSError {
            print("Error finding selected shops: \(error.localizedDescription)")
            return []
        }
    }
    
//DMG3 --
// i am re-inventing the "select" property of a Shop to be a computed property
// that will return true if any item is on the list to purchase but is not yet
// taken.  this tells us whether a shop should have a checkmark in the ShopList view.
    var hasItemsInCartNotYetTaken: Bool {
        for item in getItem {
            if item.status == kOnListNotTaken {
                return true
            }
        }
        return false
    }
    
//DMG3 --
// also, because we changed the meaning of "select" above, we have a separate,
// computed property that tells us whether a shop should appear in the SelectedShopView,
// which as far as i can tell, means that the Shop should appear if it has items that
// are either kOnListNotTaken or kOnListAndTaken
    var hasItemsOnListOrInCart: Bool {
        for item in getItem {
            if item.status == kOnListNotTaken || item.status == kOnListAndTaken {
                return true
            }
        }
        return false
    }
//DMG 4 - from BOSS app - SeedData
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
            
            for item in shop.item {
                let newItem = Item(context: context)
                newItem.name = item.name
                newItem.shop = newShop
            }
        }
        PersistentContainer.saveContext()
    }
    
}
/*
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
 */
