//
//  Double.swift
//  Uber
//
//  Created by admin on 19/02/24.
//

import Foundation

extension Double {
    
    private var currencyFormmater : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormmater.string(for: self) ?? ""
    }
}
