//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 07/02/2024.
//

import SwiftUI

@main
struct WorkoutTrackerApp: App {
    @StateObject var viewModel = WorkoutsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
