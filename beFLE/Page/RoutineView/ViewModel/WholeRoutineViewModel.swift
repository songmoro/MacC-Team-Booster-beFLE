//
//  WholeRoutineViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

enum Part: String, CaseIterable {
    case 전체, 등, 가슴, 이두, 삼두, 하체, 복근
}

class WholeRoutineViewModel: ObservableObject {
    let wholeRoutineModel = WholeRoutineModel()
    
    /// 전체 운동 목록
    @Published var wholeRoutine = ResponseGetUsersInfluencersRoutines(routines: [])
    
    /// 선택된 부위
    @Published var selectedPart: Part = .전체
    
    /// 월 별 운동 목록 
    @Published var routinesByMonth: [Int: [Routine]] = [:]
    
    /// 스와이프 오프셋
    @Published var offset: CGFloat = .zero
    
    func fetch(influencerId: Int) {
        wholeRoutineModel.fetchWholeRoutine(influencerId: influencerId) { wholeRoutine in
            self.wholeRoutine = wholeRoutine
            self.parse()
        }
    }
    
    func parse() {
        routinesByMonth = wholeRoutineModel.parseByMonth(selectedPart, routines: wholeRoutine.routines)
    }
}
