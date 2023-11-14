//
//  RoutineViewModel.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/22.
//

import Foundation

class RoutineViewModel: ObservableObject {
    
    ///메인뷰 이전 루틴 확인용 시트 모달 변수
    @Published var isDailyRoutineOpen = false
    @Published var showWorkOutOnGoing = false
    
    
    //여기서 타이머 있고,
    
    var date: String {
        let date =  Date()
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MM월 dd일"
        return myFormatter.string(from: date)
    }
}