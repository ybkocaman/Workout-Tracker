//
//  ExerciseDisplayView.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 17/02/2024.
//

import SwiftUI

struct ExerciseDisplayView: View {
    var exercise: Exercise
    
    var body: some View {
        HStack {
            Text(exercise.name)
                .font(.title2.bold())
            Spacer()
        }
        
        Spacer()
            .frame(height: 30)
        
        HStack {
            Text("Sets :")
                .foregroundStyle(.secondary)
            Spacer()
            Text(String(exercise.sets))
        }
        .padding(.bottom)
        
        HStack {
            Text("Reps :")
                .foregroundStyle(.secondary)
            Spacer()
            Text(String(exercise.reps))
        }
        
        HStack {
            Text("Difficulty :")
                .foregroundStyle(.secondary)
            Spacer()

            Text(exercise.difficulty.rawValue)
                .padding(10)
                .foregroundStyle(.primary)
                .background(colorForDifficulty(exercise.difficulty).opacity(0.9))
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                }
        }
        .padding(.vertical)
        
        HStack {
            Text("Weight :")
                .foregroundStyle(.secondary)
            Spacer()
            Text(exercise.weight == nil ? "-" : String(exercise.weight!))
                .padding(.trailing)
            Text("kg")
        }
    }
    
    func colorForDifficulty(_ difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return .green
        case .normal:
            return .yellow
        case .hard:
            return .orange
        case .unsuccessful:
            return .red
        }
    }
}
