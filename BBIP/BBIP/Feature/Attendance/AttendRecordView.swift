//
//  AttendRecordView.swift
//  BBIP
//
//  Created by 조예린 on 9/29/24.
//

import Foundation
import SwiftUI
import Combine

struct AttendRecordView: View{
    //TODO: - remainingTime필요
    @StateObject private var viewModel = DIContainer.shared.makeAttendRecordViewModel()
    @State private var isRefresh: Bool = false
    
    var index : Int = 0
    
    init(){
        setNavigationBarAppearance(forDarkView: true)
    }
    var body: some View{
        ScrollView{
            VStack(spacing:0){
                HStack(spacing:0){
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 30)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray8)
                        
                        HStack(spacing: 9) {
                            Image("alarm")
                                .resizable()
                                .frame(width: 21,height: 21)
                                .foregroundColor(.mainWhite)
                            
                            Text("남은 시간:")
                                .font(.bbip(.body1_sb16))
                                .foregroundStyle(.mainWhite)
                            
                            Text("10:00")
                                .font(.bbip(.caption1_m16))
                                .foregroundStyle(.mainWhite)
                        }
                        
                    }
                    Spacer().frame(width:19)
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 30)
                            .frame(width:149)
                            .foregroundStyle(.gray8)
                        
                        HStack(spacing: 9) {
                            Text("인증코드:")
                                .font(.bbip(.caption1_m16))
                                .foregroundStyle(.mainWhite)
                            
                            Text("0318")
                                .font(.bbip(.caption1_m16))
                                .foregroundStyle(.mainWhite)
                        }
                        .padding(.horizontal,20)
                    }
                    
                    
                }
                .padding(.horizontal,20)
                .padding(.top,23)
                
                Text("경기 참여")
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.mainWhite)
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .padding(.top, 28)
                    .padding(.leading, 26)
                    .padding(.bottom,12)
                
                //경기참가한 사람들의 studyEntryCard필요
                ForEach(0..<viewModel.records.filter { $0.status == .attended }.count, id: \.self) { index in
                    let record = viewModel.records.filter { $0.status == .attended }[index]
                    studyEntryCard(vo: record)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                }
                
                Text("경기 미참여")
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.mainWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 15)
                    .padding(.leading, 26)
                
                Text("아직 인증하지 않은 팀원에게 연락해보세요")
                    .font(.bbip(.caption2_m12))
                    .foregroundStyle(.gray6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top,6)
                    .padding(.leading,26)
                    .padding(.bottom,12)
                
                //경기 미참여한 사람들의 studyEntryCard 필요
                ForEach(0..<viewModel.records.filter { $0.status == .absent }.count, id: \.self) { index in
                    let record = viewModel.records.filter { $0.status == .absent }[index]
                    studyEntryCard(vo: record)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                }
                
            }
        }
        .backButtonStyle(isReversal: true)
        .navigationTitle("출결 현황")
        .navigationBarTitleDisplayMode(.inline)
        .background(.gray9)
        .onAppear {
            viewModel.getAttendRecord(studyId: "f1937080-0938-438b-aef5-2ae581bd8f42")
        }
        .refreshable {
            viewModel.getAttendRecord(studyId: "f1937080-0938-438b-aef5-2ae581bd8f42")
            isRefresh = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation { isRefresh = false }
            }
        }
        .scrollIndicators(.never)
        .introspect(.scrollView, on: .iOS(.v17, .v18)) { scrollView in
            scrollView.backgroundColor = .gray9
            scrollView.refreshControl?.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            scrollView.refreshControl?.tintColor = .primary3
        }
    }
}


struct studyEntryCard: View{
    private let vo: getAttendRecordVO
    
    init(vo: getAttendRecordVO){
        self.vo = vo
    }
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 68)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.gray8)
            
            HStack(spacing:0) {
                LoadableImageView(imageUrl: vo.profileImageUrl, size:48)
                    .padding(.trailing,19)
                
                Text(vo.userName)
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.mainWhite)
                
                Spacer()
                
            }
            .padding(.horizontal,14)
        }
        
    }
}


#Preview{
    studyEntryCard(vo: getAttendRecordVO(session:1, userName: "예림", profileImageUrl: "profile_default", status:AttendanceStatus.attended))
}

