//
//  ExerciseView.swift
//  WorkoutTracker
//
//  Created by Yusuf Burak on 11/02/2024.
//

import SwiftUI

struct ExerciseView: View {
    @EnvironmentObject var viewModel: WorkoutsViewModel
    @Binding var exercise: Exercise
    @State private var isEditing = false
    var onDelete: (() -> Void)?
    var onSave: ((_ exercise: Exercise) -> Void)?
        
    var body: some View {
            VStack(alignment: .leading) {
                if isEditing {
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
                } else {
                    
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
            }
            .padding(20)
            .background(.mint.opacity(0.7))
            .clipShape(.rect(cornerRadius: 10))
            .foregroundStyle(.black)
            .font(.headline.bold())
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 4)
            }
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        if isEditing {
                            Button {
                                withAnimation {
                                    onDelete?()
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                                    .padding(10)
                                    .background(.white.opacity(0.4))
                                    .clipShape(.rect(cornerRadius: 10))
                                    .font(.headline.bold())
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 2)
                                    }
                            }
                            Button {
                                withAnimation {
                                    onSave?(exercise)
                                    isEditing.toggle()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "app.badge.checkmark")
                                    Text("Save")
                                }
                                .padding(10)
                                .background(.white.opacity(0.4))
                                .clipShape(.rect(cornerRadius: 10))
                                .font(.headline.bold())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                }
                            }
                        } else {
                            Button {
                                withAnimation {
                                    isEditing.toggle()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                    Text("Edit")
                                }
                                .padding(10)
                                .background(.white.opacity(0.4))
                                .clipShape(.rect(cornerRadius: 10))
                                .font(.headline.bold())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                }
                            }
                        }
                        
                    }
                    .padding()
                    Spacer()
                }
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

#Preview {
    let sampleExercise = Exercise(id: UUID(), name: "Sample Exercise", weight: nil, sets: 3, reps: 8, difficulty: .easy)
    return ExerciseView(exercise: .constant(sampleExercise))
}
