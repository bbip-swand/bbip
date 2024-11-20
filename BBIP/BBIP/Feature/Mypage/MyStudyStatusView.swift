//
//  MyStudyStatusView.swift
//  BBIP
//
//  Created by 이건우 on 11/11/24.
//

import SwiftUI

struct MyStudyStatusView: View {
    @ObservedObject var viewModel: MyPageViewModel
    @State var selectedIndex: Int

    init(initialIndex: Int, viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        _selectedIndex = State(initialValue: initialIndex)
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 1) {
                SwitchButton(
                    title: "진행 중인 스터디",
                    isSelected: selectedIndex == 0
                ) {
                    withAnimation { selectedIndex = 0 }
                }

                SwitchButton(
                    title: "종료된 스터디",
                    isSelected: selectedIndex == 1
                ) {
                    withAnimation { selectedIndex = 1 }
                }
            }
            .background(Color.gray1)
            .animation(.easeInOut(duration: 0.1), value: selectedIndex)

            // Dynamic Content
            if selectedIndex == 0 {
                StudyListView(
                    studyData: viewModel.ongoingStudyData,
                    isFinished: false,
                    emptyMessage: "아직 진행 중인 스터디가 없어요"
                )
            } else {
                StudyListView(
                    studyData: viewModel.finishedStudyData,
                    isFinished: true,
                    emptyMessage: "아직 종료된 스터디가 없어요"
                )
            }

            Spacer()
        }
        .navigationTitle("나의 스터디")
        .background(.mainWhite)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
        .backButtonStyle()
    }
}

fileprivate struct SwitchButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(.gray1)
                    .frame(height: 54)
                    .overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .frame(height: 2)
                            .foregroundColor(isSelected ? .primary3 : .gray4),
                        alignment: .bottom
                    )

                Text(title)
                    .font(.bbip(isSelected ? .body1_b16 : .body2_m14))
                    .foregroundStyle(.gray8)
            }
        }
    }
}

fileprivate struct StudyListView: View {
    let studyData: [StudyInfoVO]?
    let isFinished: Bool
    let emptyMessage: String

    var body: some View {
        if let studyData = studyData, !studyData.isEmpty {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(studyData, id: \.studyId) { study in
                        StudyCardView(study: study, isFinished: isFinished)
                    }
                }
                .bbipShadow1()
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .background(.gray1)
        } else {
            EmptyStudyView(message: emptyMessage)
        }
    }
}

fileprivate struct StudyCardView: View {
    var study: StudyInfoVO
    var isFinished: Bool
    
    private var studyDateText: String {
        if isFinished {
            return "\(study.totalWeeks)주차, \(study.studyTimes.first?.startTime ?? "") ~ \(study.studyTimes.first?.endTime ?? "")"
        } else {
            return "\(study.currentWeek)주차, \(study.studyStartDate) ~ \(study.studyEndDate)"
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(height: 97)
                .bbipShadow1()

            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    LoadableImageView(imageUrl: study.imageUrl, size: 32)

                    Text(study.studyName)
                        .font(.bbip(.body1_sb16))
                        .foregroundStyle(.mainBlack)
                        .padding(.leading, 12)

                    Spacer()

                    CapsuleView(title: study.category.rawValue, type: .fill)
                        .frame(height: 24, alignment: .center)
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)

                Divider()
                    .background(.gray3)
                    .padding(.horizontal, 12)
                    .padding(.top, 13)

                HStack(spacing: 0) {
                    Image("calendar_nonactive")
                        .resizable()
                        .frame(width: 14.82, height: 16)
                        .padding(.trailing, 9.82)

                    Text(studyDateText)
                        .padding(.trailing, 28)

                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .font(.bbip(.caption2_m12))
                .foregroundStyle(.gray7)
            }
        }
    }
}


fileprivate struct EmptyStudyView: View {
    let message: String

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("nostudy")
                .resizable()
                .frame(width: 80, height: 80)

            Text(message)
                .font(.bbip(.title3_sb20))
                .foregroundStyle(.gray7)
                .frame(maxWidth: .infinity)
                .padding(.top, 23)
                .padding(.bottom, 100)
            Spacer()
        }
        .background(.gray1)
    }
}
