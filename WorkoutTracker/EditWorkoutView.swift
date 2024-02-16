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
                    DatePicker("Date of workout", selection: $workout.date,in: ...Date(), displayedComponents: .date)
                        .padding()
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
                Button("Remove workout", systemImage: "trash") {
                    withAnimation {
                        viewModel.deleteWorkout(workout)
                        dismiss()
                    }
                }
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
}

//#Preview {
//    let sampleWorkout = Workout(id: UUID(), date: Date.now, exercises: [
//        Exercise(id: UUID(), name: "Sample Exercise", weight: nil, sets: 3, reps: 5, difficulty: .hard),
//        Exercise(id: UUID(), name: "Sample Exercise", weight: nil, sets: 3, reps: 5, difficulty: .easy),
//        Exercise(id: UUID(), name: "Sample Exercise", weight: nil, sets: 3, reps: 5, difficulty: .unsuccessful),
//        Exercise(id: UUID(), name: "Sample Exercise", weight: nil, sets: 3, reps: 5, difficulty: .normal)
//    ] )
//    return EditWorkoutView(workout: .constant(sampleWorkout))
//}
