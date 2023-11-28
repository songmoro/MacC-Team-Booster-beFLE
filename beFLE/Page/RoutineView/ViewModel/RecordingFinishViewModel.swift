//
//  RecordingFinishViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/21/23.
//

import SwiftUI

class RecordingFinishViewModel: ObservableObject {
    @Published var volume = 0
    @Published var totalCalories = 0
    
    func caculateWorkoutTime(elapsedTime: TimeInterval) -> String {
        let minutes = Int(elapsedTime) / 60
        
        return "\(minutes)분"
    }
    
    func caculateWorkoutVolume(routineId: Int) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                _ = routine.exercises.map { exercise in
                    self.fetchWorkout(routineId: routineId, exerciseId: exercise.id) {
                        self.volume += $0.first ?? 0
                        self.totalCalories += $0.last ?? 0
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    func fetchWorkout(routineId: Int, exerciseId: Int, completion: @escaping (([Int]) -> ()) ) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let workout):
                var volume = 0
                
                let caloriesPerSet: Double = 16.7
                var totalCalories: Double = 0
                
                _ = workout.sets.map {
                    if let weight = $0.weight {
                        volume += $0.reps * weight
                    }

                    if $0.isDone {
                        totalCalories += caloriesPerSet
                    }
                }
                completion([volume, Int(totalCalories)])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
