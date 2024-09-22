import Foundation
import SwiftUI

struct StudySetView : View {
    @State var selectedIndex : Int = 0
    
    var body: some View {
        VStack(spacing:0){
            Rectangle()
                .fill(.mainWhite)
                .frame(height: 8)
            
            HStack(spacing:1){
                ZStack{
                    Rectangle()
                        .fill(.mainWhite)
                        .frame(height:45)
                        .overlay(
                            RoundedRectangle(cornerRadius:1)
                                .frame(height: 2)
                                .foregroundColor(selectedIndex == 0 ? .primary3 : .gray4),
                            alignment: .bottom
                        )
                    
                    Text("진행 중인 스터디")
                        .font(.bbip(selectedIndex == 0 ? .body1_b16 : .body2_m14))
                        .foregroundStyle(.gray8)
                    
                }
                
                ZStack{
                    Rectangle()
                        .fill(.mainWhite)
                        .frame(height:45)
                        .overlay(
                            RoundedRectangle(cornerRadius:1)
                                .frame(height: 2)
                                .foregroundColor(selectedIndex == 1 ? .primary3 : .gray4),
                            alignment: .bottom
                        )
                    
                    Text("종료된 스터디")
                        .font(.bbip(selectedIndex == 1 ? .body1_b16 : .body2_m14))
                        .foregroundStyle(.gray8)
                }
            }
            
            Spacer()
            
            
        }
        .navigationTitle("나의 스터디")
        .background(.mainWhite)
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
        
    }
}

struct StudyCardView : View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius:12)
                .foregroundStyle(.mainWhite)
                .frame(height:97)
                .bbipShadow1()
            
            VStack(alignment: .leading, spacing:0){
                HStack(alignment:.center, spacing:0){
                    Image("profile_default")
                        .resizable()
                        .frame(width:32, height: 32)
                    
                    Text("가나다스터디")
                        .font(.bbip(.body1_sb16))
                        .foregroundStyle(.mainBlack)
                        .padding(.leading,12)
                    
                    Spacer()
                    
                    CapsuleView(title: "디자인", type:.fill)
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
                    
                    Text("10주차 ,주 1회 화요일 15:00")
                        .padding(.trailing, 28)
                    
                    Image("home_nonactive")
                        .resizable()
                        .frame(width: 15.16 , height: 16)
                        .padding(.trailing, 9)
                    
                    Text("비대면 디코")
                }
                .padding(.leading,12)
                .padding(.vertical,12)
                .font(.bbip(.caption2_m12))
                .foregroundStyle(.gray7)
            }
            
        }
    }
}

#Preview{
    StudySetView()
}
