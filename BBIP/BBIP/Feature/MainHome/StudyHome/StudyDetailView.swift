import SwiftUI

struct StudyDetailView: View {
    private let vo: FullStudyInfoVO
    
    init(vo: FullStudyInfoVO) {
        self.vo = vo
    }
    
    var body: some View {
        VStack(spacing: 0) {
            studyImageSection
            studyInfoSection
            studyDetailsSection
            Spacer()
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray1)
        .navigationTitle("스터디 정보")
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
        .onAppear {
            setNavigationBarAppearance(backgroundColor: .gray1)
        }
    }
}

private extension StudyDetailView {
    // MARK: - Study Image Section
    var studyImageSection: some View {
        VStack(spacing: 0) {
            LoadableImageView(imageUrl: vo.studyImageURL, size: 124)
                .overlay(
                    Circle().stroke(Color.gray5, lineWidth: 1)
                )
                .padding(.top, 30)
                .padding(.bottom, 20)
            
            Text(vo.studyName)
                .font(.bbip(family: .Bold, size: 20))
                .padding(.bottom, 30)
        }
    }

    // MARK: - Study Info Section (Description)
    var studyInfoSection: some View {
        VStack(spacing: 12) {
            SectionHeaderView(title: "한줄 소개")
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(height: 90)
                .bbipShadow1()
                .overlay(alignment: .topLeading) {
                    Text(vo.studyDescription)
                        .font(.bbip(.body2_m14))
                        .padding(.top, 12)
                        .padding(.horizontal, 14)
                }
                .padding(.horizontal, 17)
        }
        .padding(.bottom, 20)
    }

    // MARK: - Study Details Section
    var studyDetailsSection: some View {
        VStack(spacing: 12) {
            SectionHeaderView(title: "세부 정보")
            VStack(spacing: 20) {
                StudyDetailRowView(label: "분야", value: vo.studyField.rawValue)
                StudyDetailRowView(label: "주차", value: "\(vo.totalWeeks)주차", additionalValue: vo.studyPeriodString)
                StudyDayTimeRow(daysOfWeek: vo.daysOfWeek, studyTimes: vo.studyTimes)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.mainWhite)
                    .bbipShadow1()
            )
            .padding(.horizontal, 17)
        }
    }
}

// MARK: - Section Header View
struct SectionHeaderView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.bbip(.body1_b16))
                .padding(.leading, 28)
            Spacer()
        }
    }
}

// MARK: - Study Detail Row View
struct StudyDetailRowView: View {
    let label: String
    let value: String
    let additionalValue: String?

    init(label: String, value: String, additionalValue: String? = nil) {
        self.label = label
        self.value = value
        self.additionalValue = additionalValue
    }

    var body: some View {
        HStack(spacing: 0) {
            Text(label)
                .font(.bbip(.body1_m16))
                .foregroundStyle(.gray7)
                .padding(.trailing, 63)
            
            Text(value)
                .font(.bbip(.body2_m14))
                .foregroundStyle(.gray9)

            if let additional = additionalValue {
                Text("(\(additional))")
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(.gray9)
                    .padding(.leading, 10)
            }

            Spacer()
        }
    }
}

// MARK: - Study Day and Time Row
struct StudyDayTimeRow: View {
    let daysOfWeek: [Int]
    let studyTimes: [StudyTime]

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("요일")
                .font(.bbip(.body1_m16))
                .foregroundStyle(.gray7)
                .padding(.trailing, 63)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(zip(daysOfWeek, studyTimes)), id: \.0) { day, time in
                    HStack {
                        Text(dayName(for: day))
                        Text("\(time.startTime) ~ \(time.endTime)")
                    }
                    .font(.bbip(.body2_m14))
                }
                .padding(.trailing, 16)
            }
            
            Spacer()
        }
    }
}
