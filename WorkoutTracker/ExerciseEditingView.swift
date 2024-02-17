//
//  ExerciseEditingView.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 17/02/2024.
//

import SwiftUI

struct ExerciseEditingView: View {
    
    @Binding var exercise: Exercise
    
    var body: some View {
        HStack {
            TextField("Exercise Name", text: $exercise.name)
                .font(.title2.bold())
            Spacer()
        }
        
        Spacer()
            .frame(height: 30)
        
        Stepper(value: $exercise.sets, in: 3...5) {
            HStack {
                Text("Sets :")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(String(exercise.sets))
            }
        }
        
        Stepper(value: $exercise.reps, in: 1...20) {
            HStack {
                Text("Reps :")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(String(exercise.reps))
            }
        }
        
        HStack {
            Text("Difficulty :")
                .foregroundStyle(.secondary)
            Spacer()
            Picker("Difficulty", selection: $exercise.difficulty) {
                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    Text(difficulty.rawValue).tag(difficulty)
                }
            }
            .tint(.primary)
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
            TextField("-", text: Binding<String>(
                get : { exercise.weight.map { String($0) } ?? "" },
                set : { exercise.weight = Int($0) }
            ))
            .keyboardType(.numberPad)
            .multilineTextAlignment(.trailing)
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
