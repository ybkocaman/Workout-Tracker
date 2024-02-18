//
//  EditWorkoutView.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 07/02/2024.
//

import SwiftUI

struct EditWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: WorkoutsViewModel
    @Binding var workout: Workout
    
    var body: some View {

        NavigationStack {
            ZStack {
                Color.gray.opacity(0.6).ignoresSafeArea()
                if workout.exercises.isEmpty {
                    Text("Tap + button to add a new exercise.")
                        .font(.headline.bold())
                }
                ScrollView {
                    datePickerView
                    ForEach($workout.exercises.indices, id: \.self) { index in
                        ExerciseView(
                            exercise: $workout.exercises[index],
                            onDelete: {
                                workout.exercises.remove(at: index)
                                viewModel.saveWorkout(workout)
                            }, onSave: { updatedExercise in
                                workout.exercises[index] = updatedExercise
                                viewModel.saveWorkout(workout)
                            }
                        )
                        .padding()
                    }
                }
            }
            .onChange(of: workout.date) {
                DataManager.shared.saveWorkout(workout)
            }
            .toolbar {
                Button("Add exercise", systemImage: "plus") {
                    withAnimation {
                        addExercise()
                    }
                }
            }
            .navigationTitle("Workout on \(workout.formattedDate)")
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(viewModel)
    }
    
    func deleteExercise(at offsets: IndexSet) {
        workout.exercises.remove(atOffsets: offsets)
        DataManager.shared.saveWorkout(workout)
    }
    
    func addExercise() {
        let newExercise = Exercise()
        workout.exercises.append(newExercise)
        DataManager.shared.saveWorkout(workout)
    }
    
    private var datePickerView: some View {
        DatePicker("Date of workout", selection: $workout.date, in: ...Date(), displayedComponents: .date)
            .foregroundStyle(.black)
            .font(.headline.bold())
            .padding(10)
            .background(.orange.opacity(0.9))
            .clipShape(.rect(cornerRadius: 10))
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 4)
            }
            .padding()
    }
                                
}
