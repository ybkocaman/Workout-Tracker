//
//  WorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 08/02/2024.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var workouts = [Workout]() {
        didSet {
            saveData()
        }
    }
    
    let saveKey = "Workouts"
    
    init() { loadData() }
    
    func addWorkout() {
        let newWorkout = Workout()
        workouts.append(newWorkout)
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
    }
    
    func addExercise(to workoutID: UUID) {
        if let index = workouts.firstIndex(where: { $0.id == workoutID }) {
            let newExercise = Exercise(name: "New exercise")
            workouts[index].exercises.append(newExercise)
        }
    }
    
    func deleteExercise(at offsets: IndexSet, from workoutID: UUID) {
        guard let workoutIndex = workouts.firstIndex(where: { $0.id == workoutID }) else { return }
        workouts[workoutIndex].exercises.remove(atOffsets: offsets)
    }
    
    private func saveData() {
        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentsDirectory.appendingPathComponent(saveKey).appendingPathExtension("json")

            let encoded = try JSONEncoder().encode(workouts)
            try encoded.write(to: archiveURL)
            print("Workout data saved successfully.")
        } catch {
            print("Error while saving data: \(error.localizedDescription)")
        }
    }

    private func loadData() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(saveKey).appendingPathExtension("json")

        do {
            let data = try Data(contentsOf: archiveURL)
            let decoded = try JSONDecoder().decode([Workout].self, from: data)
            workouts = decoded
            print("Data has been loaded successfully.")
        } catch {
            print("Error occured while loading data: \(error.localizedDescription)")
        }
    }
    
    func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let formatted = formatter.string(from: date)
        return formatted
    }
    
}
