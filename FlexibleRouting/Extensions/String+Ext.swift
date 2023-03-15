//
//  String+Ext.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

extension String {
    func decimalPlaces(equalsTo: Int) -> String {
        guard let str = Double(self) else {
            return self
        }
        return "\(NSString(format: "%.\(equalsTo)f" as NSString, str))"
    }
    
    static func separatedNumber(_ number: Any) -> String {
        guard let itIsANumber = number as? NSNumber else { return "Not a number" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        return formatter.string(from: itIsANumber)!
    }
    
    static func formatToCurrency(string: String) -> String {
        let decimalPlaced = String.moreThenThousand(Double(string) as Any).decimalPlaces(equalsTo: 2)
        return String.separatedNumber(Double(decimalPlaced) as Any)
    }
    
    static func moreThenThousand(_ number: Any) -> String {
        guard let itIsANumber = number as? NSNumber else { return "Not a number" }
        if itIsANumber.intValue >= 1000 {
            return String(Int(truncating: itIsANumber))
        }
        return String(Double(truncating: itIsANumber))
    }
}
