import Foundation
import SwiftUI
import Combine

struct AttendanceRecordView: View {
    @StateObject var attendanceRecordsViewModel: AttendanceRecordsViewModel = DIContainer.shared.makeAttendanceRecordsViewModel()
    @State private var formattedTime: String = ""
    @State private var timer: AnyCancellable?
    @State private var remainingTime: Int = 0
    
    @State private var isRefresh: Bool = false
    
    private let studyId: String
    private let code: Int
    
    init(
        remainingTime: Int,
        studyId: String,
        code: Int
    ) {
        self.remainingTime = remainingTime
        self.studyId = studyId
        self.code = code
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        formattedTime = formatTime(remainingTime)
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                guard remainingTime > 0 else {
                    formattedTime = "00:00"
                    timer?.cancel()
                    return
                }
                remainingTime -= 1
                formattedTime = formatTime(remainingTime)
            }
    }
    
    private func recordSection(title: String, records: [AttendanceRecordVO]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.bbip(.body1_sb16))
                .foregroundStyle(.mainWhite)
                .padding(.leading, 26)
            
            if title == "경기 미참여" {
                Text("아직 인증하지 않은 팀원에게 연락해보세요")
                    .font(.bbip(.caption2_m12))
                    .foregroundStyle(.gray6)
                    .padding(.leading, 26)
            }
            
            ForEach(records, id: \.session) { record in
                StudyEntryCard(vo: record)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HeaderSection(formattedTime: $formattedTime, code: code)
                    .padding(.horizontal, 20)
                    .padding(.top, 23)
                
                if let records = attendanceRecordsViewModel.records {
                    let attendedRecords = records.filter { $0.isAttended }
                    let absentRecords = records.filter { !$0.isAttended }
                    
                    recordSection(title: "경기 참여", records: attendedRecords)
                        .padding(.top, 28)
                    
                    recordSection(title: "경기 미참여", records: absentRecords)
                        .padding(.top, 15)
                }
            }
        }
        .backButtonStyle(isReversal: true)
        .navigationTitle("출결 현황")
        .navigationBarTitleDisplayMode(.inline)
        .background(.gray9)
        .onAppear {
            setNavigationBarAppearance(forDarkView: true)
            attendanceRecordsViewModel.getAttendanceRecords(studyId: studyId)
            startTimer()
        }
        .onDisappear {
            timer?.cancel()
        }
        .refreshable {
            attendanceRecordsViewModel.getAttendanceRecords(studyId: studyId)
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

// MARK: - Header Section
fileprivate struct HeaderSection: View {
    @Binding var formattedTime: String
    let code: Int
    
    fileprivate var body: some View {
        HStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.gray8)
                
                HStack(spacing: 9) {
                    Image("alarm")
                        .resizable()
                        .frame(width: 21, height: 21)
                    
                    Text("남은 시간:")
                        .font(.bbip(.body1_sb16))
                    
                    Text(formattedTime)
                        .font(.bbip(.caption1_m16))
                }
                .foregroundStyle(.mainWhite)
            }
            
            Spacer().frame(width: 19)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 30)
                    .frame(width: 149)
                    .foregroundStyle(.gray8)
                
                HStack(spacing: 9) {
                    Text("인증코드:")
                    Text(code.description)
                }
                .font(.bbip(.caption1_m16))
                .foregroundStyle(.mainWhite)
                .padding(.horizontal, 20)
            }
        }
    }
}

// MARK: - Study Entry Card
fileprivate struct StudyEntryCard: View {
    private let vo: AttendanceRecordVO
    
    fileprivate init(vo: AttendanceRecordVO) {
        self.vo = vo
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 68)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.gray8)
            
            HStack(spacing: 0) {
                LoadableImageView(imageUrl: vo.profileImageUrl, size: 48)
                    .padding(.trailing, 19)
                
                Text(vo.userName)
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.mainWhite)
                
                Spacer()
            }
            .padding(.horizontal, 14)
        }
    }
}
