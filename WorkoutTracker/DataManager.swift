//
//  DataManager.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 08/02/2024.
//

import Foundation


class DataManager: ObservableObject {
    // Static property shared for accessing the singleton instance.
    static let shared = DataManager()
    
    // Private initializer to prevent the creation of additional instances.
    private init() {}
    
    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private var archiveURL: URL {
        documentsDirectory.appendingPathComponent("WorkoutTracker").appendingPathExtension("json")
    }
    
    func saveWorkouts(_ workouts: [Workout]) {
        do {
            let data = try JSONEncoder().encode(workouts)
//            if FileManager.default.fileExists(atPath: archiveURL.path) {
//                try FileManager.default.removeItem(at: archiveURL)
//                print("Data has been deleted successfully to initialize from scratch.")
//            }

            try data.write(to: archiveURL, options: [.atomic, .completeFileProtection])
            print("Workouts data has been saved successfully.")
        } catch {
            print("Error saving workouts: \(error.localizedDescription)")
        }
    }
    
    func loadWorkouts() -> [Workout] {
        guard FileManager.default.fileExists(atPath: archiveURL.path) else {
            print("File does not exist for this URL.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: archiveURL)
            let decoder = JSONDecoder()
            let workouts = try decoder.decode([Workout].self, from: data)
            print("Data has been loaded successfully.")
            return workouts.sorted(by: { $0.date > $1.date })
        } catch {
            print("Error loading workouts: \(error)")
            return []
        }
    }
    
    func saveWorkout(_ workout: Workout) {
        var workouts = loadWorkouts()
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[index] = workout
            saveWorkouts(workouts)
            print("A workout has been saved successfully.")
        } else {
            print("Workout not saved.")
        }
    }
    
    func deleteWorkout(_ workout: Workout) {
        var workouts = loadWorkouts()
        workouts.removeAll(where: { $0.id == workout.id })
        print("A workout has been deleted successfully.")
        saveWorkouts(workouts)
    }
    
    func deleteExercise(_ exercise: Exercise, fromWorkout workout: Workout) {
        var workouts = loadWorkouts()
        if let workoutIndex = workouts.firstIndex(where: { $0.id == workout.id }),
           let exerciseIndex = workout.exercises.firstIndex(where: { $0.id == exercise.id }) {
            workouts[workoutIndex].exercises.remove(at: exerciseIndex)
            saveWorkouts(workouts)
            print("Exercise data has been deleted successfully.")
        } else {
            print("Error while deleting an exercise data.")
        }
    }
    
}

