//
//  HomeStatsView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 19.11.2024.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(viewModel.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading )}
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
