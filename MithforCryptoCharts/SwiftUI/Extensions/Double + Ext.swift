//
//  Double + Ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 31.10.2024.
//

import Foundation

extension Double {
    
    /// Converts a Double to a Currency with 2 decimal places
    /// Default Currency code = usd
    /// Default Currency symbol = $
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.34
    /// Convert 0.123456 to $0.12
    ///
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()

        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency

        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        formatter.locale = .init(identifier: "US_us")
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        
        return formatter
    }
    
    /// Converts a Double to a Currency as String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.34"
    /// Convert 0.123456 to "$0.12"
    /// ```
    func asCurrencyWith2Decimals(currencyCode: String? = nil, currencySymbol: String? = nil) -> String {
        let number = NSNumber(value: self)
        
        if let currencyCode = currencyCode {
            currencyFormatter2.currencyCode = currencyCode
        }
        
        if let currencySymbol = currencySymbol {
            currencyFormatter2.currencySymbol = currencySymbol
        }
        
        return currencyFormatter2.string(from: number) ?? "0.00"
    }
    
    /// Converts a Double to a Currency with 2-6 decimal places
    /// Default Currency code = usd
    /// Default Currency symbol = $
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    ///
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()

        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency

        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6

        formatter.locale = .init(identifier: "US_us")
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        
        return formatter
    }
    
    /// Converts a Double to a Currency as String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyWith6Decimals(currencyCode: String? = nil, currencySymbol: String? = nil) -> String {
        let number = NSNumber(value: self)
        
        if let currencyCode = currencyCode {
            currencyFormatter6.currencyCode = currencyCode
        }
        
        if let currencySymbol = currencySymbol {
            currencyFormatter6.currencySymbol = currencySymbol
        }
        
        return currencyFormatter6.string(from: number) ?? "0.00"
    }
    
    /// Converts a Double to a into String represenattion with 2 decimal places
    /// ```
    /// Convert 1234.56 to "1,234.56"
    /// Convert 12.3456 to "12.34"
    /// Convert 0.123456 to "0.12"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into String represenattion with percent symbol
    /// ```
    /// Convert 1234.56 to "1,234.56%"
    ///
    /// ```
    func asPercentString() -> String {
        return  asNumberString() + "%"
    }
}
