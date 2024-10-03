import Foundation
import SwiftUI

struct StudySetView: View {
    @State var selectedIndex: Int
    var study: [StudyInfoVO]
    
    init(initialIndex: Int , study: [StudyInfoVO]) {
        _selectedIndex = State(initialValue: initialIndex)
        self.study = study
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.mainWhite)
                .frame(height: 8)
            
            HStack(spacing: 1) {
                Button(action: {
                    withAnimation {
                        selectedIndex = 0
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .fill(.mainWhite)
                            .frame(height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 1)
                                    .frame(height: 2)
                                    .foregroundColor(selectedIndex == 0 ? .primary3 : .gray4),
                                alignment: .bottom
                            )
                        
                        Text("진행 중인 스터디")
                            .font(.bbip(selectedIndex == 0 ? .body1_b16 : .body2_m14))
                            .foregroundStyle(.gray8)
                    }
                }
                
                Button(action: {
                    withAnimation {
                            selectedIndex = 1
                        }
                }) {
                    ZStack {
                        Rectangle()
                            .fill(.mainWhite)
                            .frame(height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 1)
                                    .frame(height: 2)
                                    .foregroundColor(selectedIndex == 1 ? .primary3 : .gray4),
                                alignment: .bottom
                            )
                        
                        Text("종료된 스터디")
                            .font(.bbip(selectedIndex == 1 ? .body1_b16 : .body2_m14))
                            .foregroundStyle(.gray8)
                    }
                }
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if selectedIndex == 0 {
                        Spacer().frame(height: 20)
                        ForEach(study, id: \.studyId) { study in
                            StudyCardView(study: study, isFinished: false)
                                .padding(.bottom,8)
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    } else {
                        Spacer().frame(height: 8)
                        ForEach(study, id: \.studyId) { study in
                            Text("\(study.studyStartDate)")
                                .font(.bbip(.body1_sb16))
                                .foregroundStyle(.gray7)
                                .padding(.top,12)
                                .padding(.leading,16)
                            StudyCardView(study: study,isFinished: selectedIndex == 1)
                                .padding(.top,12)
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                        }
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
                .padding(.horizontal, 16)
            }
            .animation(.easeInOut, value: selectedIndex)
            .background(.gray1)
            
            
            Spacer()
        }
        .navigationTitle("나의 스터디")
        .background(.mainWhite)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
        .backButtonStyle()
    }
}



struct StudyCardView : View{
    var study: StudyInfoVO
    var isFinished: Bool
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius:12)
                .foregroundStyle(.mainWhite)
                .frame(height:97)
                .bbipShadow1()
            
            VStack(alignment: .leading, spacing:0){
                HStack(alignment:.center, spacing:0){
                    LoadableImageView(imageUrl: study.imageUrl, size: 32)
                    
                    
                    Text(study.studyName)
                        .font(.bbip(.body1_sb16))
                        .foregroundStyle(.mainBlack)
                        .padding(.leading,12)
                    
                    Spacer()
                    
                    CapsuleView(title: study.category.rawValue, type:.fill)
                        .frame(height: 24, alignment: .center)
                    
                }
                .padding(.top,12)
                .padding(.leading,12)
                .padding(.trailing,15.35)
                
                Rectangle()
                    .fill(.gray3)
                    .frame(height: 1)
                    .padding(.top, 13)
                    .padding(.leading,12)
                    .padding(.trailing,10.5)
                
                HStack(spacing: 0) {
                    Image("calendar_nonactive")
                        .resizable()
                        .frame(width: 14.82, height: 16)
                        .padding(.trailing, 9.82)
                    
                    if isFinished {
                        // 종료된 스터디의 텍스트
                        Text("\(study.totalWeeks)주차, \(study.studyTimes.first?.startTime ?? "") ~ \(study.studyTimes.first?.endTime ?? "")")
                            .padding(.trailing, 28)
                    } else {
                        // 진행 중인 스터디의 텍스트
                        Text("\(study.currentWeek)주차, \(study.studyStartDate) ~ \(study.studyEndDate)")
                            .padding(.trailing, 28)
                    }
                    
                    Spacer()
                }
                .padding(.leading,12)
                .padding(.vertical,12)
                .font(.bbip(.caption2_m12))
                .foregroundStyle(.gray7)
            }
            
        }
        
    }
}
