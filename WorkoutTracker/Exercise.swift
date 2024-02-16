//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 07/02/2024.
//

import Foundation

enum Difficulty: String, Codable, CaseIterable {
    case easy = "Easy"
    case normal = "Normal"
    case hard = "Hard"
    case unsuccessful = "Unsuccessful"
}

struct Exercise: Codable, Identifiable, Hashable {
    var id = UUID()
    var name = "New Exercise"
    var weight: Int? = nil
    var sets: Int = 3
    var reps: Int = 10
    var difficulty: Difficulty = .normal
    
}
