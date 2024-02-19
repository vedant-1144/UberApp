//
//  Color.swift
//  Uber
//
//  Created by admin on 19/02/24.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColortTheme()
}

struct ColortTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}
