//
//  SearchBarView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 18.11.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty
                                 ? Color.theme.secondaryText
                                 : Color.theme.primaryText)
            
            TextField("Search by name or symbol...",
                      text: $searchText)
            .foregroundStyle(Color.theme.primaryText)
            .disableAutocorrection(true)
            .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundStyle(Color.theme.primaryText)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }, alignment: .trailing
            )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.primaryText.opacity(0.15),
                        radius: 10,
                        x: 0,
                        y: 0 )
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .colorScheme(.light)
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark )
        }
    }
}
