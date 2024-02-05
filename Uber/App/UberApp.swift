//
//  UberApp.swift
//  Uber
//
//  Created by admin on 09/01/24.
//

import SwiftUI

@main
struct UberApp: App {
    @StateObject var locationViewModel = LocationSeachViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
