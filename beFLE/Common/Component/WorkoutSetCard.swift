//
//  WorkoutSetCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI
import Combine


final class setChangeStream: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var textInput = 0
    @Published var debouncedText = 0
    @Published var repInput = 0
    @Published var debouncedReps = 0
    
    init() {
        makeStream()
    }
    func makeStream() {
        $textInput
            .debounce(for: RunLoop.SchedulerTimeType.Stride(1), scheduler: RunLoop.main)
            .sink { [weak self] input in
                self?.debouncedText = input
            }
            .store(in: &cancellables)
        
        $repInput
            .debounce(for: RunLoop.SchedulerTimeType.Stride(1), scheduler: RunLoop.main)
            .sink { [weak self] input in
                self?.debouncedReps = input
            }
            .store(in: &cancellables)
    }
    
    
}

struct WorkoutSetCard: View {
    let index: Int
    let routineId: Int
    let exerciseId: Int
    
    @EnvironmentObject var recordingWorkoutVM: RecordingWorkoutViewModel
    
    @StateObject var debouncedStream = setChangeStream()
    @Binding var set: ExerciseSet
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            Text("\(index)")
                .foregroundColor(.label_900)
            Spacer()
            
            // TODO: 시저 - 텍스트필드 선택 시 플로팅 버튼 사라짐 - DONE
            // TODO: 모로 textfield 클릭시 nil 처리
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    TextField("자율", value: $debouncedStream.textInput, format: .number)
                        .focused(isFocused)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_900)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 10)
                        .onChange(of: debouncedStream.debouncedText) { weight in
                            recordingWorkoutVM.editWeight(index: index - 1, routineId: routineId, exerciseId: exerciseId, setId: set.setId, weight: weight, reps: set.reps) {
                                    set.weight = $0.weight
                            }
                        }
                }
            Text("kg")
                .foregroundColor(.label_700)
            Spacer()
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    TextField("자율", value: $debouncedStream.repInput, format: .number)
                        .focused(isFocused)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_900)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 10)
                        .onChange(of: debouncedStream.debouncedReps) { reps in
                            recordingWorkoutVM.editReps(index: index - 1, routineId: routineId, exerciseId: exerciseId, setId: set.setId, weight: set.weight ?? 0, reps: reps) {
                                set.reps = $0.reps
                            }
                        }
                }
            Text("회")
                .foregroundColor(.label_700)
            Spacer()
                .frame(width: UIScreen.getWidth(50))
            
            if set.isDone {
                CheckButton()
            }
            else {
                EmptyCheckButton()
            }
        }
        .font(.body())
        .padding(.horizontal)
        .padding(.horizontal, 10)
        .padding(.leading, 10)
        .padding(.vertical, 5)
    }
}
//
//struct WorkoutSetCard_Previews:
//    PreviewProvider {
//    static var previews: some View {
//        WorkoutSetCard(index: 1, set: .constant(ExerciseSet(setId: 1, reps: 5, isDone: false)), isFocused: FocusState().projectedValue)
//    }
//}