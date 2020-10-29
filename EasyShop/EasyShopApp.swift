//
//  EasyShopApp.swift
//  EasyShop
//
//  Created by Fede Duarte on 29/10/2020.
//

import SwiftUI
import CoreData

@main
struct EasyShopApp: App {
    let context = PersistentContainer.persistentContainer.viewContext
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, context)
        }
    }
}
