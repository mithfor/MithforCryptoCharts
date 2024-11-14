//
//  CoinImageView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 14.11.2024.
//

import SwiftUI

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    init() {
        fetchImage()
    }
    
    private func fetchImage() {
        
    }
}

struct CoinImageView: View {
    
    @StateObject var viewModel: CoinImageViewModel = CoinImageViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
