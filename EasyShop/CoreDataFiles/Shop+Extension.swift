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
