//
//  MypageView.swift
//  BBIP
//
//  Created by 이건우 on 9/9/24.
//

import SwiftUI

struct MypageView: View {
    var body: some View {
        VStack(spacing: 0) {
            MypageProfileView().padding(.top,26)
            
            MypageStudyView().padding(.top,24)
            
            MypageSettingListView()
            
            
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray1)
        .navigationTitle("마이페이지")
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
    }
}

//MARK: MypageProfileView
struct MypageProfileView: View{
    @State var showDetail:Bool = false
    
    var body: some View{
        HStack (spacing: 0){
            Image("profile_default")
                .resizable()
                .frame(width:80, height: 80)
                .padding(.leading, 26)
            
            VStack(spacing:0){
                HStack(spacing:0){
                    Text("채지영")
                        .font(.bbip(.title3_m20))
                        .foregroundStyle(.mainBlack)
                        .padding(.trailing,17)
                    
                    Text("대학생")
                        .font(.bbip(.caption3_r12))
                        .foregroundStyle(.gray7)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)
                
                HStack(spacing:5){
                    ForEach(0..<3, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray8)
                                .frame(maxWidth: 48, maxHeight: 24)//TODO: maxWidth 텍스트사이즈로 고정어케함
                            
                            Text("디자인")
                                .font(.bbip(.caption2_m12))
                                .foregroundStyle(.gray8)
                        }
                    }
                    Spacer()
                    
                }
                .padding(.leading, 20)
            }
            Spacer()
            
            Button{
                showDetail = true
            }label: {
                Image("info_open")
                    .padding(.trailing,28)
            }
        }
        .navigationDestination(isPresented: $showDetail){
            ProfileDetailView()
        }
    }
}

//MARK: MypageStudyView
struct MypageStudyView: View{
    @State var showStudying : Bool = false
    @State var showStudied : Bool = false
    
    var body: some View{
        VStack(spacing: 0) {
            HStack(spacing:0){
                Text("나의 스터디")
                    .font(.bbip(.body1_b16))
                    .foregroundStyle(.gray8)
                
                Spacer()
            }
            .padding(.leading,28)
            
            HStack(spacing:11){
                
                Button{
                    showStudying = true
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.mainWhite)
                            .frame(maxWidth: .infinity, maxHeight: 64)
                            .padding(.leading, 16)
                        
                        HStack(spacing:0){
                            VStack(alignment:.leading,spacing:0){
                                Text("진행 중인 스터디")
                                    .font(.bbip(.body2_m14))
                                    .foregroundStyle(.gray7)
                                
                                HStack(spacing:0){
                                    Text("3")
                                        .font(.bbip(.body1_sb16))
                                        .foregroundStyle(.primary3)
                                        .padding(.top, 4)
                                    
                                    Text("개")
                                        .font(.bbip(.body1_sb16))
                                        .foregroundStyle(.gray8)
                                        .padding(.top, 4)
                                    
                                }
                            }
                            
                            Spacer()
                            
                            Image("mypage_punch")
                                .resizable()
                                .frame(width:35, height: 35)
                        }
                        .padding(.leading,35)
                        .padding(.trailing,19)
                        
                    }
                }
                
                Button{
                    showStudied = true
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.mainWhite)
                            .frame(maxWidth: .infinity, maxHeight: 64)
                            .padding(.trailing,16)
                        
                        HStack(spacing:0){
                            VStack(alignment:.leading,spacing:0){
                                Text("종료된 스터디")
                                    .font(.bbip(.body2_m14))
                                    .foregroundStyle(.gray7)
                                
                                HStack(spacing:0){
                                    Text("3")
                                        .font(.bbip(.body1_sb16))
                                        .foregroundStyle(.primary3)
                                        .padding(.top, 4)
                                    
                                    Text("개")
                                        .font(.bbip(.body1_sb16))
                                        .foregroundStyle(.gray8)
                                        .padding(.top, 4)
                                    
                                }
                            }
                            
                            Spacer()
                            
                            Image("mypage_belt")
                                .resizable()
                                .frame(width:35, height: 24.05)
                        }
                        .padding(.leading, 19)
                        .padding(.trailing,31)
                    }
                }
                
                
            }
            .padding(.top,12)
        }
        .navigationDestination(isPresented: $showStudying){
            StudySetView()
        }
        .navigationDestination(isPresented: $showStudied){
            StudySetView()
        }
    }
}

//MARK: MypageSettingListView
struct MypageSettingListView: View{
    @State private var settinglist = SettingList.MypageSettingList()
    var body: some View{
        ZStack {
            Rectangle()
                .foregroundColor(.mainWhite)
                .padding(.top,29)
                .ignoresSafeArea()
            
            VStack(spacing:0){
                
                Spacer().frame(height:28)
                
                //TODO: 나중에 스크롤 처리
                ForEach(settinglist){ settinglist in
                    SettingListRow(settinglist: settinglist)
                        .listRowInsets(EdgeInsets())
                        .padding(.leading,28)
                        .padding(.trailing,28)
                        .padding(.bottom,15)
                }
                
                Spacer()
                
                Text("@BBIP")
                    .font(.bbip(.caption3_r12))
                    .foregroundStyle(.gray5)
                    .padding(.bottom,64)
                
            }
            .padding(.top,29)
        }
    }
}

#Preview{
        MypageView()
//    MypageProfileView()
}
