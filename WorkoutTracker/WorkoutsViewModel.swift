//
//  WorkoutsViewModel.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 13/02/2024.
//

import Foundation

class WorkoutsViewModel: ObservableObject {
    
    @Published var workouts = [Workout]()
    
    init() { loadWorkouts() }
    
    func loadWorkouts() {
        workouts = DataManager.shared.loadWorkouts()
    }
    
    func saveWorkouts() {
        DataManager.shared.saveWorkouts(workouts)
    }
    
    func deleteWorkout(_ workout: Workout) {
        DataManager.shared.deleteWorkout(workout)
        loadWorkouts()
    }
    
    func addWorkout() {
        let newWorkout = Workout()
        workouts.append(newWorkout)
        saveWorkouts()
        loadWorkouts()
    }
    
    func saveWorkout(_ workout: Workout) {
        DataManager.shared.saveWorkout(workout)
    }
    
    func deleteExercise(exercise: Exercise, fromWorkout workout: Workout) {
        DataManager.shared.deleteExercise(exercise, fromWorkout: workout)
    }
    
}
