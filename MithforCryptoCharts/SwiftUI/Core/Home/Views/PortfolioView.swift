//
//  PortfolioView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 20.11.2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: CoinModel?
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    private var canSave: Bool {
        selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                    
                }
            }
            .navigationTitle("Edit portfolio")
            .toolbar {
                leadingToolBarItems
                trailingToolBarItems
            }
            .onChange(of: viewModel.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal,
                   showsIndicators: false,
                   content: {
            LazyHStack(spacing: 10) {
                
                ForEach(viewModel.searchText.isEmpty
                        ? viewModel.portfolioCoins
                        : viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( selectedCoin?.id == coin.id
                                         ? Color.theme.positive
                                         : Color.clear,
                                         lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private func updateSelectedCoin(_ coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = viewModel.portfolioCoins
            .first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice?.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none, value: 0)
        .padding()
        .font(.headline)
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
            return 0.0
    }
    
    private var leadingToolBarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            XMarkButton()
        }
    }
    
    // TODO: - Checkmark and SaveButton should be on the same place?
    
    private var trailingToolBarItems: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            
            CheckMarkView(visible: showCheckmark)

            SaveButton(
                canSave: canSave,
                action: saveButtonPressed
            )
        }
    }
    
    private func saveButtonPressed() {
        
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
        else { return }
        
        // save to portfolio
        viewModel.updatePortfolio(coin: coin, amount: amount)
        
        
        // show checkmark
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        
        UIApplication.shared.endEditing()
        
        // hide checkmark
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}


extension PortfolioView {
    struct SaveButton: View {
        
        var canSave: Bool
        var action: () -> Void
        
        var body: some View {
            Button(
                action: action) {
                    Text("Save".uppercased())
                        .foregroundStyle(Color.theme.primaryText)
                        .opacity(canSave ? 1.0 : 0.0)
                }
        }
    }

    struct CheckMarkView: View {
        
        let visible: Bool
        
        var body: some View {
            Image(systemName: "checkmark")
                .opacity(visible ? 1.0 : 0.0)
        }
    }
}
