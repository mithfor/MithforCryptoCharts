//
//  Date + Ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 04.12.2024.
//

import Foundation

extension Date {

    // 2024-03-14T07:10:36.635Z
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }

    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
