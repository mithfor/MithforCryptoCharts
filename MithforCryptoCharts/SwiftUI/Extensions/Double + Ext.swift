//
//  Double + Ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 31.10.2024.
//

import Foundation

extension Double {
    
    /// Converts a Double to a Currency with 2-6 decimal places
    ///```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    ///```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        
        //default values
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        
        return formatter
    }
    
    func asCurrencyWithDecimal6() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? (currencyFormatter6.currencySymbol + "0.00")
    }
}
