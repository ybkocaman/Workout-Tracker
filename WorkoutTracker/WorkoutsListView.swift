//
//  WorkoutView.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 07/02/2024.
//

import SwiftUI

struct WorkoutsListView: View {
    @EnvironmentObject var viewModel: WorkoutsViewModel
    
    @Binding var isDeleting: Bool
    @State private var indexToDelete: Int? = nil
    
    var body: some View {
        NavigationStack {
            
            if viewModel.workouts.isEmpty {
                Text("Tap + button to add a new workout.")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray.opacity(0.6))
            } else {
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        ForEach($viewModel.workouts.indices, id: \.self) { index in
                            NavigationLink(destination: EditWorkoutView(workout: $viewModel.workouts[index])) {
                                HStack {
                                    Text(viewModel.workouts[index].formattedDate)
                                    Spacer()
                                    if isDeleting {
                                        deleteButton(for: index)
                                    } else {
                                        Text(viewModel.workouts[index].formattedDay)
                                    }
                                }
                            }

                            .padding()
                            .background(.mint.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 10))
                            .foregroundStyle(.black)
                            .font(.headline.bold())
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            }
                            .padding(10)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .onAppear(perform: viewModel.loadWorkouts)
                .background(.gray.opacity(0.6))
            }
            
        }
        .alert("Deleting Workout", isPresented: .constant(indexToDelete != nil)) {
            Button("Cancel", role: .cancel) { indexToDelete = nil }
            Button("Delete", role: .destructive) { deleteWorkout() }
        } message: {
            Text("Are you sure you want to delete this workout?")
        }
        
        .environmentObject(viewModel)
    }
    
    private func deleteButton(for index: Int) -> some View {
        Image(systemName: "trash")
            .foregroundStyle(.red)
            .padding(10)
            .background(.white.opacity(0.4))
            .clipShape(.rect(cornerRadius: 10))
            .font(.headline.bold())
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2)
            }
            .onTapGesture {
                indexToDelete = index
            }
    }
    
    private func deleteWorkout() {
        if let index = indexToDelete {
            viewModel.deleteWorkout(at: index)
            indexToDelete = nil
        }
    }

}
