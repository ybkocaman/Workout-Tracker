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
    
//    init(id: UUID = UUID(), name: String = "", weight: Int? = nil, sets: Int = 3, reps: Int = 10, difficulty: Difficulty = .normal) {
//        self.id = id
//        self.name = name
//        self.weight = weight
//        self.sets = sets
//        self.reps = reps
//        self.difficulty = difficulty
//    }
}
