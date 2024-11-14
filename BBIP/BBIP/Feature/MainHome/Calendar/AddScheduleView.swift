//
//  AddScheduleView.swift
//  BBIP
//
//  Created by 이건우 on 11/14/24.
//

import SwiftUI

struct AddScheduleView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddScheculeViewModel = .init()
    
    private var ongoingStudyData: [StudyInfoVO]?
    
    init(ongoingStudyData: [StudyInfoVO]? = nil) {
        self.ongoingStudyData = ongoingStudyData
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            
            Spacer().frame(height: 22)
            
            selectStudy
            Spacer().frame(height: 8)
            
            schduleTitle
            
            Spacer()
        }
        .keyboardHideable()
        .padding(.horizontal, 16)
        .background(.gray1)
        .navigationBarBackButtonHidden()
    }
}

extension AddScheduleView {
    // MARK: - Header
    var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("취소")
                    .font(.bbip(.button2_m16))
                    .foregroundStyle(.gray5)
                    .padding(.leading, 14)
            }
            
            Spacer()
            
            Button {
                // add schedule
            } label: {
                Text("완료")
                    .font(.bbip(.button2_m16))
                    .foregroundStyle(.primary3)
                    .padding(.trailing, 14)
            }
        }
        .frame(height: 42)
    }
    
    // MARK: - Select study
    var selectStudy: some View {
        Group {
            if let ongoingStudyData = ongoingStudyData {
                if ongoingStudyData.isEmpty {
                    emptyStudyView
                } else {
                    studyMenu(ongoingStudyData: ongoingStudyData)
                }
            } else {
//                EmptyView()
                emptyStudyView
            }
        }
    }

    // Subview for the "Empty Study" state
    private var emptyStudyView: some View {
        HStack(spacing: 10) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 145, height: 41)
                    .foregroundStyle(.mainWhite)
                    .bbipShadow1()

                Text("스터디 선택")
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(.gray5)
                    .padding(.leading, 14)
            }
            .disabled(true)
            
            Text("진행 중인 스터디가 없습니다.")
                .font(.bbip(.body2_m14))
                .foregroundStyle(.gray5)
        }
    }

    // Subview for the "Menu" state
    private func studyMenu(ongoingStudyData: [StudyInfoVO]) -> some View {
        Menu {
            ForEach(ongoingStudyData.indices, id: \.self) { index in
                Button {
                    viewModel.selectedStudyName = ongoingStudyData[index].studyName
                    viewModel.selectedStudyId = ongoingStudyData[index].studyId
                } label: {
                    Text(ongoingStudyData[index].studyName)
                }
            }
        } label: {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 145, height: 41)
                    .foregroundStyle(.mainWhite)
                    .bbipShadow1()

                Text(viewModel.selectedStudyName ?? "스터디 선택")
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(viewModel.selectedStudyName == nil ? .gray5 : .mainBlack)
                    .padding(.leading, 14)
            }
        }
    }
    
    // MARK: - Schedule title
    var schduleTitle: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainWhite)
                .bbipShadow1()
                .frame(height: 41)
                .frame(maxWidth: .infinity)
            
            TextField(
                "",
                text: $viewModel.scheduleTitle,
                prompt: Text("제목 입력").foregroundColor(.gray5)
            )
            .padding(.horizontal, 14)
            .font(.bbip(.body2_m14))
            .foregroundColor(.mainBlack)
        }
    }
}

#Preview {
    AddScheduleView()
}
