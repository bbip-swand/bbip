//
//  CreateSchedule.swift
//  BBIP
//
//  Created by 조예린 on 10/1/24.
//

import Foundation
import SwiftUI
import Combine

//TODO: -완료눌렀을때 홈화면으로 돌아가도록
struct CreateSchedule: View{
    @EnvironmentObject var appState: AppStateManager
    @StateObject var calendarviewModel = DIContainer.shared.makeCalendarVieModel()
    @State private var isDropdownVisible: Bool = false
    @State private var selectedStudyName: String = ""
    @State private var titleText: String = ""
    
    var body: some View{
        VStack(spacing:0){
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 41)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.mainWhite)
                
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        isDropdownVisible.toggle()
                    }
                }) {
                    Text(selectedStudyName.isEmpty ? "스터디선택" : selectedStudyName)
                        .font(.bbip(.body2_m14))
                        .foregroundColor(selectedStudyName.isEmpty ? .gray5 : .mainBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .lineLimit(1) // 한 줄로 제한
                        .truncationMode(.tail)
                }
                .disabled(calendarviewModel.mystudies.isEmpty) // mystudies가 빈 배열일 경우 버튼 비활성화
                .bbipShadow1()
                
                if isDropdownVisible {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(calendarviewModel.mystudies.filter { !$0.studyName.isEmpty }, id: \.studyId) { mystudy in
                            Button(action: {
                                selectedStudyName = mystudy.studyName
                                isDropdownVisible = false
                            }) {
                                Text(mystudy.studyName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.mainWhite)
                                    .foregroundColor(.mainBlack)
                                    .font(.bbip(.body2_m14)) // 버튼 폰트 스타일 설정
                                    .frame(height: 41) // 버튼 높이 설정
                            }
                            .background(Color.mainWhite)
                            .cornerRadius(12)
                            Divider()
                        }
                    }
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.mainWhite)
                            .bbipShadow1()
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 22)
            
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.mainWhite)
                        .bbipShadow1()
                        .frame(height: 41)
                        .frame(maxWidth: .infinity)
                    
                    TextField("", text: $titleText, prompt: Text("제목 입력").foregroundColor(.gray5))
                        .padding(.horizontal, 16) // 텍스트 필드 안쪽의 여백
                        .font(.bbip(.body2_m14))
                        .foregroundColor(.mainBlack) // 입력 중 폰트 색상
            }
            .frame(height: 41)
            .padding(.horizontal, 16)
            .padding(.top,8)
            
            Spacer()
        }
        .backButtonStyle(isReversal: false, isReversalText: "취소")
        .background(.gray1)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    appState.popToRoot()
                } label: {
                    Text("완료")
                        .font(.bbip(.button2_m16))
                        .foregroundStyle(.primary3)
                }
            }
        }
        .onAppear(){
            calendarviewModel.getMystudy()
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
            isDropdownVisible = false
        }
    }
}

#Preview{
    CreateSchedule()
}
