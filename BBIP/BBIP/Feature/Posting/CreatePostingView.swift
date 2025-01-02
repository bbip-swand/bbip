//
//  CreatePostingView.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import SwiftUI

struct CreatePostingView: View {
    @EnvironmentObject var appState: AppStateManager
    @StateObject private var viewModel: CreatePostingViewModel = DIContainer.shared.createPostingViewModel()
    @State private var showWeeklyContentPicker: Bool = false
    private let studyId: String
    private let weeklyContent: [String]
    
    init(studyId: String, weeklyContent: [String]) {
        self.studyId = studyId
        self.weeklyContent = weeklyContent
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            selectWeekButton
                .padding(.vertical, 22)
            
            titleTextField
                .padding(.bottom, 8)
            
            postContentTextField
            
            Spacer()
        }
        .ignoresSafeArea(.keyboard)
        .padding(.horizontal, 16)
        .background(.gray1)
        .navigationTitle("글 작성")
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
        .loadingOverlay(isLoading: $viewModel.isUploading, withBackground: false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.uploadPosting(studyId: studyId, isNotice: false)
                } label: {
                    Text("업로드")
                        .font(.bbip(.body1_m16))
                        .foregroundStyle(viewModel.canUpload ? .mainWhite : .gray5)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(viewModel.canUpload ? .primary3 : .gray2)
                        )
                }
                .disabled(!viewModel.canUpload)
            }
        }
        .sheet(isPresented: $showWeeklyContentPicker) {
            weekPicker
                .presentationDetents([.height(400)])
                .presentationDragIndicator(.visible)
        }
        .onChange(of: viewModel.uploadSuccess) { _, success in
            if success { appState.popToRoot() }
        }
        .onAppear {
            setNavigationBarAppearance(backgroundColor: .gray1)
        }
    }
}

extension CreatePostingView {
    var selectWeekButton: some View {
        Button {
            showWeeklyContentPicker = true
        } label: {
            HStack(spacing: 20) {
                Text(viewModel.week == -1 ? "주차 선택" : "\(viewModel.week)주차")
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(viewModel.week == -1 ? .gray5 : .mainBlack)
                Image(systemName: "chevron.down")
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .foregroundStyle(.gray5)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.mainWhite)
                    .bbipShadow1()
            )
        }
    }
    
    var titleTextField: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainWhite)
                .bbipShadow1()
                .frame(height: 41)
                .frame(maxWidth: .infinity)
            
            TextField(
                "",
                text: $viewModel.title,
                prompt: Text("제목 입력(20자 이내)").foregroundColor(.gray5)
            )
            .padding(.horizontal, 14)
            .font(.bbip(.body2_m14))
            .foregroundColor(.mainBlack)
        }
    }
    
    var postContentTextField: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainWhite)
                .bbipShadow1()
                .frame(height: 250)
                .frame(maxWidth: .infinity)
            
            TextField(
                "",
                text: $viewModel.content,
                prompt: Text("본문(300자 이내)").foregroundColor(.gray5)
            )
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .font(.bbip(.body2_m14))
            .foregroundColor(.mainBlack)
        }
    }
    
    var weekPicker: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(0..<weeklyContent.count, id: \.self) { index in
                    WeeklyStudyContentCardView(week: index + 1, content: weeklyContent[index])
                        .onTapGesture {
                            viewModel.week = index + 1
                            showWeeklyContentPicker = false
                        }
                }
            }
            .padding(.vertical, 22)
        }
        .scrollIndicators(.hidden)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray1)
    }
}
