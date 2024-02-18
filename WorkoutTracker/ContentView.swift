//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 07/02/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: WorkoutsViewModel
    @State private var isDeleting = false

    var body: some View {
        NavigationStack {
            WorkoutsListView(isDeleting: $isDeleting)
                .environmentObject(viewModel)
                .navigationTitle("Workout Tracker")
                .toolbar { 
                    Button("Delete a workout", systemImage: isDeleting ? "trash.slash" : "trash") {
                        isDeleting.toggle()
                    }
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
