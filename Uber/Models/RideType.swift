//
//  RideType.swift
//  Uber
//
//  Created by admin on 04/02/24.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case black
    case uberXL
    
    var id : Int { return rawValue }
    
    var description : String {
        switch self {
        case .uberX : return "UberX"
        case .black : return "UberBlack"
        case .uberXL : return "UberXL"
        }
    }
    
    var imageName : String {
        switch self {
        case .uberX : return "uber-x"
        case .black : return "uber-black"
        case .uberXL : return "uber-x"
        }
    }
    
    var baseFare : Double {
        switch self {
        case .uberX:
            return 50
        case .black:
            return 100
        case .uberXL:
            return 120
        }
    }
    
    func computePrice(for mtrs : Double) -> Double {
        let kms = mtrs / 1000
        
        switch self {
        case .uberX:
            return 10 * kms + baseFare
        case .black:
            return 15 * kms + baseFare
        case .uberXL:
            return 12.5 * kms + baseFare
        }
    }
    
}
