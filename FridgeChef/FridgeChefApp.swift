//
//  FridgeChefApp.swift
//  FridgeChef
//
//  Created by Carlos Alexandre Dias Messias de Lima on 03/08/26.
//

import SwiftUI
import SwiftData

@main
struct FridgeChefApp: App {
    @StateObject private var viewModel = CameraViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: Revenue.self)
    }
}
