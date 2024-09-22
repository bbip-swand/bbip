
import Foundation
import SwiftUI

struct ProfileDetailView: View{
    private let imageSize: CGFloat = 124
    @State private var profileinfolist = ProfileInfoList.InfoList()
    var body: some View {
        VStack(spacing:0){
                Button {
        //            viewModel.showImagePicker = true
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        if /*let selectedImage = viewModel.selectedImage*/ (5 > 0) {
                            Image(/*uiImage: selectedImage*/"profile_default")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: imageSize, height: imageSize)
                                .clipShape(Circle())
                                .radiusBorder(
                                    cornerRadius: imageSize / 2,
                                    color: .gray4,
                                    lineWidth: 2
                                )
                        } else {
                            Image("profile_default")
                                .resizable()
                                .frame(width: 124, height: 124)
                        }
                        Image("mypage_profile_edit")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 16.5)
                    }
                    .padding(.top,30)
                }
                
                Text("채지영")
                    .font(.bbip(.title3_m20))
                    .foregroundStyle(.mainBlack)
                    .padding(.top,20)
            
            VStack(spacing:0){
                HStack(spacing:0){
                    Text("기본정보")
                        .font(.bbip(.body1_b16))
                        .foregroundStyle(.gray8)
                    
                    Spacer()
                }
                .padding(.leading,28)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray3, lineWidth: 1) // 테두리 색상과 두께 설정
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.mainWhite))
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        
                    
                    HStack(spacing:0){
                        Text("소셜 로그인")
                            .font(.bbip(.body1_m16))
                            .foregroundStyle(.gray7)
                            .padding(.leading,16)
                        
                        Text("APPLE")
                            .font(.bbip(.body2_m14))
                            .foregroundStyle(.gray9)
                            .padding(.leading,21)
                        
                        Spacer()
                        
                        
                    }
                    .padding(.leading,16)
                }
                .padding(.top,12)
            }
            .padding(.top,23)
            
            VStack(spacing:0){
                HStack(spacing:0){
                    Text("부가정보")
                        .font(.bbip(.body1_b16))
                        .foregroundStyle(.gray8)
                    
                    Spacer()
                }
                .padding(.leading,28)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray3, lineWidth: 1) // 테두리 색상과 두께 설정
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.mainWhite))
                        .frame(maxWidth: .infinity)
                        .frame(height:179)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        
                    
                    VStack(spacing:0){
                        Spacer().frame(height:24)
                        
                        ForEach(profileinfolist){profileinfolist in
                            ProfileInfoListRow(profileinfolist: profileinfolist)
                                .padding(.leading,16)
                                .padding(.trailing,26)
                                .padding(.bottom,21)
                        }
                    }
                }
                .padding(.top,12)
                
            }
            .padding(.top,21)
            
            Spacer()
            
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray3, lineWidth: 1) // 테두리 색상과 두께 설정
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.mainWhite))
                    .frame(maxWidth: .infinity)
                    .frame(height:30)
                    .padding(.leading, 137)
                    .padding(.trailing, 137)
                
                Text("BBIP 탈퇴하기")
                    .font(.bbip(.button2_m16))
                    .foregroundStyle(.gray7)
                
            }
            .padding(.bottom,64)
            
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
        .navigationTitle("내 정보 관리")
        .background(.gray1)
    }
    
}


#Preview {
    ProfileDetailView()
}
