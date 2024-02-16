//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 07/02/2024.
//

import Foundation

struct Workout: Codable, Hashable, Identifiable {
    var id = UUID()
    var date = Date()
    var exercises = [Exercise]()
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    var formattedDay: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}
