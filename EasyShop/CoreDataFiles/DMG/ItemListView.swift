//
//  ItemListView.swift
//  EasyShop
//
//  Created by Fede Duarte on 13/11/20.
//  From Jerry's ShoppingList

import SwiftUI

struct ItemListView: View {
    var label: String
    var body: some View {
//        VStack(spacing: 2) {
            HStack {
                Text(label)
                    .font(.caption)
                    .italic()
                    .foregroundColor(.secondary)
            //       .padding([.leading], 20)
            //    Spacer()
            } // HS
//            Rectangle()
//                .frame(minWidth: 0, maxWidth: .infinity, minHeight:               1, idealHeight: 1, maxHeight: 1)
//        } // VS
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(label: "Items: 5")
    }
}
