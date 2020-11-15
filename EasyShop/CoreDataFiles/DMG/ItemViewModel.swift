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
    // ItemListView(label: "Items: \(viewModel.itemCount)")
}
