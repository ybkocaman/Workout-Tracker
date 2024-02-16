//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 07/02/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: WorkoutsViewModel

    var body: some View {
        NavigationStack {
            WorkoutsListView()
                .environmentObject(viewModel)
                .navigationTitle("Workout Tracker")
                .toolbar { 
                    Button("Add Workout", systemImage: "plus") {
                        withAnimation {
                            viewModel.addWorkout()
                        }
                    }
                }
        }
    }
    
}

#Preview {
    ContentView()
}
