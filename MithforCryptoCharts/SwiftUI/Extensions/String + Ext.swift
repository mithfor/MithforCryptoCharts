//
//  String + Ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 05.12.2024.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>",
                                         with: "",
                                         options: .regularExpression,
                                         range: nil)
    }
}
