//
//  Modifiers.swift
//  EasyShop
//
//  Created by Fede Duarte on 29/10/2020.
//

import SwiftUI

struct Modifiers: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Modifiers_Previews: PreviewProvider {
    static var previews: some View {
        Modifiers()
    }
}

// MARK: - TextField

struct customTextfield: ViewModifier { // Image
    func body(content: Content) -> some View {
        content
            .padding(.top, 10)
            .padding(.leading, 15)
            .font(Font.system(size: 20))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
    }
}
