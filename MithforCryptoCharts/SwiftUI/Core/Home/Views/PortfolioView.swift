//
//  PortfolioView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 20.11.2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    ScrollView(.horizontal,
                               showsIndicators: true,
                               content: {
                        LazyHStack(spacing: 10) {
                            
                            ForEach(viewModel.allCoins) { coin in
                                Text(coin.symbol.uppercased())
                            }
                        }
                    })
                }
            }
            .navigationTitle("Edit portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
