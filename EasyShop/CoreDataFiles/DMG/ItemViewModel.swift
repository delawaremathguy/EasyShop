//
//  ItemViewModel.swift
//  EasyShop
//
//  Created by Fede Duarte on 13/11/20.
//  From Jerry's ShoppingList

import Foundation

class ItemViewModel: ObservableObject {
    
    @Published var items = [Item]()
    
    var itemCount: Int { items.count }
    
    // @ObservedObject var viewModel = ItemViewModel()
    // Text("Items: \(viewModel.itemCount)")

}

/*
 Count items
 
 @State private var totalItems: Int = 0
 
 HStack {
     Text("Total Items")
     Spacer()
     Text(String(totalItems)).bold()
 }.foregroundColor(Color.green)
 
 .onAppear(perform: {
     countItems()
 })
 
 func countItems() {
     let request: NSFetchRequest<Item> = Item.fetchRequest()
     if let count = try? self.moc.count(for: request) {
         self.totalItems = count
     }
 }
 
 */
