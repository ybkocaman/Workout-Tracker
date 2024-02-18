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
    
    @State var showingAlert = false
    var alertMessage = ""
    
    var onDelete: (() -> Void)?
    var onSave: ((_ exercise: Exercise) -> Void)?
        
    var body: some View {
        
            VStack(alignment: .leading) {
                if isEditing {
                    ExerciseEditingView(exercise: $exercise)
                } else {
                    ExerciseDisplayView(exercise: exercise)
                }
            }
        
            .alert("Deleting Exercise", isPresented: $showingAlert) {
                
                Button("Delete", role: .destructive) {
                    withAnimation {
                        onDelete?()
                    }
                    showingAlert.toggle()
                }
                
                Button("Cancel", role: .cancel) {
                    showingAlert.toggle()
                }
                
            } message: {
                Text("Are you sure you want to delete \(exercise.name)?")
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
                buttonsSection
            }
    }
    
    private var exerciseBoxes: some View {
        Group {
            if isEditing {
                ExerciseEditingView(exercise: $exercise)
            } else {
                ExerciseDisplayView(exercise: exercise)
            }
        }
    }
    
    private var buttonsSection: some View {
        VStack {
            HStack {
                Spacer()
                if isEditing {
                    Button {
                        showingAlert.toggle()
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

#Preview {
    let sampleExercise = Exercise(id: UUID(), name: "Sample Exercise", weight: nil, sets: 3, reps: 8, difficulty: .easy)
    return ExerciseView(exercise: .constant(sampleExercise))
}
