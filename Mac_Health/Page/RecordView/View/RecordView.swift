//
//  RecordView.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/26/23.
//

import SwiftUI

struct RecordView: View {
    @StateObject var vm = RecordViewModel()
    @State var logOut: Bool = false
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                NavigationTitle
                Calender
                RecordCard
                logOut ? nil : beforeLoginText
                Spacer()
            }
        }
    }
    
    var NavigationTitle: some View {
        HStack {
            Text("기록")
                .font(.title2())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding()
    }
    
    var Calender: some View {
        CalendarView(recordedDate: $vm.recordedDate)
            .frame(height: UIScreen.getHeight(362))
            .padding(.horizontal)
    }
    
    var RecordCard: some View {
        NavigationLink {
            RecordSpecificView()
        } label: {
            RecordCell
        }
    }
    
    var RecordCell: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.fill_1)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
            .overlay {
                VStack {
                    HStack {
                        Ellipse()
                            .frame(width: UIScreen.getWidth(8), height: UIScreen.getHeight(8))
                            .foregroundColor(.yellow_main)
                        Text("정회승")
                            .font(.headline2())
                            .foregroundColor(.label_900)
                        Spacer()
                        
                        Text("52분 12초")
                            .font(.headline2())
                            .foregroundColor(.label_900)
                    }
                    Spacer()
                    HStack {
                        Text("등/가슴")
                            .font(.body2())
                            .foregroundColor(.label_900)
                        Spacer()
                        
                        Text("5200g")
                            .font(.body2())
                            .foregroundColor(.label_900)
                    }
                }
                .padding()
            }
    }
    //TODO: 로그인x or 구독 x
    var beforeLoginText: some View {
        HStack{
            Image(systemName: "info.circle")
            Text("운동기록 예시입니다")
            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 5)
        .font(.caption)
        .foregroundColor(.label_700)
    }
}


struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
