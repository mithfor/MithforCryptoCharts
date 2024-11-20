//
//  XMarkButton.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 20.11.2024.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    var body: some View {
        Button(action: {
            presentaionMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
        })
    }
}

#Preview {
    XMarkButton()
}
