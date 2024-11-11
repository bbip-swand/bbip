//
//  MypageView.swift
//  BBIP
//
//  Created by 이건우 on 9/9/24.
//

import SwiftUI

struct MypageView: View {
    @StateObject var mypageviewModel = DIContainer.shared.makeMyPageViewModel()
    @State private var showDetail: Bool = false
    @State private var showStudying: Bool = false
    @State private var showStudied: Bool = false
    //    @State private var settinglist = SettingList.MypageSettingList()
    @State var ongoingStudyCount: Int = 0
    @State var finishedStudyCount: Int = 0
    
    init() {
        setNavigationBarAppearance()
    }
    
    private func loadData() {
        mypageviewModel.getProfileInfo()
        mypageviewModel.getOngoingStudyInfo()
        mypageviewModel.getFinishedStudyInfo()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if mypageviewModel.profileData == nil {
                ProgressView()
            } else {
                VStack(spacing: 0) {
                    MypageProfileView.padding(.top, 26)
                    MypageStudyView.padding(.top, 24)
                    MypageSettingListView
                }
                .containerRelativeFrame([.horizontal, .vertical])
                .background(.gray1)
            }
        }
        .navigationTitle("마이페이지")
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
        .onAppear {
            loadData()
        }
    }
    
    // MARK: MypageProfileView
    var MypageProfileView: some View {
        HStack(spacing: 0) {
            LoadableImageView(imageUrl: mypageviewModel.profileData?.profileImageUrl, size: 80)
                .radiusBorder(cornerRadius: 40)
                .padding(.leading, 26)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(mypageviewModel.profileData?.userName ?? "이름없음" )
                        .font(.bbip(.title3_m20))
                        .foregroundStyle(.mainBlack)
                        .padding(.trailing, 17)
                    
                    Text(mypageviewModel.parsedOccupation)
                        .font(.bbip(.caption3_r12))
                        .foregroundStyle(.gray7)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)
                
                HStack(spacing: 5) {
                    ForEach(mypageviewModel.parsedInterests.prefix(3), id: \.self) { interest in
                        CapsuleView(title: interest, type: .normal)
                    }
                    Spacer()
                }
                .padding(.leading, 20)
            }
            Spacer()
            
            Button {
                showDetail = true
            } label: {
                Image("info_open")
                    .padding(.trailing,28)
            }
        }
        .navigationDestination(isPresented: $showDetail) {
            //            ProfileDetailView(
            //                userName: mypageviewModel.profileData?.userName ?? "티니핑",
            //                profileImageUrl: mypageviewModel.profileData?.profileImageUrl ?? "profile_default",
            //                parsedArea: mypageviewModel.parsedArea,
            //                birthYear: mypageviewModel.profileData?.birthYear ?? "0000",
            //                parsedOccupation: mypageviewModel.parsedOccupation,
            //                parsedInterests: mypageviewModel.parsedInterests
            //            )
        }
    }
    
    //MARK: MypageStudyView
    var MypageStudyView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("나의 스터디")
                    .font(.bbip(.body1_b16))
                    .foregroundStyle(.gray8)
                
                Spacer()
            }
            .padding(.leading, 28)
            
            HStack(spacing: 11) {
                MyStudyDetailButton(
                    title: "진행 중인 스터디",
                    count: mypageviewModel.ongoingStudyCount,
                    iconName: "mypage_punch",
                    action: { showStudying = true }
                )
                
                MyStudyDetailButton(
                    title: "종료된 스터디",
                    count: finishedStudyCount,
                    iconName: "mypage_belt",
                    action: { showStudied = true }
                )
            }
            .padding(.top, 12)
        }
        .navigationDestination(isPresented: $showStudying) {
            //            StudySetView(initialIndex: 0, viewModel: mypageviewModel) // 진행 중인 스터디로 초기화
        }
        .navigationDestination(isPresented: $showStudied) {
            //            StudySetView(initialIndex: 1, viewModel: mypageviewModel) // 종료된 스터디로 초기화
        }
    }
    
    //MARK: MypageSettingListView
    var MypageSettingListView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.mainWhite)
                .padding(.top, 29)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 28)
                
                //                ForEach(settinglist) { settinglist in
                //                    SettingListRow(settinglist: settinglist)
                //                        .listRowInsets(EdgeInsets())
                //                        .padding(.leading,28)
                //                        .padding(.trailing,28)
                //                        .padding(.bottom,15)
                //                }
                
                Spacer()
                
                Text("@BBIP")
                    .font(.bbip(.caption3_r12))
                    .foregroundStyle(.gray5)
                    .padding(.bottom, 64)
            }
        }
    }
}

fileprivate struct MyStudyDetailButton: View {
    private let title: String
    private let count: Int
    private let iconName: String
    private let action: () -> Void
    
    init(
        title: String,
        count: Int,
        iconName: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.count = count
        self.iconName = iconName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.mainWhite)
                    .frame(maxHeight: 64)
                
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(title)
                            .font(.bbip(.body2_m14))
                            .foregroundStyle(.gray7)
                        
                        HStack(spacing: 0) {
                            Text("\(count)")
                                .font(.bbip(.body1_sb16))
                                .foregroundStyle(.primary3)
                            
                            Text("개")
                                .font(.bbip(.body1_sb16))
                                .foregroundStyle(.gray8)
                        }
                        .padding(.top, 4)
                    }
                    
                    Spacer()
                    
                    Image(iconName)
                }
                .padding(.horizontal, 19)
            }
        }
        .frame(maxWidth: 175)
    }
}
