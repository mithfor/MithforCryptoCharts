//
//  StatisticView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 19.11.2024.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.primaryText)
            HStack(spacing: 4) {
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0 ) >= 0 ? 0 : 180)
                    )
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0 ) >= 0 ? Color.theme.positive : Color.theme.negative)
            .opacity(stat.percentageChange == nil ? 0.0 : 1)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.statDefault)
                .previewLayout(.sizeThatFits)
            StatisticView(stat: dev.statWithPercentage)
                .previewLayout(.sizeThatFits)
            StatisticView(stat: dev.statWithNegaivePercentage)
                .previewLayout(.sizeThatFits)
        }
    }
}
